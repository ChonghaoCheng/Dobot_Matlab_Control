clc;
clear all;
close all;
rosshutdown;
%% Start Dobot Magician Node
rosinit;
dobot = DobotMagician();

InitendEffectorPosition = [0.157,0.024,0.01];
endEffectorRotation = [0,0,0];

dobot.InitPublishEndEffectorPose(InitendEffectorPosition,endEffectorRotation);
pause(2);
