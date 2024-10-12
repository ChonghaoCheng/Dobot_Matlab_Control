function [Difference] = Cal_control(Target_line,Observation,Robot_position,Step)

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

    X_diff = Target_point(1)-X_rp;
    Y_diff = Target_point(2)-Y_rp;
    
    Difference = [X_diff,Y_diff];

end

