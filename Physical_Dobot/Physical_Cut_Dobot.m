% set up dobot
run Dobot_config.m
%set up initial values
run Physical_Config.m

% figure(f1);
% plot(Target_line(:,1),Target_line(:,2),"b*--");
% hold on;

%control and update robot position

int8 step;

startendEffectorPosition = [0.157,0.024,-0.05];
dobot.InitPublishEndEffectorPose(startendEffectorPosition,endEffectorRotation);
for step =1:10
    
   X_obv(end+1,:)= Get_EM_sensor_data(); 
    %  = Get_Obv(Ground_Truth,step);
    X_obv_deviation =Cal_obv_devi(X_obv,step,Target_line);
    Control_value(step,:) = Cal_control(Target_line,X_obv,X_robo,step,X_obv_deviation);

    % Control_value(step,:) = Cal_control(Target_line,X_obv,X_robo,step);%y_truth,);
    
    % Target_point_ROB = (EM2Dobot_R*[82,Target_line(step,:)]'+EM2Dobot_T')/1000+[0,0,0.0051]';

    X_robo_current = X_robo(end,:);
    X_robo_next = X_robo_current + Control_value(step,:);
    X_robo(end+1,:) = X_robo_next;
    % X_robo_plane(end+1,:) = Robot_pose_projection(X_obv(step+1,:),X_robo_next);
    pause

    
    %According to next obv project the target point from EM-Local to Global base,
    %The aim is to compare robotend-effector movement with 
    % the Target_line movement in Global base at same time.
    % Transform_target(end+1,:) = Update_Line(X_obv_deviation,Target_line(step+1,:));
    
    % error(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
        % X_robo_plane(step,:),X_robo_plane(step+1,:),width);

    %EM-Local base 
    % figure(f1);
    % plot(X_robo_plane(:,1),X_robo_plane(:,2),'ro-');
    % hold on;
    % 
    % %Global base
    % figure(f2);
    % plot(X_robo(:,1),X_robo(:,2),'gv-');
    % plot(Transform_target(:,1),Transform_target(:,2),"b-*")
    % hold on;
    % 
    % 
    disp(word_e+step+': ');
    % disp(error(step));
    %pause
    dobot.PublishEndEffectorPose(X_robo_next,endEffectorRotation);
    pause;
    %if cut through break


end


% plot(Target_line(:,1),Target_line(:,2),"b*--");
% plot(X_robo(:,1),X_robo(:,2),'gv-');
% plot(X_robo_plane(:,1),X_robo_plane(:,2),'ro-');

% hold off
% error_sum = sum(error);
% 
% %if not cut through，the left area will be all counted into error
% if X_robo_plane(end,1)<width
%     rest = (width-X_robo_next(1))*y_truth;
%     error_sum = error_sum+rest;
% end
% 
% %disp(error)
% disp(word_e_sum+ error_sum)
% 
finalendEffectorPosition = [X_robo_next(end,:),0.01];
dobot.PublishInitEndEffectorPose(finalendEffectorPosition,endEffectorRotation);
pause(1)
dobot.PublishInitEndEffectorPose(InitendEffectorPosition,endEffectorRotation);








