% set up dobot
% run Dobot_config.m
%set up initial values
clc;
clear all;
close all;
% rosshutdown;
% %% Start Dobot Magician Node
% rosinit;
run Config.m

%Sum of deviation between robot position and target point
%Used in PI control method 
Control_error = 0;
%EM_data is represent Paper Motion is based on pre-step
EM_data = 0;
%control and update robot position

int8 step;
for step =1:20
    %Current paper motion is based on previous paper position
    EM_data = EM_data+Ground_Truth(step,:);
    
    %Trans paper motion to global base
    X_obv(end+1,:) = Get_Obv(EM_data); 

    %add noise to obv to simulate em reading 
    %Used in cal control only
    X_obv_N(end+1,:) = Get_Obv_Noise(EM_data);

    X_obv_deviation =Cal_obv_devi(X_obv_N,step,Target_line);
    % X_obv_deviation =Cal_obv_devi(X_obv_Noise,step,Target_line);

   
    

    % Control_value(step,:) = Cal_control_input();
    
    %Control method U1 : P control
    Control_value(step,:) = Cal_control(Target_line,X_obv_N,X_robo,step,X_obv_deviation);
    X_robo_current = X_robo(end,:);
    X_robo_next = X_robo_current + Control_value(step,:);
    X_robo(end+1,:) = X_robo_next;
    X_robo_plane(end+1,:) = Robot_pose_projection(X_obv(step+1,:),X_robo_next);
    

    %Control method U2 : P control + compansation
    Control_value1(step,:) = Cal_control1(Target_line,X_obv_N,X_robo1,step,X_obv_deviation);
    X_robo_current1 = X_robo1(end,:);
    X_robo_next1 = X_robo_current1 + Control_value1(step,:);
    X_robo1(end+1,:) = X_robo_next1;
    X_robo_plane1(end+1,:) = Robot_pose_projection(X_obv(step+1,:),X_robo_next1);
    
    %Control method U3 : PI control
    X_robo_current2 = X_robo2(end,:);
    current_error = X_robo_current2-Transform_target(step,:);
    Control_error = Control_error+abs(current_error);
    Control_value2(step,:) = Cal_control2(Target_line,X_obv_N,X_robo2,step,X_obv_deviation,Control_error);
    X_robo_next2 = X_robo_current2 + Control_value2(step,:);
    X_robo2(end+1,:) = X_robo_next2;
    X_robo_plane2(end+1,:) = Robot_pose_projection(X_obv(step+1,:),X_robo_next2);

    %According to next obv project the target point from EM-Local to Global base,
    %The aim is to compare robotend-effector movement with 
    % the Target_line movement in Global base at same time.
    
    Transform_target(end+1,:) = Update_Line(X_obv(step+1,:),Target_line(step+1,:));
    

    %Calculate error in current step
    error(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
        X_robo_plane(step,:),X_robo_plane(step+1,:),width);
    error1(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
        X_robo_plane1(step,:),X_robo_plane1(step+1,:),width);
    error2(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
        X_robo_plane2(step,:),X_robo_plane2(step+1,:),width);




    
    % a notice Show step
    disp(word_e+step+': ');
    disp(error(step));
    %pause


end

    %paper base
    figure(f1);
    plot(X_robo_plane(:,1),X_robo_plane(:,2),'g-',LineWidth=1.5);
    plot(X_robo_plane1(:,1),X_robo_plane1(:,2),'b*-',LineWidth=1.5);
    plot(X_robo_plane2(:,1),X_robo_plane2(:,2),'r-',LineWidth=1.5);
    plot(Target_line(:,1),Target_line(:,2),"ko--",LineWidth=1.5);
    legend('u1','u2','u3','Line');
    hold on;

    %Global base
    figure(f2);
    plot(X_robo(:,1),X_robo(:,2),'g-',LineWidth=1.5);
    plot(X_robo1(:,1),X_robo1(:,2),'b-',LineWidth=1.5);
    plot(X_robo2(:,1),X_robo2(:,2),'r-',LineWidth=1.5);
    plot(Transform_target(:,1),Transform_target(:,2),"k--",LineWidth=1.5)
    legend('u1','u2','u3','Line');
    hold on;

% plot(Target_line(:,1),Target_line(:,2),"b*--");
% plot(X_robo(:,1),X_robo(:,2),'gv-');
% plot(X_robo_plane(:,1),X_robo_plane(:,2),'ro-');

hold off

error_sum = sum(error);
error_sum1 = sum(error1);
error_sum2 = sum(error2);
%if not cut through，the left area will be all counted into error
% if X_robo_plane(end,1)<width
%     rest = (width-X_robo_next(1))*y_truth;
%     error_sum = error_sum+rest;
% end

%disp(error)
disp(word_e_sum+ error_sum)
disp(word_e_sum+ error_sum1)
disp(word_e_sum+ error_sum2)









