function graph = plotResults(clusterModel, r, graph)
    % This function updates and plots the results for each round in the simulation.
    % Inputs:
    % clusterModel - The current state of the cluster model including node architecture.
    % r - The current round of simulation.
    % graph - A struct holding the history of various metrics for plotting.

    % Access the node architecture from the cluster model.
    nodeArch = clusterModel.nodeArch;
    
    % Number of packets sent from cluster heads (CHs) to the base station (BS)
    if r == 1
        % For the first round, initialize with the number of clusters.
        graph.packetToBS(r) = clusterModel.numCluster;
    else
        % For subsequent rounds, add the count of cluster heads to the previous total.
        graph.packetToBS(r) = graph.packetToBS(r-1) + clusterModel.clusterNode.countCHs;
    end
    
    % Plot the number of packets sent to the base station over rounds.
    % Assuming 'fig' is a custom plotting function that needs further clarification.
    fig(graph.packetToBS, r, 1, 'No. of packets sent to BS', 'Number of packets sent to BS vs. Round');
    
    % Update and store the number of dead nodes.
    graph.numDead(r) = nodeArch.numDead;
    
    % Plot the number of dead nodes over rounds.
    fig(graph.numDead, r, 2, 'No. of dead nodes', 'Number of dead nodes vs. Round');
    
    % Initialize the total residual energy for this round.
    graph.energy(r) = 0;
    node = clusterModel.nodeArch; % Redundant access to nodeArch; could use nodeArch directly.
    for i = find(~node.dead) % Iterate over alive nodes.
        if node.node(i).energy > 0
            % Sum up the residual energy of alive nodes.
            graph.energy(r) = graph.energy(r) + node.node(i).energy;
        end
    end
    
    % Plot the total residual energy of nodes over rounds.
    fig(graph.energy, r, 3, 'sum of energy', 'Sum of energy of nodes vs. Round');
    
    % Assuming 'createfigure' is a custom function for creating a composite figure
    % with all the metrics plotted.
    createfigure(1:r, graph.packetToBS, graph.numDead, graph.energy);
end

