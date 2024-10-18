function [Obversation] = Get_Obv(Ground_Truth,step)

    Sensor_Data = Ground_Truth(step,:);
    X_gt = Sensor_Data(1);
    Y_gt = Sensor_Data(2);
    Theta_gt = Sensor_Data(3);



    Obversation = [x_o,y_o,theta_o];
    
end

