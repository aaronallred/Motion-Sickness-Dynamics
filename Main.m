% Example Simulator
% Created by: Aaron Allred
% Date: 3/3/2023
clc;clear;

% Set to 'Custom' for a custom profile
% Set to 'Cian' for Cian et al. (2011) OVAR motion
% Set to 'Gravity Transition' for a 1g to 0g trans. w/o adaptation
motiontype = 'Cian';

%% Define Motion Profile

switch motiontype
    case 'Custom'
        % Define motion profile length
        TotalTime = 60*60; % seconds
        t0 = 0.1; % model sim sec

        %initialization
        dt = t0; %sec
        model_time = (t0:dt:TotalTime)';
        model_motion = [0 0 0 0 0 0].*model_time; 

        % Model Motion for simulation
        % columns 1-3 are xyz position
        % columns 4-6 are xyz rotations
        freq = 0.3;
        amp = 3.6 /((2*pi*freq)^2); % yposition amplitude
        model_motion(:,2) = amp*sin(freq*2*pi*(model_time));
        
        % Glevel is the Gravity Environment
        Glevel = 1;

        tidx = 1:round(1/freq/dt*3); % time indeces to plot

    case 'Gravity Transition'
        freq = 0.3;
        amp = 0*200 /((2*pi*freq)); % wx amplitude
        model_motion = [0 0 0 0 0 0].*model_time; %initialize 
        model_motion(:,4) = amp*cos(freq*2*pi*(model_time));
        Glevel = 0.00;

        tidx = 1:round(1/freq/dt*3); % time indeces to plot
        
    case 'Cian'
        % Cian Simulation
        Glevel = 1.00;
        T = 60*20+132; %seconds
        dt = 0.1;
        model_time = (0:dt:T)';
        model_motion = [0 0 0 0 0 0].*zeros(length(model_time),1);
        
        starttime = 132;
        endtime = 150;
        ang = 18; %degrees

        RotSpeed = ang/(endtime-starttime);
        % Human Reference Frame motions
        YawSpeed = model_time*(1); YawSpeed(YawSpeed >72) = 72;
        YawAngle = cumtrapz(model_time,YawSpeed);
        RollSpeed = model_time*0;
        PitchSpeed = model_time*0;
        
        RvE = [1;0;0]; % tilt vector in Earth system
        
        for i = 1:length(model_time)
            
            if model_time(i) >= starttime && model_time(i) < endtime
                Rx = [1 0 0;0 cosd(ang) -sind(ang);0 sind(ang) cosd(ang)];
                Rz = [cosd(YawAngle(i)) -sind(YawAngle(i)) 0;sind(YawAngle(i)) cosd(YawAngle(i)) 0; 0 0 1];
                RvH = (Rz\(Rx\RvE))';
                model_motion(i,4:6) = [RollSpeed(i) PitchSpeed(i) YawSpeed(i)]+...
                                      RvH*RotSpeed;
            else
                model_motion(i,4:6) = [RollSpeed(i) PitchSpeed(i) YawSpeed(i)];
            end
        end
        
        spindowntime = 10;%sec
        recovery = (model_time(end)+dt:dt:model_time(end)+20*60)';
        recovery_motion = linspace(model_motion(end,6),0,spindowntime/dt)';
        model_time = [model_time;recovery];
        model_motion = [model_motion;zeros(length(recovery_motion),5) recovery_motion;zeros(length(recovery)-length(recovery_motion),6)];

        tidx = 1:length(model_time);
end

%% Observer + Oman Motion Sickness Dynamics    
[ts, Ru,h,hcomp] = RunObserver(model_time,model_motion,Glevel);
    
% MISC Output Mapping
time = model_time(1):30:model_time(end);
R = interp1(ts,Ru,time); % Interpolate onto a reduced grid for mapping
R = cont2MISC(R); 

%% Plot
FS = 20; % FontSize
cd = colormap('hsv');

legMotion = {'X-axis Position (m)',...
             'Y-axis Position (m)',...
             'Z-axis Position (m)',...
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