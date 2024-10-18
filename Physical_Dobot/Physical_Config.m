
%plane config
width = 20;
longth = 40;

%line_position at EM-Local coordinate
x_truth = width/2;
y_truth = longth/2;
x= -80:15:70;
y= 260:270;

Target_line =([1,0;0,0]*[x;y]+[0;270])';
%Target_line =@(x,y) [0,0;0,0]*[x;y]+[0;20];

%Sensor_initialization
%Transform the Sensor Ground Truth Data from EM-Local to Robot Base 
x_o = [];
y_o = [];
theta_o = [];
X_obv = [x_o,y_o,theta_o];

%draw working space 

% f1 = figure("Name","EM-Local");
% f2 = figure("Name","Global");
% 
% %yline(y_truth,'r','Goal');
% figure(f1)
% xline(width,'b','Width');
% ylim([-10,10]);
% xlim([-10,10]);
% hold on
% figure(f2)
% ylim([0,40]);
% xlim([0,20]);
% yline(y_truth,'r','Initial Target Line');
% hold on;

%Robot__position_initialization
%X_robo is at Robot-Base/Global-Base
%X_robo_plane is at Plane-Base/EM-Local
y_r = [270];
x_r = [-80];
X_robo = [x_r,y_r];
% robotpose = dobot.endEffectorStateSub.LatestMessage.Pose.Position;
% x_r = robotpose.X;
% y_r = robotpose.Y;
% X_robo = [x_r,y_r];

% X_robo_plane(1,:) = Robot_pose_projection(X_obv,X_robo);
% Transform_target = Update_Line(X_obv,Target_line(1,:));
% Robot_step_size = 2;


%control_value_initialization
y_u = zeros(10,1);
x_u = zeros(10,1);
Control_value = [x_u,y_u];
error = 0;


% EM2Dobot_R = [-0.0032,0.9998,0.0199;
%                -0.0445,0.0197,-0.9988;
%                 -0.9990,-0.0041,0.0445];
% EM2Dobot_T = [251.6893,-234.6966,-1.2877];
% 
% Em2Paper_T = [0.830001831054688	118.272499084473 139.894992828369];
% Em2Paper_R = [0,0,1;0,1,0;1,0,0];
% Em2Paper_R = [0.0420039906539863	0.998036167366624	0.0464701344659073;
%                 0.735096811601125	-0.0623708724698331	0.675087069822265;
%                 0.676659694634607	0.00580369670912261	-0.736273030038116];

%Notation List
%word_1 = "Please input control value for next step";
word_e = "current error on step ";
word_e_sum = "Total error in process is: ";
