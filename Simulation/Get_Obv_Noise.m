function [Obversation] = Get_Obv_Noise(Ground_Truth)

    Sensor_Data = Ground_Truth;
    X_gt = Sensor_Data(1);
    Y_gt = Sensor_Data(2);
    Theta_gt = Sensor_Data(3);
    
    noise = randn(3,1)/500;

    x_o = X_gt+10+noise(1);
    y_o = Y_gt+20+noise(2);
    theta_o =Theta_gt+noise(3);

    Obversation = [x_o,y_o,theta_o];
    
end

