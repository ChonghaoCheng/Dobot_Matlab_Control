function [Disturbance] = Get_sensor_data(step)

    %Sensor ground truth value
    %Sensor is attached at the center of the plane
    %Sensor value means it's relative pose to it's previous position
    

    %% No movement
    % X_sensor = zeros(1,step);
    % Y_sensor = zeros(1,step);
    % Theta_sensor = zeros(1,step);
    % Disturbance=[X_sensor',Y_sensor',Theta_sensor'];

    % Regular Y Movement
    Y_sensor = linspace(0,5,step)';
    X_sensor = zeros(step,1);
    Theta_sensor = zeros(step,1);
    Disturbance=[X_sensor,Y_sensor,Theta_sensor];
    
     
    %% Regular Rotation Movement
    % X_sensor = zeros(step,1);
    % Y_sensor = zeros(step,1);
    % Theta_sensor = linspace(0,0.05,step) ;
    % Disturbance=[X_sensor,Y_sensor,Theta_sensor'];

    
end

