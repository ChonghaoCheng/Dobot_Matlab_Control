function [Control_value] = Cal_control_MPC(Target_line,Observation,Robot_position,Step,X_obv_deviation)
    global Total_step;
    X_o = Observation(Step,1);
    Y_o = Observation(Step,2);
    Theta_o = Observation(Step,3);
    
    X_rp = Robot_position(Step,1);
    Y_rp = Robot_position(Step,2);
    Target_point=zeros(2,5);
    Target= zeros(10,1);
    test=zeros(2,5);
    for i=1:5
        if Step+i<=Total_step
            
            Aim_x = Target_line(Step+i,1);
            Aim_y = Target_line(Step+i,2);
        else
            Aim_x = Target_line(Total_step+1,1);
            Aim_y = Target_line(Total_step+1,2);
        end
            test(:,i)=[Aim_x;Aim_y];
            Aim_theta = X_obv_deviation(3);
            Rot = [cos(Theta_o+i*Aim_theta) -sin(Theta_o+i*Aim_theta);
                    sin(Theta_o+i*Aim_theta) cos(Theta_o+i*Aim_theta)];
            
            Target_point(:,i) = Rot*[Aim_x;Aim_y]+[X_o;Y_o];
            if Step == 1
                Compansate = [0;0];
            else
                Compansate = [X_obv_deviation(1);X_obv_deviation(2)];
            end
           Target(2*i-1:2*i)= Target_point(:,i)+i*Compansate(:);
   
        % else
        % 
        %     Aim_x = Target_line(Step+i,1);
        %     Aim_y = Target_line(Step+i,2);
        %     Aim_theta = X_obv_deviation(3);
        %     Rot = [cos(Theta_o) -sin(Theta_o);
        %             sin(Theta_o) cos(Theta_o)];
        %     Target_point(:,i) = Rot*[Aim_x;Aim_y]+[X_o;Y_o];
            
        
        
    end
     A = eye(2,2);
     B = eye(2,2);
     U = zeros(2,1);
     K = 5;
     
     Q = [1 0;0 1];
    R=[0 0 ;0 0];
    control = SolveLinearMPC(A,B,Q,R,[],[],[X_rp;Y_rp],Target,5);


    Difference =control(1:2);
    Control_value = Difference;

end

