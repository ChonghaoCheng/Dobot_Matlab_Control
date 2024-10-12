clc;
clear all;
close all;
%Notation List
%word_1 = "Please input control value for next step";
word_e = "current error on step ";
word_e_sum = "Total error in process is: ";

%plane config
width = 20;
longth = 40;

%line_position
x_truth = width;
y_truth = longth/2;
x= 0:2:x_truth;
y= 0:4:longth;

Target_line =([0,0;0,0]*[x;y]+[0;20])';
%Target_line =@(x,y) [0,0;0,0]*[x;y]+[0;20];

%draw working space 
figure;
yline(y_truth,'r','Goal');
xline(x_truth,'b','Width');
ylim([0,40]);
xlim([0,25]);
hold on

%Robot__position_initialization
y_r = [20];
x_r = [0];
X_robo = [x_r,y_r];

%Sensor_initialization
x_o = zeros(10,1);
y_o = zeros(10,1);
theta_o = zeros(10,1);
X_obv = [x_o,y_o,theta_o];

%control_value_initialization
y_u = zeros(10,1);
x_u = zeros(10,1);
U = [x_u,y_u];
error = 0;

%control and update robot position
int8 step;
for step =1:10

    X_obv(step,:) = Get_Obv(X_obv,step); 

    % %calculate observation deviation
    % X_obs = X_obv(step,1);
    % Y_obs = X_obv(step,2);
    % Theta_obs = X_obv(step,3);
    % 
    % if step == 1
    %     X_obs_pre = 0;
    %     Y_obs_pre =Target_line(step,2);
    %     Theta_obs_pre = 0;
    % else
    %     X_obs_pre = X_obv(step-1,1);
    %     Y_obs_pre = X_obv(step-1,2);
    %     Theta_obs_pre = X_obv(step-1,3);
    % end
    % 
    % x_d = X_obs - X_obs_pre;
    % y_d = Y_obs - Y_obs_pre;
    % theta_d = Theta_obs - Theta_obs_pre;
    % X_deviation = [x_d,y_d,theta_d];

    U(step,:) = Cal_control_New(Target_line,X_obv(step,:),X_robo(step,:),step);%y_truth,);

    %U(step,:) = Cal_control_input();

    X_r_current = X_robo(end,:);
    X_r_next = U(step,:);
    plot(X_robo(:,1),X_robo(:,2),'o-');
    X_robo(end+1,:) = X_r_next;


    %collect error in each step
    % New_target = Update_Line(X_deviation,Target_line(step,:));
    % 
    plot(Target_line(step,1),Target_line(step,2),'b-*');
    
    error(step) = Cal_error_sep_new(Target_line(step,2),Target_line(step+1,2),X_r_current,X_r_next,width);
    
    disp(word_e+step+': ');
    disp(error(step));

    %if cut through break
    if X_r_next(1)> width || X_r_next(1)<0
       break
    end
    % Target_line(step+1,:) = New_target;
end

line(Target_line(:,1),Target_line(:,2));

plot(X_robo(:,1),X_robo(:,2),'o-');
%X_Line = 0:2:18;
%plot(X_Line(1,:),X_obv(:,2)','*-')
hold off

error_sum = sum(error);

%if not cut through，the left area will be all counted into error
if X_r_next(1)<width
    rest = (width-X_r_next(1))*y_truth;
    error_sum = error_sum+rest;
end

%disp(error)
disp(word_e_sum+ error_sum)









