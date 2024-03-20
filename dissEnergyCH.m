function clusterModel = dissEnergyCH(clusterModel, roundArch)
    % Extract relevant information from clusterModel
    nodeArch = clusterModel.nodeArch;
    netArch = clusterModel.netArch;
    cluster = clusterModel.clusterNode;
    
    % Calculate d0, the reference distance
    d0 = sqrt(netArch.Energy.freeSpace / netArch.Energy.multiPath);
    
    % If there are no cluster heads, return
    if cluster.countCHs == 0
        return
    end
    
    % Extract energy values from netArch
    ETX = netArch.Energy.transfer;
    ERX = netArch.Energy.receive;
    EDA = netArch.Energy.aggr;
    Emp = netArch.Energy.multiPath;
    Efs = netArch.Energy.freeSpace;
    
    % Extract packet lengths from roundArch
    packetLength = roundArch.packetLength;
    ctrPacketLength = roundArch.ctrPacketLength;
    
    % Iterate through each cluster head
    for i = 1:cluster.countCHs
        chNo = cluster.no(i); % Cluster head node number
        distance = cluster.distance(i); % Distance from CH to base station
        energy = nodeArch.node(chNo).energy; % Energy of the cluster head
        
        % Energy dissipation for aggregation + transferring of data to base station
        if distance >= d0
            nodeArch.node(chNo).energy = energy - ((ETX + EDA) * packetLength + Emp * packetLength * (distance ^ 4));
        else
            nodeArch.node(chNo).energy = energy - ((ETX + EDA) * packetLength + Efs * packetLength * (distance ^ 2));
        end
        
        % Energy dissipation for receiving data from cluster nodes
        nodeArch.node(chNo).energy = nodeArch.node(chNo).energy - ctrPacketLength * ERX * round(nodeArch.numNode / clusterModel.numCluster);
    end
    
    % Update nodeArch in clusterModel
    clusterModel.nodeArch = nodeArch;
end

