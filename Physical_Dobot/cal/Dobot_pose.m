function [Position] = Dobot_pose()
    dobot_Listener = rossubscriber('/dobot_magician/end_effector_poses');
    dobot_data = receive(dobot_Listener);
    
    
    % Quaternion(1) = EM_sensor_data.PortHandlePoses.Rotation.W;
    % Quaternion(2) = EM_sensor_data.PortHandlePoses.Rotation.X;
    % Quaternion(3) = EM_sensor_data.PortHandlePoses.Rotation.Y;
    % Quaternion(4) = EM_sensor_data.PortHandlePoses.Rotation.Z;
    % 
    % Rotation = quat2eul(Quaternion);
    Translation = [0 0 0];
    Translation(1) = dobot_data.Pose.Position.X;
    Translation(2) = dobot_data.Pose.Position.Y;
    Translation(3) = dobot_data.Pose.Position.Z;

    Position = Translation;
end

