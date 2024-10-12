function [Ground_Truth] = Get_sensor_data(step)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

    X_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    Y_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
    Theta_sensor = [0.1,0,0,0,0,0,0,0,0,0,0]';

    x_gt= X_sensor(step);
    y_gt= Y_sensor(step);
    theta_gt= Theta_sensor(step);

    Ground_Truth=[x_gt,y_gt,theta_gt];

end

