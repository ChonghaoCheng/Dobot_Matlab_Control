function [error] = Cal_error_sep(y_truth, X_r_current,X_r_next,Width)

    if X_r_next(1) <=20
        error = 1/2 *(abs(X_r_current(2)-y_truth) + abs(X_r_next(2)-y_truth))*abs(X_r_current(1)-X_r_next(1));
    else %only calculate error within the width 
        rate = (X_r_next(2) - X_r_current(2))/(X_r_next(1)-X_r_current(1));
        line = X_r_current(1)+ rate*(Width-X_r_current(1));
        error = 1/2 *(abs(X_r_current(2)-y_truth) + abs(line-y_truth))*abs(X_r_current(1)-Width);   
    end

end

