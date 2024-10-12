
% Dobot2EM_R = [-0.3347,0.9401,0.0655;
%                -0.3481,-0.0588,-0.9356;
%                 -0.8757,-0.3359,0.3469];
% Dobot2EM_T = [242.5267,-372.6757,-38.1286];

% Dobot2EM_R = [-0.2668,0.9638,0.0026;
%                0.0572,0.0185,-0.9982;
%                 -0.9621,-0.2662,-0.0601];
% Dobot2EM_T = [220.0062,-371.4718,-197.6521];

EM2Dobot_R = [-0.1444,0.9886,0.0424;
               0.3416,-0.0096,0.9398;
                0.8757,-0.3359,0.3469];
EM2Dobot_T = [251.5267,-234.5717,-0.6644];


EM2Dobot_R = [-0.0032,0.9998,0.0199;
               -0.0445,0.0197,-0.9988;
                -0.9990,-0.0041,0.0445];
EM2Dobot_T = [251.6893,-234.6966,-1.2877];

% EM2Dobot_trans=[ [EM2Dobot_R,EM2Dobot_T'];[0,0,0,1] ];
% em = [EM_position,1]';
dobot = DobotMagician();

% rob =EM2Dobot_trans*( em/1000);
% Rob = rob(1:3)
em = EM_position;
% em_new = [-em(1),em(2),em(3)];
Rob = ( EM2Dobot_R*em' + EM2Dobot_T')/1000+ [0,0,0.0051]'
% Rob = EM2Dobot_R *em
endEffectorRotation = [0,0,0];
dobot.PublishInitEndEffectorPosetest(Rob,endEffectorRotation);