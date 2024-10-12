function [Rotation] = Dobot_rotation()
    dobot_Listener = rossubscriber('/dobot_magician/end_effector_poses');
    dobot_data = receive(dobot_Listener);
    
    Quaternion = [0 0 0 0];
    Quaternion(1) = dobot_data.Pose.Orientation.W;
    Quaternion(2) = dobot_data.Pose.Orientation.X;
    Quaternion(3) = dobot_data.Pose.Orientation.Y;
    Quaternion(4) = dobot_data.Pose.Orientation.Z;

    Rotation = Quaternion;
    % 
    % Translation(1) = dobot_data.Pose.position.x;
    % Translation(2) = dobot_data.Pose.position.y;
    % Translation(3) = dobot_data.Pose.position.z;
    % 
    % Position = Translation;
end

