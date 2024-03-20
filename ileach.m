function [nodeArch, clusterNode] = ileach(clusterModel, clusterFunParam)
    % Implements an improved LEACH protocol for cluster head selection in wireless sensor networks.
    %
    % Inputs:
    % clusterModel - The current cluster model including the network and node architectures.
    % clusterFunParam - The current round of the network operation.
    %
    % Outputs:
    % nodeArch - The updated architecture of nodes after cluster head selection.
    % clusterNode - Structure containing information about the selected cluster heads.

    % Extract the node architecture and current round.
    nodeArch = clusterModel.nodeArch;
    r = clusterFunParam;
    p = clusterModel.p; % Probability of becoming a cluster head.
    N = nodeArch.numNode; % Total number of nodes.
    
    % Reset the cluster head flag after a specified number of rounds.
    if (mod(r, clusterModel.numCluster) == 0)
        for i = 1:N
            nodeArch.node(i).G = 0; % Reset flag indicating eligibility to become a cluster head.
        end
    end
    
    % Identify and mark dead nodes.
    locAlive = find(~nodeArch.dead); % Indices of alive nodes.
    for i = locAlive
        if nodeArch.node(i).energy <= 0
            nodeArch.node(i).type = 'D'; % Mark as dead.
            nodeArch.dead(i) = 1; % Update dead status.
        else
            nodeArch.node(i).type = 'N'; % Otherwise, mark as a normal node.
        end
    end
    nodeArch.numDead = sum(nodeArch.dead); % Update the count of dead nodes.
    
    % Initialize the cluster head structure.
    clusterNode = struct(); 
    countCHs = 0; % Counter for selected cluster heads.
    for i = locAlive
        temp_rand = rand; % Generate a random number for each node.
        % Determine if the node should become a cluster head based on probability and energy.
        if (nodeArch.node(i).G <= 0) && ...
           (temp_rand <= probi(r, i, p, nodeArch)) && ...
           (nodeArch.node(i).energy > 0)
           
            countCHs = countCHs + 1; % Increment cluster head count.
            nodeArch.node(i).type = 'C'; % Mark as a cluster head.
            nodeArch.node(i).G = round(1/p) - 1; % Update eligibility flag.
            
            % Store cluster head location and distance from the base station.
            clusterNode.no(countCHs) = i; % Cluster head index.
            xLoc = nodeArch.node(i).x; % x-coordinate.
            yLoc = nodeArch.node(i).y; % y-coordinate.
            clusterNode.loc(countCHs, :) = [xLoc, yLoc]; % Location.
            clusterNode.distance(countCHs) = nodeArch.node(i).d; % Distance.
        end 
    end
    clusterNode.countCHs = countCHs; % Store the total count of cluster heads.
end

