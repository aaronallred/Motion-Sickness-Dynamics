function [t_s, R,h,hcomp]= Observer_Optimize(time,motion,s,varargin)
% Inputs
%
% time := model simulation time as a Nx1 vector congruent with model motion 
%
% motion := model simulation models as a Nx6 array with inputs 
% corresponding to wx wy wz x y z
%
% s := motion sickness model parameters in a 8x1 or 1x8 vector
%
% Glevel := the 4th argument (optional). If no input, gravity is 1g down
% in respect to the human observer
%
% plotflag := the 5th argument (optional) for plotting perceptions
% 0: No plots
% 1: GIF
% 2: Gravity Level
% 3: Angular Velocity of wz
%
% Filter := the 6th argument (optional) for using filtered conflicts model
% 0: No Filter
% 1: Low-pass filter
%
%% Initialize
model = 'observerModel_MS';

if nargin > 5
    if varargin{3} == 1
        model = 'observerModel_MS_Filter';
        cfomega_high = 2*pi*0.49;
        cfomega_low = 2*pi*0.01;
        filterorder = 4;
        filtergain = 1.0;
        s(1:3)=s(1:3)*filtergain;
    end
end

% Model Parameters
Kea = s(1)^(1/2)*[1 1 1]; %#ok<*NASGU> %g
Kew = s(2)^(1/2)*[1 1 1]; %rad/s
Kef = s(3)^(1/2)*[1 1 1]; %rad/s

% Fast Path parameters
Kfast = s(4);   %good
beta1 = s(8); %codes as beta1
df = 1; %Omans critically damped

dz_end = s(5);
ms_exp = s(6);

beta2 = s(7);

%% Initialize Motion
initializer_array = zeros(length(time),24);

x_in = motion(:,1:3);
omega_in = motion(:,4:6);
xv_in = [initializer_array(:,8),initializer_array(:,9),initializer_array(:,10)];
xvdot_in = [initializer_array(:,11),initializer_array(:,12),initializer_array(:,13)];
omegav_in = [initializer_array(:,14),initializer_array(:,15),initializer_array(:,16)];
gv_in = [initializer_array(:,17),initializer_array(:,18),initializer_array(:,19)];
g_variable_in =initializer_array(:,20);
pos_ON =initializer_array(:,21);
vel_ON =initializer_array(:,22);
angVel_ON =initializer_array(:,23);
g_ON =initializer_array(:,24);

%% Simulation 
% Time and Tolerance Properties set by data input file to ensure a correct
% sampling rate.
delta_t = time(2) - time (1);
duration = length(time)*delta_t;
sample_rate = 1/delta_t;
t = time;
tolerance = 0.02;

% Differentiate Position to Velcoity and Acceleration
v_in = zeros(size(x_in,1),3);
v_in(1:size(x_in,1)-1,:) = diff(x_in,1)/delta_t;

a_in = zeros(size(x_in,1),3);
a_in(1:size(x_in,1)-2,:) = diff(x_in,2)/(delta_t*delta_t);

% Initial Conditions 
%Initialize the GRAVITY input to the model [gx0 gy0 gz0]'
if nargin > 3
    G0 = varargin{1};
else
    ground_truth = 1;
    G0 = [0 0 -ground_truth].*ones(length(time),1); 
end

% Initialize the internal GRAVITY STATE of the model
hypo = 1;
GG0 =[0 0 -hypo]';

% Tilt Angle
g_x = 0;
g_y = 0;
g_z = -1;
g_mag = sqrt(g_x*g_x + g_y*g_y + g_z*g_z);
g_norm = [g_x/g_mag g_y/g_mag g_z/g_mag]';
assignin('base', 'g_norm', g_norm);

% Initialize Quaternions
if g_norm(1) == G0(1) && g_norm(2) == G0(2)
    Q0 = [1 0 0 0]';
    VR_IC = [0 0 0 0];
else
    % Perpendicular Vector
    E_vec = cross(g_norm,[0 0 -1]);
    % Normalize E vector
    E_mag = sqrt(E_vec(1)*E_vec(1) + E_vec(2)*E_vec(2) + E_vec(3)*E_vec(3));
    E = E_vec./E_mag;
    % Calculate Rotation angle
    E_angle = acos(dot(g_norm,[0 0 -1]));
    % Calculate Quaternion
    Q0 = [cos(E_angle/2) E(1)*sin(E_angle/2) E(2)*sin(E_angle/2) E(3)*sin(E_angle/2)]';
    VR_IC = [E,E_angle];
end

% Preload Idiotropic Vecdtor
h = [0 0 -1];
% Preload Idiotropic Bias
w = 0;

% Initialize scc time constants [x y z]'
tau_scc_value = 5.7;
tau_scc=tau_scc_value*[1 1 1]';

%Internal Model SCC Time Constant is Set to CNS time constant,
tau_scc_cap=tau_scc;

% Initialize scc adaptation time constants
tau_a_value = 80;
tau_a=tau_a_value*[1 1 1]';
% Initialize the low-pass filter frequency for scc
f_oto = 2;
% Initialize the lpf frequency for otolith
f_scc = 2;
% Initialize the Ideotropic Bias Amount 'w'
W = 0;
% Initialize Kww feedback gain
kww = 8*[1 1 1]';
% Initialize Kfg feedback gain
kfg = 4*[1 1 1]';
% Initialize Kfw feedback gain
kfw = 8*[1 1 1]';
% Initialize Kaa feedback gain
kaa = -4*[1 1 1]';
% Initialize Kwg feedback gain
kwg = 1*[1 1 1]';
% Initialize Kvg feedback gain
kgvg = 5*[1 1 1]';
% Initialize Kvw feedback gain
kwvw = 10*[1 1 1]';
% Initialize Kxdotva feedback gain
kxdotva = 0.75*[1 1 1]';
% Initialize Kxvv feedback gain
kxvv = 0.1*[1 1 1]';
% Initialize Visual Position LPF Frequency
f_visX = 2;
% Initialize Visual Velocity LPF Frequency
f_visV = 2;
% Initialize Visual Angular Velocity LPF Frequency
f_visO = 0.2;
% Initialize Graviceptor Gain
oto_a = 60*[1 1 1]';
% Initialize Adapatation time constant
oto_Ka = 1.3*[1 1 1]';
% Initialize  X Leaky Integration Time Constant
x_leak = 0.6;
% Initialize  Y Leaky Integration Time Constant
y_leak = 0.6;
% Initialize  X Leaky Integration Time Constant
z_leak = 10;

% If we want to input straight acceleration NEED TO COMMENT OUT ABOVE and
% uncomment the below. Note that Actual Position and Actual velocity plots
% will be innaccurate if we do so.
%a_in = x_in;
%v_in = a_in;

IrmakTuned = 0;
if IrmakTuned == 1
    kaa = -3.2*[1 1 1]';
    kww = 2.28*[1 1 1]';
    kfw =    0*[1 1 1]';
    kfg = 15.4*[1 1 1]';
end

FixEVAR = 0;
if FixEVAR == 1
    kww = 2.28*[1 1 1]';
end

AllredTuned = 0;
if AllredTuned == 1
    kaa = -3.2*[1 1 1]';
    kww = 2.28*[1 1 1]';
    kfw =    8*[1 1 1]';
    kfg = 4*[1 1 1]';
end

C2 = 0;
if C2 == 1
    kaa = -2*[1 1 1]';
    kww = 3*[1 1 1]';
    kfw =    1*[1 1 1]';
    kfg = 1*[1 1 1]';
end


tic;
% Execute Simulink Model
options=simset('Solver','ode45','MaxStep',tolerance,'RelTol',tolerance,'AbsTol',tolerance,'SrcWorkspace','current');
warning ('off','all');
if strcmp(model,'observerModel_GVS') == 1
    [t_s, XDATA, a_est, gif_est, gif_head, a_head, omega_head,g_head,g_est,omega_est,x_est,lin_vel_est,lin_vel,x,alpha_omega,alpha_OTO_pre] = sim(model,duration,options,[]); %#ok<*ASGLU>
else
    [t_s, XDATA, a_est, gif_est, gif_head, a_head, omega_head,g_head,g_est,omega_est,x_est,lin_vel_est,lin_vel,x,alpha_omega,e_w,e_f,e_a,R,h,F,S,I,N,ea_hpf] = sim(model,duration,options,[]);
end
warning ('on','all');

% Calculate Time of simulation
sim_Time = num2str(toc);

%% Compute Extra Variables
% Bring variables from GUI to workspace
sim_time = t_s;

%Calculate Angular Accelerations for SDAT
%Calculate the time step from simulink
sim_dt = t_s(size(t_s,1)) - t_s(size(t_s,1)-1);

omega_dot_head = zeros(size(omega_head,1),3);
omega_dot_head(1:size(omega_head,1)-1,:) = diff(omega_head,1)/sim_dt;

omega_dot_est = zeros(size(omega_est,1),3);
omega_dot_est(1:size(omega_est,1)-1,:) = diff(omega_est*180/pi,1)/sim_dt;

assignin('base', 'omega_dot_head', omega_dot_head);
assignin('base', 'omega_dot_est', omega_dot_est);
assignin('base', 'sim_dt', sim_dt);

%Calculate Vertical, SVV, Tilt, and Estimated Tilt, along with Errors
tilt_estTEMP(:,1) = tilt_est(1,1,:); %#ok<*NODEF>
tiltTEMP(:,1) = tilt(1,1,:);
tilt = tiltTEMP;
tilt_est = tilt_estTEMP;
SVV = SVV*180/3.14159;
SVV_est = SVV_est*180/3.14159;
tilt = real(tilt*180/3.14159);
tilt_est = real(tilt_est*180/3.14159);
plot_SVV(:,1) = SVV;
plot_SVV(:,2) = SVV_est;
plot_tilt(:,1) = tilt;
plot_tilt(:,2) = tilt_est;

%% Perception plots
if nargin > 4 
    plotflag = varargin{2};
else
    plotflag = 0;
end

if plotflag == 1
    figure;
    subplot(3,1,1)
    hold on
    plot(t_s,a_est(:,1))
    plot(t_s,a_head(:,1))
    xlabel('Time (sec)','FontSize',12);
    ylabel('G''s','FontSize',12);
    legend('Gx_{est}','Gx_{act}')
    hold off

    subplot(3,1,2)
    hold on
    plot(t_s,a_est(:,2))
    plot(t_s,a_head(:,2))
    xlabel('Time (sec)','FontSize',12);
    ylabel('G''s','FontSize',12);
    legend('Gy_{est}','Gy_{act}')
    hold off

    subplot(3,1,3)
    hold on
    plot(t_s,a_est(:,3))
    plot(t_s,a_head(:,3))
    xlabel('Time (sec)','FontSize',12);
    ylabel('G''s','FontSize',12);
    legend('Gz_{est}','Gz_{act}')
    hold off
elseif plotflag == 2
    figure;
    hold on
    plot(t_s,e_a)
    plot(t_s,e_w)
    plot(t_s,e_f)
    xlabel('Time (sec)','FontSize',12);
    ylabel('G''s','FontSize',12);
    legend('ea','ew','ef')
    hold off
elseif plotflag == 3
    LW = 4; FS = 16;
    figure;
    hold on
    plot(t_s,omega_head(:,3)*pi/180,'LineWidth',LW)
    plot(t_s,omega_est(:,3),'LineWidth',LW)
    hold off
    xlabel('Time (sec)','FontSize',12);
    ylabel('\omega_z (rad/s)','FontSize',12);
    legend('Actual','Perceived')
    set(gca,'FontSize',FS)
elseif plotflag == 4
    LW = 4; FS = 16;
    fullGIFtilt = abs(acosd((gif_head*[0 0 -1]')./vecnorm(gif_head,2,2)));
    fulltiltest = abs(acosd((g_est*[0 0 -1]')./vecnorm(g_est,2,2)));
    yzGIFtilt = abs(atand(gif_head(:,2)./gif_head(:,3)));
    rolltiltest = abs(atand(g_est(:,2)./g_est(:,3)));
    figure;
    hold on
    plot(t_s,yzGIFtilt,'LineWidth',LW)
    plot(t_s,rolltiltest,'LineWidth',LW)
    hold off
    xlabel('Time (sec)','FontSize',12);
    ylabel('Tilt (deg/s)','FontSize',12);
    legend('GIF Angle','Perceived Tilt')
    set(gca,'FontSize',FS)
end

hcomp = [e_a,e_w,e_f];

end