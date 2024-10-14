function [Control_value] = Cal_control(Target_line,Observation,Robot_position,Step,X_obv_deviation)
    Kp = 0.2;
    
    X_o = Observation(Step,1);
    Y_o = Observation(Step,2);
    Theta_o = Observation(Step,3);
    
    X_rp = Robot_position(Step,1);
    Y_rp = Robot_position(Step,2);

    Aim_x = Target_line(Step+1,1);
    Aim_y = Target_line(Step+1,2);
    
    Rot = [cos(Theta_o) -sin(Theta_o);
            sin(Theta_o) cos(Theta_o)];
    
    Target_point = Rot*[Aim_x;Aim_y]+[X_o;Y_o];
    
    X_diff = X_obv_deviation(1);
    Y_diff = X_obv_deviation(2);
    Theta_diff = X_obv_deviation(3);
    Rot = [cos(Theta_diff) -sin(Theta_diff);
        sin(Theta_diff) cos(Theta_diff)];
     diff = Rot* [X_diff, Y_diff]';
    % X_move = Target_point(1)-X_rp+Kp*X_diff;
    % Y_move = Target_point(2)-Y_rp+Kp*Y_diff;
    X_move = Target_point(1)-X_rp+Kp*(Target_point(1)-X_rp);
    Y_move = Target_point(2)-Y_rp+Kp*(Target_point(2)-Y_rp);
    %     X_move = Target_point(1)-X_rp+Kp*(Target_point(1)-X_rp)+0.08;
    % Y_move = Target_point(2)-Y_rp+Kp*(Target_point(2)-Y_rp)+0.04;
    % X_move = Target_point(1)-X_rp+Kp*(Target_point(1)-X_rp)+Kp2*diff(1);
    % Y_move = Target_point(2)-Y_rp+Kp*(Target_point(2)-Y_rp)+Kp2*diff(2);
    %  X_move = Target_point(1)-X_rp;
    % Y_move = Target_point(2)-Y_rp;


    
    Difference = [X_move,Y_move];
    Control_value = Difference;

end

