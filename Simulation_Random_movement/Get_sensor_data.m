function [Disturbance] = Get_sensor_data(step)

    %Sensor ground truth value
    %Sensor is attached at the center of the plane
    %Sensor value means it's relative pose to it's previous position
    

    %% No movement
    % X_sensor = zeros(1,step);
    % Y_sensor = zeros(1,step);
    % Theta_sensor = zeros(1,step);
    % Disturbance=[X_sensor',Y_sensor',Theta_sensor'];

    %% Regular Y Movement
    % Y_sensor = linspace(0,20,step)';
    % X_sensor = zeros(step,1);
    % Theta_sensor = zeros(step,1);
    % Disturbance=[X_sensor,Y_sensor,Theta_sensor];
    
     
    %% Regular Rotation Movement
    % X_sensor = zeros(step,1);
    % Y_sensor = zeros(step,1);
    % Theta_sensor = linspace(0,0.05,step) ;
    % Disturbance=[X_sensor,Y_sensor,Theta_sensor'];

    % %% Random Movement
    rng( 'default' );
    sensor=randn(3,20);
    sensor_expand = zeros(3,step);
    factor = step/20;
    sensor_expand(:,1:factor:end) = sensor;
    X_sensor = sensor_expand(1,:)/200000;
    Y_sensor = sensor_expand(2,:)/200000;   
    Theta_sensor = sensor_expand(3,:)/100;

    Disturbance=[X_sensor',Y_sensor',Theta_sensor'];



    %% True EM Reading
    % EM_sensor = rossubscriber(topic);
    % X_sensor = EM_sensor.data.X
    % Y_sensor = EM_sensor.data.Y
    % Theta_sensor = EM_sensor.data.Theta

    % Disturbance=[X_sensor,Y_sensor,Theta_sensor];
    
end

