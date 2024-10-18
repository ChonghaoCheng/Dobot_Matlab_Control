function [Distance_devide_Step] = Cal_Point_distance(Robot,Target,step)
    Sum = 0;
    for i= 1:step+1
        X_R = Robot(i,1);
        Y_R = Robot(i,2);
        X_T = Target(i,1);
        Y_T = Target(i,2);
        Distance= sqrt((X_R-X_T)^2+(Y_R-Y_T)^2);
        Sum = Sum +Distance;
    end

    Distance_devide_Step = Sum/step;

     
end

