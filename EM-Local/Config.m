clc;
clear all;
close all;

%Sensor ground truth value
%Sensor is attached at the center of the plane
%Sensor value means it's relative pose to it's initial position

% X_sensor = [0,0,0,0,0,0,0,0,0,0]';
% Y_sensor = [0,0,0,0,0,0,0,0,0,0]';
% Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';

Y_sensor = [1,0,1,0,1,0,1,0,1,0]';
X_sensor = [0,0,0,0,0,0,0,0,0,0]';
Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';

% X_sensor = [0,0,0,0,0,0,0,0,0,0]';
% Y_sensor = [0,0,0,0,0,0,0,0,0,0]';
% Theta_sensor = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]';


% X_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
% Y_sensor = [1,2,-1,-2,1,-1,2,-2,0.1,-0.1]';
% Theta_sensor = [0,0,0,0,0,0,0,0,0,0]';

% X_sensor = [0.1,0.2,-0.1,-0.2,0.1,-0.1,0.2,-0.2,0.1,-0.1]';
% Y_sensor = [0.1,0.2,-0.1,0,0.1,-0.1,0.2,-0.2,0.1,-0.1]';
% Theta_sensor = [0.1,0.2,0.3,-0.1,-0.2,0,0,0,0,0]';

Ground_Truth = [X_sensor,Y_sensor,Theta_sensor];

%plane config
width = 20;
longth = 40;

%line_position at EM-Local coordinate
x_truth = width/2;
y_truth = longth/2;
x= -x_truth:2:x_truth;
y= 0:4:longth;

Target_line =([1,0;0,0]*[x;y]+[0;0])';
%Target_line =@(x,y) [0,0;0,0]*[x;y]+[0;20];

%Sensor_initialization
%Transform the Sensor Ground Truth Data from EM-Local to Robot Base 
x_o = [10];
y_o = [20];
theta_o = [0];
X_obv = [x_o,y_o,theta_o];

%draw working space 

f1 = figure("Name","EM-Local");
f2 = figure("Name","Global");

%yline(y_truth,'r','Goal');
figure(f1)
xline(width,'b','Width');
ylim([-10,10]);
xlim([-10,10]);
hold on
figure(f2)
ylim([0,40]);
xlim([0,20]);
yline(y_truth,'r','Initial Target Line');
hold on;

%Robot__position_initialization
%X_robo is at Robot-Base/Global-Base
%X_robo_plane is at Plane-Base/EM-Local
y_r = [20];
x_r = [0];
X_robo = [x_r,y_r];

X_robo_plane(1,:) = Robot_pose_projection(X_obv,X_robo);
Transform_target = Update_Line(X_obv,Target_line(1,:));
% Robot_step_size = 2;


%control_value_initialization
y_u = zeros(10,1);
x_u = zeros(10,1);
Control_value = [x_u,y_u];
error = 0;

%Notation List
%word_1 = "Please input control value for next step";
word_e = "current error on step ";
word_e_sum = "Total error in process is: ";