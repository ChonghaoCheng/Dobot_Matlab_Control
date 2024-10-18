function [Disturbance] = Get_EM_sensor_data()%step)
    EM_sensor_Listener = rossubscriber('/ndi_aurora','ndi_aurora_msgs/PortHandlePosesStamped');
    EM_sensor_data = receive(EM_sensor_Listener);
    
    
    Quaternion(1) = EM_sensor_data.PortHandlePoses(1).Rotation.W;
    Quaternion(2) = EM_sensor_data.PortHandlePoses(1).Rotation.X;
    Quaternion(3) = EM_sensor_data.PortHandlePoses(1).Rotation.Y;
    Quaternion(4) = EM_sensor_data.PortHandlePoses(1).Rotation.Z;
    
    Rotation = quat2eul(Quaternion);
    
    Translation(1) = EM_sensor_data.PortHandlePoses(1).Translation.X;
    Translation(2) = EM_sensor_data.PortHandlePoses(1).Translation.Y;
    Translation(3) = EM_sensor_data.PortHandlePoses(1).Translation.Z;


    Disturbance=[Translation(1),Translation(2),Rotation(1)];