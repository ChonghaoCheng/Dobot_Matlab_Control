function [New_target] = Update_Line(X_deviation,Target)
%Update the target line when the plane moved
    x_o = X_deviation(1);
    y_o = X_deviation(2);
    theta_o = X_deviation(3);


    Rot = [cos(theta_o) -sin(theta_o);
        sin(theta_o) cos(theta_o)];

    New_target = (Rot*Target'+[x_o;y_o])';

end

