%set up initial values
run Config.m
figure(f1);
plot(Target_line(:,1),Target_line(:,2),"b*--");
hold on;

%control and update robot position

int8 step;
for step =1:10
    
    X_obv(end+1,:) = Get_Obv(Ground_Truth,step); 

    Control_value(step,:) = Cal_control(Target_line,X_obv,X_robo,step);%y_truth,);

    % Control_value(step,:) = Cal_control_input();

    X_robo_current = X_robo(end,:);
    X_robo_next = X_robo_current + Control_value(step,:);
    X_robo(end+1,:) = X_robo_next;
    X_robo_plane(end+1,:) = Robot_pose_projection(X_obv(step+1,:),X_robo_next);

    %According to next obv project the target point from EM-Local to Global base,
    %The aim is to compare robotend-effector movement with 
    % the Target_line movement in Global base at same time.
    Transform_target(end+1,:) = Update_Line(X_obv(step+1,:),Target_line(step+1,:));
    
    error(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
        X_robo_plane(step,:),X_robo_plane(step+1,:),width);

    %EM-Local base 
    figure(f1);
    plot(X_robo_plane(:,1),X_robo_plane(:,2),'ro-');
    hold on;

    %Global base
    figure(f2);
    plot(X_robo(:,1),X_robo(:,2),'gv-');
    plot(Transform_target(:,1),Transform_target(:,2),"b-*")
    hold on;
    

    disp(word_e+step+': ');
    disp(error(step));
    %pause

    %if cut through break
    if X_robo_plane(end,1)>= x_truth
       break
    end

end


% plot(Target_line(:,1),Target_line(:,2),"b*--");
% plot(X_robo(:,1),X_robo(:,2),'gv-');
% plot(X_robo_plane(:,1),X_robo_plane(:,2),'ro-');

hold off

error_sum = sum(error);

%if not cut through，the left area will be all counted into error
if X_robo_plane(end,1)<width
    rest = (width-X_robo_next(1))*y_truth;
    error_sum = error_sum+rest;
end

%disp(error)
disp(word_e_sum+ error_sum)









