# Dobot_Matlab_Control

## Physical Experiment
    Include Dobot Driver and using Ros to communicate between EM Sensor and Dobot.

## Simulation
    Run ** Simulation_(movement types) ** to start

    Due to different Movement Trajectory, divide simulation into two part. 
    We can adjust the total number of steps (in Config.m) to compare the results under different sampling rates.

    Three target trajectory types (can be change in Config.m)
    1. Straight Line
    2. Curve
    3. Sine Wave

    Four control methods
    Cal_control.m simple position Control
    Cal_control_P.m Kp Control
    Cal_control_P_C.m add compensation based on Kp control
    Cal_control_PI.m PI control

    Observation With or Without noise.

    


### Random movement
    Assume that the paperboard moves 20 times in total, with each movement evenly spaced throughout the entire motion,
     remaining stationary at all other times.
    Each movement occurring relative to the position of the previous step.

### Regular movement(Can be changed in Get_sensor_data.m)
    Two types of movement: move in Y direction or rotate around the z-axis and the total 
    amount of movement is fixed.
    The movement relative to the original position of the paperboard.
