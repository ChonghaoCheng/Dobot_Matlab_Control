global Total_step;
Total_step = 80;

% Ground_Truth = Get_Regular_sensor_data(Total_step);
Ground_Truth = Get_Random_sensor_data(Total_step);
%plane config
width = 40;
longth = 80;


% SET UP TARGET LINE TYPE
%line_position at EM-Local coordinate
x_truth = width/2;
y_truth = longth/2;
x= linspace(-x_truth+10,x_truth+10,Total_step+1);
y= linspace(0,longth,Total_step+1);

% %Straight Line
Target_line =([1,0;0,0]*[x;y]+[0;0])';

%Curve Line
% y = (0.01*(x-10).^2)-4;
% Target_line = (([1,0;0,1/2])*[x;y]+[0;0])';

% %SIN Wave Line
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
ylim([-2.5,2.5]);
xlim([-10,30]);

hold on
figure(f2)
grid on;
xlabel("X(cm)")
ylabel("Y(cm)")
ylim([19,24]);
xlim([0,40]);
% yline(y_truth,'r','Initial Target Line');
hold on;

%Robot__position_initialization
%X_robo is at Robot-Base/Global-Base
%X_robo_plane is at Plane-Base/EM-Local
y_r = [20]';
x_r = [0]';
X_robo = [x_r,y_r];
X_robo_P = X_robo;
X_robo_P_C = X_robo;
X_robo_PI = X_robo;
X_robo_MPC = X_robo;

% robotpose = dobot.endEffectorStateSub.LatestMessage.Pose.Position;
% x_r = robotpose.X;
% y_r = robotpose.Y;
% X_robo = [x_r,y_r];

X_robo_plane(1,:) = [0,0];%Robot_pose_projection(X_obv,X_robo);
X_robo_plane_P(1,:) = [0,0];%Robot_pose_projection(X_obv,X_robo);
X_robo_plane_P_C(1,:) = [0,0];%Robot_pose_projection(X_obv,X_robo);
X_robo_plane_PI(1,:) = [0,0];%Robot_pose_projection(X_obv,X_robo
X_robo_plane_MPC(1,:) = [0,0];
Transform_target = Update_Line(X_obv,Target_line(1,:));
% Robot_step_size = 2;


%control_value_initialization
y_u = zeros(10,1);
x_u = zeros(10,1);
Control_value = [x_u,y_u];
Control_value_P = Control_value;
Control_value_P_C = Control_value;
Control_value_PI = Control_value;
Control_value_MPC = Control_value;
error = 0;

%Notation List
%word_1 = "Please input control value for next step";
word_e = "current error using control method1 on step ";
word_e_sum = "Total error in process is: ";