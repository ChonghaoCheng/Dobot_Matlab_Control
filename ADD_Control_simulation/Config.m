

Ground_Truth = Get_sensor_data;
%plane config
width = 40;
longth = 80;


% SET UP TARGET LINE TYPE
%line_position at EM-Local coordinate
x_truth = width/2;
y_truth = longth/2;
x= -x_truth+10:2:x_truth+10;
y= 0:4:longth;

%Straight Line
Target_line =([1,0;0,0]*[x;y]+[0;0])';

%Curve Line
% y = (0.01*(x-10).^2)-4;
% Target_line = (([1,0;0,1/2])*[x;y]+[0;0])';

% SIN Shape Line
% y = sin(x+10);
% Target_line = (([1,0;0,1/2])*[x;y]+[0;0])';



%Sensor_initialization
%Transform the Sensor Ground Truth Data from EM-Local to Robot Base 
x_o = [10];
y_o = [20];
theta_o = [0];
X_obv = [x_o,y_o,theta_o];
X_obv_N= X_obv;

%draw working space 
f1 = figure("Name","PaperBoard");
f2 = figure("Name","Global");

%yline(y_truth,'r','Goal');
figure(f1)
grid on;
xlabel("X(cm)")
ylabel("Y(cm)")
ylim([-10,10]);
xlim([-10,30]);

hold on
figure(f2)
grid on;
xlabel("X(cm)")
ylabel("Y(cm)")
% ylim([15,25]);
% xlim([0,45]);
% yline(y_truth,'r','Initial Target Line');
hold on;

%Robot__position_initialization
%X_robo is at Robot-Base/Global-Base
%X_robo_plane is at Plane-Base/EM-Local
y_r = [20];
x_r = [0];
X_robo = [x_r,y_r];
X_robo1 = X_robo;
X_robo2 = X_robo;

% robotpose = dobot.endEffectorStateSub.LatestMessage.Pose.Position;
% x_r = robotpose.X;
% y_r = robotpose.Y;
% X_robo = [x_r,y_r];

X_robo_plane(1,:) = Robot_pose_projection(X_obv,X_robo);
X_robo_plane1(1,:) = Robot_pose_projection(X_obv,X_robo);
X_robo_plane2(1,:) = Robot_pose_projection(X_obv,X_robo);
Transform_target = Update_Line(X_obv,Target_line(1,:));
% Robot_step_size = 2;


%control_value_initialization
y_u = zeros(10,1);
x_u = zeros(10,1);
Control_value = [x_u,y_u];
Control_value1 = Control_value;
Control_value2 = Control_value;
error = 0;

%Notation List
%word_1 = "Please input control value for next step";
word_e = "current error using control method1 on step ";
word_e_sum = "Total error in process is: ";