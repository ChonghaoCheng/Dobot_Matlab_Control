function [Robot_pose_on_Plane] = Robot_pose_projection(Obv,Robot,Step)
    
    for i =1:Step+1
        X = Obv(i,1);
        Y = Obv(i,2);
        Theta = Obv(i,3);
        Rot = [cos(Theta),-sin(Theta);
                sin(Theta),cos(Theta)];
         Robot_pose_on_Plane(i,:) =inv(Rot)*(Robot(i,:)-[X,Y])';
    end

end

