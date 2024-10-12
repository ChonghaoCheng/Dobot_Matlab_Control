function [Robot_pose_on_Plane] =Rob2Paper(Papermotion,Robot)
    Robot_pose_on_Plane = [-10,0]';

    for i=1:(size(Papermotion(:,1))-1)
        Obv = Papermotion(i+1,:);
        X = Obv(1);
        Y = Obv(2);
        Theta = Obv(3);
        Rot = [cos(Theta),-sin(Theta);
                sin(Theta),cos(Theta)];
        Robot_pose_on_Plane(:,end+1) =inv(Rot)*(Robot(i+1,:)-[X,Y])';
    end


end

