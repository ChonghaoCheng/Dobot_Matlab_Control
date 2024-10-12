function [Control_Value] = Cal_control(X_deviation,RobotPosition)%,error)

    X_d= X_deviation(1);
    Y_d = X_deviation(2);
    Theta_d = X_deviation(3);
    
    X_rp = RobotPosition(1);
    Y_rp = RobotPosition(2);

    
    Rot = [cos(Theta_d) -sin(Theta_d);
            sin(Theta_d) cos(Theta_d)];
    
    control = Rot*[X_d;Y_d];


    X_ctrl = X_rp + control(1);
    Y_ctrl = Y_rp + control(2);
    
    Control_Value = [X_ctrl,Y_ctrl];

end

