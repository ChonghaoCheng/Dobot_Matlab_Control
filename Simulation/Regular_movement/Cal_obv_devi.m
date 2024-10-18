function [X_deviation ] = Cal_obv_devi(X_obv,step,Target_line)
%CAL_OBV_DEVI 此处显示有关此函数的摘要
%   此处显示详细说明
    % %calculate observation deviation
    X_obs = X_obv(step,1);
    Y_obs = X_obv(step,2);
    Theta_obs = X_obv(step,3);

    if step == 1
        X_obs_pre = 0;
        Y_obs_pre =Target_line(step,2)+20;
        Theta_obs_pre = 0;
    else
        X_obs_pre = X_obv(step-1,1);
        Y_obs_pre = X_obv(step-1,2);
        Theta_obs_pre = X_obv(step-1,3);
    end

    x_d = X_obs - X_obs_pre;
    y_d = Y_obs - Y_obs_pre;
    theta_d = Theta_obs - Theta_obs_pre;
    X_deviation = [x_d,y_d,theta_d];

end

