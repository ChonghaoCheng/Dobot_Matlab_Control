function [Robot_pose_on_Plane] = Robot_pose_projection(Obv,Robot)

    X = Obv(1);
    Y = Obv(2);
    Theta = Obv(3);
    Rot = [cos(Theta),-sin(Theta);
            sin(Theta),cos(Theta)];

    Robot_pose_on_Plane =inv(Rot)*(Robot-[X,Y])';
    
end

