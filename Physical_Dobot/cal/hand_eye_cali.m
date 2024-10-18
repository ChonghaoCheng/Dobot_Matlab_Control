%%% E1XS1=E2XS2 -> XS1S2^-1=E1^-1E2X -> Ax=XB 
%%% Tiancheng

clear all;
close all;

dobot = DobotMagician();

%% real
% load('TF20.mat');
% load('cali_cam.mat');
% n=length(cali_cam);
% Cam_Poses=zeros(4,4*n);
% Rob_Poses=zeros(4,4*n);
n = 10;
Cam_Poses=zeros(4,4*n);
Rob_Poses=zeros(4,4*n);

% for i=1:n
%     ang=[cali_cam(i,1),cali_cam(i,2),cali_cam(i,3)];
%     Cam_Poses(:,4*i-3:4*i)=inv(  [[eul2rotm(ang),cali_cam(i,4:6)']; [0,0,0,1]]  );   % camera pose in checkerboard
%     Rob_Poses(:,4*i-3:4*i)= inv(  [[quat2rotm(TF110_129(i,4:7)), TF110_129(i,1:3)']; [0,0,0,1]] );  % robot base in end-efferctor / inv(EM reading)
% end

for step = 1:n
    dobot_pose = Dobot_pose();
    dobot_rotation = Dobot_rotation();

    EM1_pose = EM_position;
    EM1_rotation = EM_rotation;


    Cam_Poses(:,4*step-3:4*step) = ([[quat2rotm(EM1_rotation),EM1_pose']; [0,0,0,1]]  );
    Rob_Poses(:,4*step-3:4*step) = ([[quat2rotm(dobot_rotation), dobot_pose']; [0,0,0,1]]);
    disp(step)
    pause
end



save('Rob','Rob_Poses')
save('EM','Cam_Poses')
% save('EMp','EM1_pose')
% save('EMr','EM1_rotation')
% save('dobotr','dobot_rotation')
% save('dobotp','dobot_pose')
% 
% load("EM.mat")
% load("Rob.mat")

% n_group=n/2;
n_group=n-1;
A_group=zeros(4*n_group,4);
B_group=zeros(4*n_group,4);

%% formulation from TMRB
for i=1:n_group

    A_group(4*i-3:4*i,:)= inv(Rob_Poses(:,4*i-3:4*i))*Rob_Poses(:,4*i+1:4*i+4);
    B_group(4*i-3:4*i,:)= inv(Cam_Poses(:,4*i-3:4*i))*(Cam_Poses(:,4*i+1:4*i+4));

end

%% Park and Martin Method
M=0;
for i=1:n_group
    RA_i=A_group(4*i-3:4*i-1,1:3);
    RB_i=B_group(4*i-3:4*i-1,1:3);
    alpha=SkewtoVector(logm(RA_i));
    beta=SkewtoVector(logm(RB_i));
    M=M+beta*alpha';
end

Rx=(M'*M)^(-0.5)*M'


tx=zeros(3,1);
I=diag(ones(1,3));

for k=1:100  %Iteration
    
    J=zeros(3*n_group,3);
    F=zeros(3*n_group,1);
    H=zeros(3,3);
    B=zeros(3,1);
    
    for i=1:n_group
        RA_i=A_group(4*i-3:4*i-1,1:3);
        RB_i=B_group(4*i-3:4*i-1,1:3);
        tA_i=A_group(4*i-3:4*i-1,4);
        tB_i=B_group(4*i-3:4*i-1,4);
        
        F(3*i-2:3*i)=(I-RA_i)*tx-(tA_i-Rx*tB_i);        
        J(3*i-2:3*i,:)=(I-RA_i)*I;
        
        H=H+J(3*i-2:3*i,:)'*J(3*i-2:3*i,:);
        B=B-J(3*i-2:3*i,:)'*F(3*i-2:3*i);
        
    end
    
    delta=H\B;
    tx=tx+delta;
    
    delta_sq = sum(delta.^2);
    error=sum(abs(F))/n_group;
    
    if delta_sq <= 1e-10
        break;
    end
    
end

Rx
tx
error