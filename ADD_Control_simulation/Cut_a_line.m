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
Control_error_sum = 0;
%EM_data is represent Paper Motion is based on pre-step
EM_data = 0;
%control and update robot position

int8 step;
for step =1:Total_step
    %Current paper motion is based on previous paper position
    % EM_data = EM_data+[Update_Line(Ground_Truth(step,:),Ground_Truth(step,1:2)),Ground_Truth(step,3)];
    
    %Trans paper motion to global base
    X_obv(end+1,:) = Get_Obv(Ground_Truth(step,:)); 

    %add noise to obv to simulate em reading 
    %Used in cal control only
    X_obv_N(end+1,:) = Get_Obv_Noise(Ground_Truth(step,:));

    X_obv_deviation =Cal_obv_devi(X_obv_N,step,Target_line);
    % X_obv_deviation =Cal_obv_devi(X_obv_Noise,step,Target_line);

    % Control_value(step,:) = Cal_control_input();

    
    %Control method U0 : No control
    Control_value(step,:) = Cal_control(Target_line,X_obv_N,X_robo,step,X_obv_deviation);
    X_robo(end+1,:)=Robot_move(X_robo(end,:),Control_value(step,:));
    
    %Control method U1 : P control
    Control_value_P(step,:) = Cal_control_P(Target_line,X_obv_N,X_robo_P,step,X_obv_deviation);
    X_robo_P(end+1,:)=Robot_move(X_robo_P(end,:),Control_value_P(step,:));
    

    %Control method U2 : P control + compansation
    Control_value_P_C(step,:) = Cal_control_P_C(Target_line,X_obv_N,X_robo_P_C,step,X_obv_deviation);
    X_robo_P_C(end+1,:)=Robot_move(X_robo_P_C(end,:),Control_value_P_C(step,:));
    
    %Control method U3 : PI control
    X_robo_current_PI = X_robo_PI(end,:);
    current_error = X_robo_current_PI-Transform_target(step,:);
    Control_error_sum = Control_error_sum+abs(current_error);
    Control_value_PI(step,:) = Cal_control_PI(Target_line,X_obv_N,X_robo_PI,step,X_obv_deviation,Control_error_sum);
    X_robo_PI(end+1,:) = Robot_move(X_robo_PI(end,:),Control_value_PI(step,:));
    

    %According to next obv project the target point from EM-Local to Global base,
    %The aim is to compare robotend-effector movement with 
    % the Target_line movement in Global base at same time.
    
    Transform_target(end+1,:) = Update_Line(X_obv(step+1,:),Target_line(step+1,:));
    

    %Calculate error in current step
    % error(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
    %     X_robo_plane(step,:),X_robo_plane(step+1,:),width);
    % error1(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
    %     X_robo_plane1(step,:),X_robo_plane1(step+1,:),width);
    % error2(step) = Cal_step_error(Target_line(step,2),Target_line(step+1,2), ...
    %     X_robo_plane2(step,:),X_robo_plane2(step+1,:),width);




    
    % a notice Show step
    % disp(word_e+step+': ');
    % disp(error(step));
    % %pause


end


    X_robo_plane = Robot_pose_projection(X_obv,X_robo,Total_step);
    X_robo_plane_P = Robot_pose_projection(X_obv,X_robo_P,Total_step);
    X_robo_plane_P_C = Robot_pose_projection(X_obv,X_robo_P_C,Total_step);
    X_robo_plane_PI = Robot_pose_projection(X_obv,X_robo_PI,Total_step);

    %% paper base
    figure(f1);
    plot(X_robo_plane(:,1),X_robo_plane(:,2),'g:',LineWidth=1.5);
    plot(X_robo_plane_P(:,1),X_robo_plane_P(:,2),'b*-',LineWidth=1.5);
    plot(X_robo_plane_P_C(:,1),X_robo_plane_P_C(:,2),'c-',LineWidth=1.5);
    plot(X_robo_plane_PI(:,1),X_robo_plane_PI(:,2),'r:.',LineWidth=1.5);
    plot(Target_line(:,1),Target_line(:,2),"ko--",LineWidth=1.5);
    legend('Raw','P','P+C','PI','Target');
    hold on;

    %%Global base
    figure(f2);
    plot(X_robo(:,1),X_robo(:,2),'g:',LineWidth=1.5);
    plot(X_robo_P(:,1),X_robo_P(:,2),'b*-',LineWidth=1.5);
    plot(X_robo_P_C(:,1),X_robo_P_C(:,2),'c-',LineWidth=1.5);
    plot(X_robo_PI(:,1),X_robo_PI(:,2),'r:.',LineWidth=1.5);
    plot(Transform_target(:,1),Transform_target(:,2),"k--",LineWidth=1.5)
    legend('Raw','P','P+C','PI','Target');
    hold on;

hold off

S_No=abs(trapz(X_robo_plane(:,1),X_robo_plane(:,2))-trapz(Target_line(:,1),Target_line(:,2)))
S_P =abs(trapz(X_robo_plane_P(:,1),X_robo_plane_P(:,2))-trapz(Target_line(:,1),Target_line(:,2)))
S_P_C =abs(trapz(X_robo_plane_P_C(:,1),X_robo_plane_P_C(:,2))-trapz(Target_line(:,1),Target_line(:,2)))
S_PI =abs(trapz(X_robo_plane_PI(:,1),X_robo_plane_PI(:,2))-trapz(Target_line(:,1),Target_line(:,2)))

Dis_No= Cal_Point_distance(X_robo_plane,Target_line,Total_step)
Dis_P = Cal_Point_distance(X_robo_plane_P,Target_line,Total_step)
Dis_P_C = Cal_Point_distance(X_robo_plane_P_C,Target_line,Total_step)
Dis_PI = Cal_Point_distance(X_robo_plane_PI,Target_line,Total_step)

Mse_No = mse(X_robo,Transform_target)
Mse_P = mse(X_robo_P,Transform_target)
Mse_P_C = mse(X_robo_P_C,Transform_target)
Mse_PI = mse(X_robo_PI,Transform_target)
% %disp(error)
% disp(word_e_sum+ error_sum)
% disp(word_e_sum+ error_sum1)
% disp(word_e_sum+ error_sum2)









