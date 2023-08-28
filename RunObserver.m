function [t_s, R,h,hcomp]= RunObserver(time,motion,Glevel)

% Model Parameters from Optimization
%     Wa      Ww       Wf        K     I0     n      tau_s   tau_f
s = [6.7175 11.7004 561.9546 91.2858 0.0001 0.3226 483.2565 73.7873];
%% Initialize

model = 'observerModel_MS';

% Model Parameters
Kea = s(1)^(1/2)*[1 1 1]; %g
Kew = s(2)^(1/2)*[1 1 1]; %rad/s
Kef = s(3)^(1/2)*[1 1 1]; %rad/s

% Fast Path parameters
Kfast = s(4);   %good
beta1 = s(8); %codes as beta1
df = 1; %Omans critically damped

dz_end = s(5);
ms_exp = s(6);

beta2 = s(7);

%% Simulation 
% Build Inputs to Simulink
input_file = zeros(length(time),24);
x_in = motion(:,1:3);
omega_in = motion(:,4:6);
xv_in = [input_file(:,8),input_file(:,9),input_file(:,10)];
xvdot_in = [input_file(:,11),input_file(:,12),input_file(:,13)];
omegav_in = [input_file(:,14),input_file(:,15),input_file(:,16)];
gv_in = [input_file(:,17),input_file(:,18),input_file(:,19)];
g_variable_in =input_file(:,20);
pos_ON =input_file(:,21);
vel_ON =input_file(:,22);
angVel_ON =input_file(:,23);
g_ON =input_file(:,24);

% Time and Tolerance Properties set by data input file to ensure a correct
% sampling rate.
delta_t = time(2) - time (1);
duration = length(time)*delta_t;
sample_rate = 1/delta_t;
t = time;
tolerance = 0.02;

% Differentiate Position to Velcoity to Acceleration
v_in = zeros(size(x_in,1),3);
v_in(1:size(x_in,1)-1,:) = diff(x_in,1)/delta_t;

a_in = zeros(size(x_in,1),3);
a_in(1:size(x_in,1)-2,:) = diff(x_in,2)/(delta_t*delta_t);

a_omega = zeros(size(x_in,1),3);
a_omega(1:size(x_in,1)-1,:) = diff(omega_in,1)/(delta_t);

% Differentiation SSC
Tilt = cumtrapz(time,omega_in);
GVS_OTO_in = zeros(length(time),3);
% GVS_OTO_in(:,2:3) =  [sind(Tilt(:,1)) -sind(Tilt(:,1))];
GVS_SCC_in =  zeros(length(time),3);

% bipolar (config A)
mA = sind(Tilt(:,1))/1;
GVS_OTO_in(:,2:3) = [mA -mA]; % y-z plane afferents
GVS_SCC_in(:,3) = mA; % wz afferent only
% GVS_current_in = -GVS_OTO_in;

% Initial Conditions 
ground_truth = Glevel;
hypo = 1;
%Initialize the GRAVITY input to the model [gx0 gy0 gz0]'
G0 = [0 0 -ground_truth]'; 
% Initialize the internal GRAVITY STATE of the model
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
    E_vec = CROSS(g_norm,[0 0 -1]);
    % Normalize E vector
    E_mag = sqrt(E_vec(1)*E_vec(1) + E_vec(2)*E_vec(2) + E_vec(3)*E_vec(3));
    E = E_vec./E_mag;
    % Calculate Rotation angle
    E_angle = acos(DOT(g_norm,[0 0 -1]));
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

tic;
% Execute Simulink Model
options=simset('Solver','ode45','MaxStep',tolerance,'RelTol',tolerance,'AbsTol',tolerance,'SrcWorkspace','current');
warning ('off','all');
[t_s, XDATA, a_est, gif_est, gif_head, a_head, omega_head,g_head,g_est,omega_est,x_est,lin_vel_est,lin_vel,x,alpha_omega,e_w,e_f,e_a,R,h,F,S,I,N,ea_hpf] = sim(model,duration,options,[]);
warning ('on','all');

% Calculate Time of simulation
sim_Time = num2str(toc);

hcomp = [e_a,e_w,e_f];
end