function [error] = Cal_error(y_truth, X_r)
%CAL_ERROR 此处显示有关此函数的摘要
%   此处显示详细说明
y = X_r(1,:);
x = X_r(2,:);
error = trapz(x,abs(y-y_truth));
end

