function [Obversation] = Get_Obv_once(Ground_Truth)

    
    X_gt = Ground_Truth(1);
    Y_gt = Ground_Truth(2);
    Theta_gt = Ground_Truth(3);

    x_o = X_gt+10;
    y_o = Y_gt+20;
    theta_o =Theta_gt;

    Obversation = [x_o,y_o,theta_o];
    
end

