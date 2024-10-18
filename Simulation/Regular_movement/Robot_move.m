function [Robot] = Robot_move(Robot,Control)

    X_robo_current = Robot;
    X_robo_next = X_robo_current + Control;
    Robot= X_robo_next;
    
end

