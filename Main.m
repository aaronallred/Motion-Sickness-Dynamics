% Example Simulator
% Created by: Aaron Allred
% Date: 3/3/2023
clc;clear;

%% Define motion profile length
TotalTime = 60*60; % seconds
t0 = 0.1; % model sim sec

%initialization
dt = t0; %sec
model_time = (t0:dt:TotalTime)';
model_motion = [0 0 0 0 0 0].*model_time; 

%% Define Motion Profile
freq = 0.3;
amp = 3.6 /((2*pi*freq)^2); % zposition amplitude

% Model Motion for simulation
% columns 1-3 are xyz position
% columns 4-6 are xyz rotations
model_motion(:,2) = amp*sin(freq*2*pi*(model_time));
% Glevel is the Gravity Environment
Glevel = 1;

% freq = 0.3;
% amp = 0*200 /((2*pi*freq)); % wx amplitude
% model_motion = [0 0 0 0 0 0].*model_time; %initialize 
% model_motion(:,4) = amp*cos(freq*2*pi*(model_time));
% Glevel = 0.00;

%% Observer + Oman Motion Sickness Dynamics    
[ts, Ru,h,hcomp] = RunObserver(model_time,model_motion,Glevel);
    
% MISC Output Mapping
time = model_time(1):30:model_time(end);
R = interp1(ts,Ru,time); % Interpolate onto a reduced grid for mapping
R = cont2MISC(R); 

%% Plot
FS = 20; % FontSize
tidx = 1:round(1/freq/dt*3); % time indeces to plot
cd = colormap('jet');

legMotion = {'X-axis Position (m/s^2)',...
             'Y-axis Position (m/s^2)',...
             'Z-axis Position (m/s^2)',...
             'X-axis Rotation (deg/s)',...
             'Y-axis Rotation (deg/s)',...
             'Z-axis Rotation (deg/s)'};

legConflict = {'ea_x (g)';'ea_y (g)';'ea_z (g)';...
               'ew_x (rad/s)';'ew_y (rad/s)';'ew_z (rad/s)';...
               'ef_x (rad)';'ef_y (rad)';'ef_z (rad)'};

figure;tiledlayout(4,1,"TileSpacing",'tight')
nexttile
hold on
for i =1:size(model_motion,2)
    co = interp1(linspace(1,size(model_motion,2),length(cd)),cd,i);
    plot(model_time(tidx)/60,model_motion(tidx,i),'Color',co)
end
hold off
ylabel('Motion','FontSize',FS)
legend(legMotion,'FontSize',FS/2)
set(gca,'FontSize',FS)

nexttile
condition = (ts<model_time(tidx(end)) & ts>model_time(tidx(1)));
hold on
for i = 1:size(hcomp,2)
    co = interp1(linspace(1,size(hcomp,2),length(cd)),cd,i);
    plot(ts(condition)/60,hcomp(condition,i),'Color',co)
end
hold off
ylabel('Conflicts','FontSize',FS)
legend(legConflict','FontSize',FS/2)
set(gca,'FontSize',FS)

nexttile
plot(ts(condition)/60,h(condition),'LineWidth',3,'Color','#008080')
ylabel('h','FontSize',FS)
set(gca,'FontSize',FS)

nexttile
plot(time/60,R,'LineWidth',3,'Color','#ff4040')
xlabel('Time (min)','FontSize',FS)
ylabel('MISC','FontSize',FS)
set(gca,'FontSize',FS)