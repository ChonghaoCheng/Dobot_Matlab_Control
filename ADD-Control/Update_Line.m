function [Transform_target] = Update_Line(Observation,Target)
%Update the target line when the plane moved
    X_o = Observation(1);
    Y_o = Observation(2);
    Theta_o = Observation(3);


    Rot = [cos(Theta_o) -sin(Theta_o);
        sin(Theta_o) cos(Theta_o)];



    Transform_target = (Rot*Target'+[X_o;Y_o])';

end

