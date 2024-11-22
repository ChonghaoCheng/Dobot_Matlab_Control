function [Disturbance] = Get_sensor_data(step)

    %Sensor ground truth value
    %Sensor is attached at the center of the plane
    %Sensor value means it's relative pose to it's previous position
    

    %% No movement
    % X_sensor = zeros(1,step);
    % Y_sensor = zeros(1,step);
    % Theta_sensor = zeros(1,step);
    % Disturbance=[X_sensor',Y_sensor',Theta_sensor'];


    % step = step-10;
    % %% Random Movement
    rng( 'default' );
    sensor=randn(3,20);
    sensor_expand = zeros(3,step);
    factor = step/20;
    sensor_expand(:,1:factor:end) = sensor;
    X_sensor = (sensor_expand(1,:)/100)';
    Y_sensor = (sensor_expand(2,:)/100)';   
    Theta_sensor = (sensor_expand(3,:)/100)';

        

    % Disturbance_stop = zeros(10,3);
    % Disturbance=[X_sensor,Y_sensor,Theta_sensor];

    % step = step+10;

    % for i = 1:10
    %     Disturbance_stop(i,:) = Disturbance(end,:); 
    % end
    % X_sensor = [X_sensor;Disturbance_stop(:,1)];
    % Y_sensor = [Y_sensor;Disturbance_stop(:,2)];
    % Theta_sensor = [Theta_sensor;Disturbance_stop(:,3)];
    Disturbance=[X_sensor,Y_sensor,Theta_sensor];


    
end

