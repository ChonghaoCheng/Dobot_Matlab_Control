function [Obversation] = Get_Obv(Ground_Truth)

    Sensor_Data = Ground_Truth;
    X_gt = Sensor_Data(1);
    Y_gt = Sensor_Data(2);
    Theta_gt = Sensor_Data(3);

    x_o = X_gt+10;
    y_o = Y_gt+20;
    theta_o =Theta_gt;

    Obversation = [x_o,y_o,theta_o];
    
end

