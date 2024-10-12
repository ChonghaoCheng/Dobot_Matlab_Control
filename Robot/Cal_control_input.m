function [Control_Value] = Cal_control_input()

    word_1 = "Please input control value on X-ray for next step";
    word_2 = "Please input control value on Y-ray for next step";
    
    X_ctrl = input(word_1+': ');
    Y_ctrl = input(word_2+': ');
    
    Control_Value = [X_ctrl,Y_ctrl];

end

