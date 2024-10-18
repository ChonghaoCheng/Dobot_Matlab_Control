function [Disturbance] = Get_sensor_data()%step)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    %Sensor ground truth value
    %Sensor is attached at the center of the plane
    %Sensor value means it's relative pose to it's initial position
    
    % X_sensor = [0,0,0,0,0,0,0,0,0,0]';
    % Y_sensor = [0,0,0,0,0,0,0,0,0,0]';
    % Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';
    
    % Y_sensor = [1,0,1,0,1,0,1,0,1,0]';
    % X_sensor = [0,0,0,0,0,0,0,0,0,0]';
    % Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';
    
    % X_sensor = [0,0,0,0,0,0,0,0,0,0]';
    % Y_sensor = [0,0,0,0,0,0,0,0,0,0]';
    % Theta_sensor = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]';
    
    
    % X_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    % Y_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    % Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';
    
    X_sensor = [0.1,0.2,-0.1,-0.2,0.1,-0.1,0.2,-0.2,0.1,-0.1]';
    Y_sensor = [0.1,0.2,-0.1,0,0.1,-0.1,0.2,-0.2,0.1,-0.1]';
    Theta_sensor = [0.1,0.2,0.3,-0.1,-0.2,0,0,0,0,0]';


    % X_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    % Y_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    % Theta_sensor = [0.1,0,0,0,0,0,0,0,0,0,0]';

    % x_gt= X_sensor(step);
    % y_gt= Y_sensor(step);
    % theta_gt= Theta_sensor(step);

    %EM_sensor = rossubscriber(topic);
    % X_sensor = EM_sensor.data.X
    % Y_sensor = EM_sensor.data.Y
    % Theta_sensor = EM_sensor.data.Theta

    Disturbance=[X_sensor,Y_sensor,Theta_sensor];

end

