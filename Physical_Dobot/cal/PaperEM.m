% 已知平面上四个点的坐标 (x, y, z)
clear all;
clc;
P1 =EM2_position;
pause
P2 = EM2_position;
pause
P3 = EM2_position;
pause
P4 = EM2_position;
pause
save('paperemdata',"P1","P2","P3","P4")
% 传感器的位置和角度
S_pos = EM_position;
S_theta = quat2eul(EM_rotation);
save('paperempoint',"S_pos","S_theta")% 传感器的角度
% 1. 计算平面的法向量
v1 = P2 - P1;
v2 = P3 - P1;
normal_vector = cross(v1, v2); % 法向量
normal_vector = normal_vector / norm(normal_vector); % 归一化

% 2. 计算平面上点的中心位置（质心）
plane_center = (P1 + P2 + P3 + P4) / 4;

% 3. 计算传感器相对于平面的相对位移
relative_position = S_pos - plane_center;

% 4. 计算旋转矩阵
% 平面的旋转角度（可通过平面的法向量和世界坐标系的夹角计算）
plane_theta = [atan2(normal_vector(2), normal_vector(3)), ...
               atan2(normal_vector(1), normal_vector(3)), ...
               atan2(normal_vector(1), normal_vector(2))];

% 传感器相对于平面的旋转矩阵
R_sensor = eul2rotm(S_theta); % 传感器的旋转矩阵（欧拉角 -> 旋转矩阵）
R_plane = eul2rotm(plane_theta); % 平面的旋转矩阵

% 相对旋转矩阵
relative_rotation = R_plane' * R_sensor; % 平面的旋转矩阵的逆乘以传感器旋转矩阵
disp('相对位置:');
disp(relative_position);

disp('相对旋转矩阵:');
disp(relative_rotation);