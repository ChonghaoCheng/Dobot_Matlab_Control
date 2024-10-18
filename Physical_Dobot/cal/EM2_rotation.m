function [Rotation] = EM2_rotation()
    EM_sensor_Listener = rossubscriber('/ndi_aurora','ndi_aurora_msgs/PortHandlePosesStamped');
    EM_sensor_data = receive(EM_sensor_Listener);
    
    Quaternion = [0 0 0 0];
    Quaternion(1) = EM_sensor_data.PortHandlePoses(2).Rotation.W;
    Quaternion(2) = EM_sensor_data.PortHandlePoses(2).Rotation.X;
    Quaternion(3) = EM_sensor_data.PortHandlePoses(2).Rotation.Y;
    Quaternion(4) = EM_sensor_data.PortHandlePoses(2).Rotation.Z;
    
    Rotation = Quaternion;
    
    % Translation(1) = EM_sensor_data.PortHandlePoses.Translation.X;
    % Translation(2) = EM_sensor_data.PortHandlePoses.Translation.Y;
    % Translation(3) = EM_sensor_data.PortHandlePoses.Translation.Z;
end

