function [model_time, model_motion, Glevel] = CianParadigm()

    % Cian Simulation
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
    
    recovery = (model_time(end)+dt:dt:model_time(end)+20*60+endtime)';
    recovery_motion = flip(model_motion(1:endtime/dt,:));
    recovery_motion(:,6) = 0;
    recovery_motion(1:(endtime-starttime)/dt,6) = linspace(model_motion(end,6),0,(endtime-starttime)/dt)';
    model_time = [model_time;recovery];
    model_motion = [model_motion;recovery_motion;zeros(length(recovery)-length(recovery_motion),6)];
    
    Glevel = [0 0 -1].*ones(length(model_time),1);
end