

Ground_Truth = Get_sensor_data;
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
% robotpose = dobot.endEffectorStateSub.LatestMessage.Pose.Position;
% x_r = robotpose.X;
% y_r = robotpose.Y;
% X_robo = [x_r,y_r];

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

Paper2EM_T = [-21.9100,-15.6850,65.0925];
Dobot2EM_R = [0.1103,0.9939,0.0024;
                0.1247,-0.114,-0.9921;
                -0.9861,0.1097,-0.1252];
Dobot2EM_T = [231.8653,-385.7132,-51.6569];
Dobot2EM_trans=[Dobot2EM_R,Dobot2EM_T';[0,0,0,1]];


