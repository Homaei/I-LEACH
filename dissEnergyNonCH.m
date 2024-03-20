function clusterModel = dissEnergyNonCH(clusterModel, roundArch)
    % Extract relevant information from clusterModel
    nodeArch = clusterModel.nodeArch;
    netArch = clusterModel.netArch;
    cluster = clusterModel.clusterNode;
    
    % If there are no cluster heads, return
    if cluster.countCHs == 0
        return
    end
    
    % Calculate d0, the reference distance
    d0 = sqrt(netArch.Energy.freeSpace / netArch.Energy.multiPath);
    
    % Extract energy values from netArch
    ETX = netArch.Energy.transfer;
    ERX = netArch.Energy.receive;
    EDA = netArch.Energy.aggr;
    Emp = netArch.Energy.multiPath;
    Efs = netArch.Energy.freeSpace;
    
    % Extract packet lengths from roundArch
    packetLength = roundArch.packetLength;
    ctrPacketLength = roundArch.ctrPacketLength;
    
    % Find indices of alive nodes
    locAlive = find(~nodeArch.dead); 
    
    % Iterate through alive nodes
    for i = locAlive
        % Find Associated CH for each normal node
        if strcmp(nodeArch.node(i).type, 'N') && nodeArch.node(i).energy > 0
            % Get location of current node
            locNode = [nodeArch.node(i).x, nodeArch.node(i).y];
            countCH = cluster.countCHs;
            
            % Calculate distance to each CH and find smallest distance
            [minDis, loc] = min(sqrt(sum((repmat(locNode, countCH, 1) - cluster.loc)' .^ 2)));
            minDisCH = cluster.no(loc);
            
            % Calculate energy consumption based on distance
            if (minDis > d0)
                nodeArch.node(i).energy = nodeArch.node(i).energy - ctrPacketLength * ETX + Emp * packetLength * (minDis ^ 4);
            else
                nodeArch.node(i).energy = nodeArch.node(i).energy - ctrPacketLength * ETX + Efs * packetLength * (minDis ^ 2);
            end
            
            % Check for data transmission to the CH
            if (minDis > 0 && nodeArch.node(i).d > cluster.distance(loc))
                nodeArch.node(minDisCH).energy = nodeArch.node(minDisCH).energy - ((ERX + EDA) * packetLength);
            end
        end
    end
    
    % Update nodeArch in clusterModel
    clusterModel.nodeArch = nodeArch;
end

