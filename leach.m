function [nodeArch, clusterNode] = leach(clusterModel, clusterFunParam)
    % Implements the LEACH clustering protocol for wireless sensor networks.
    %
    % Inputs:
    % clusterModel - The current cluster model including node and network architectures.
    % clusterFunParam - Parameters for the clustering function, including the current round.
    %
    % Outputs:
    % nodeArch - The updated node architecture after cluster head selection.
    % clusterNode - Structure containing information about the selected cluster heads.

    % Extract network and node architectures, and clustering parameters.
    nodeArch = clusterModel.nodeArch;
    netArch = clusterModel.netArch;
    r = clusterFunParam(1); % Current round.
    p = clusterModel.p; % Probability of becoming a cluster head.
    N = nodeArch.numNode; % Total number of nodes.
    
    % Reset the cluster head flag after a certain number of rounds.
    if (mod(r, clusterModel.numCluster) == 0)
        for i = 1:N
            nodeArch.node(i).G = 0; % Reset cluster head eligibility flag.
        end
    end
    
    % Identify dead nodes and update their status.
    locAlive = find(~nodeArch.dead); % Find indices of alive nodes.
    for i = locAlive
        if nodeArch.node(i).energy <= 0
            nodeArch.node(i).type = 'D'; % Mark as dead.
            nodeArch.dead(i) = 1; % Update dead status.
        else
            nodeArch.node(i).type = 'N'; % Otherwise, mark as a normal node.
        end
    end
    nodeArch.numDead = sum(nodeArch.dead); % Update the count of dead nodes.
    
    % Initialize the structure for storing cluster head information.
    clusterNode = struct(); 
    countCHs = 0; % Counter for selected cluster heads.
    for i = locAlive
        temp_rand = rand; % Generate a random number for each node.
        % Determine if the node should become a cluster head.
        if (nodeArch.node(i).G <= 0) && ...
           (temp_rand <= probi(r, i, p, nodeArch)) && ...
           (nodeArch.node(i).energy > 0)
            countCHs = countCHs + 1;
            nodeArch.node(i).type = 'C'; % Mark as a cluster head.
            nodeArch.node(1,1).G = round(1/p) - 1; % Set cluster head eligibility flag.
            clusterNode.no(countCHs) = i; % Record cluster head number.
            % Record cluster head location.
            xLoc = nodeArch.node(i).x; 
            yLoc = nodeArch.node(i).y; 
            clusterNode.loc(countCHs, :) = [xLoc, yLoc];
            % Record distance from the node to the base station.
            clusterNode.distance(countCHs) = nodeArch.node(i).d;          
        end 
    end
    clusterNode.countCHs = countCHs; % Update the count of cluster heads.
end

