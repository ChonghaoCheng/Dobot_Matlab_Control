function [Position] = EM_position()
    EM_sensor_Listener = rossubscriber('/ndi_aurora','ndi_aurora_msgs/PortHandlePosesStamped');
    EM_sensor_data = receive(EM_sensor_Listener);
    
    
    % Quaternion(1) = EM_sensor_data.PortHandlePoses.Rotation.W;
    % Quaternion(2) = EM_sensor_data.PortHandlePoses.Rotation.X;
    % Quaternion(3) = EM_sensor_data.PortHandlePoses.Rotation.Y;
    % Quaternion(4) = EM_sensor_data.PortHandlePoses.Rotation.Z;
    % 
    % Rotation = quat2eul(Quaternion);
    Translation = [0 0 0];
    Translation(1) = EM_sensor_data.PortHandlePoses(1).Translation.X;
    Translation(2) = EM_sensor_data.PortHandlePoses(1).Translation.Y;
    Translation(3) = EM_sensor_data.PortHandlePoses(1).Translation.Z;

    Position = Translation;

end

