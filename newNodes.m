function nodeArch = newNodes(netArch, numNode)
    % Initializes the architecture for the network nodes.
    %
    % Inputs:
    % netArch - The network architecture, including dimensions and sink location.
    % numNode - The number of nodes to be initialized within the network.
    %
    % Output:
    % nodeArch - The architecture of the nodes, including their locations, energies, and types.

    % Retrieve the sink's coordinates from the network architecture.
    sinkx = netArch.Sink.x;
    sinky = netArch.Sink.y;
    
    % Initialize nodes within the network.
    for i = 1:numNode
        % Randomly generate x and y coordinates for each node within the network dimensions.
        nodeArch.node(i).x = rand * netArch.Yard.Length; % x-coordinate
        nodeArch.nodesLoc(i, 1) = nodeArch.node(i).x;
        
        nodeArch.node(i).y = rand * netArch.Yard.Width; % y-coordinate
        nodeArch.nodesLoc(i, 2) = nodeArch.node(i).y;
        
        % Initialize node properties.
        nodeArch.node(i).G = 0; % A variable, possibly for tracking eligibility to become a cluster head.
        nodeArch.node(i).type = 'N'; % Node type, 'N' for Normal.
        nodeArch.node(i).energy = netArch.Energy.init; % Initial energy as defined in the network architecture.
        nodeArch.dead(i) = 0; % Initially, no node is dead.
        
        % Calculate the distance of each node from the base station (sink).
        nodeArch.node(i).d = sqrt((sinkx - nodeArch.nodesLoc(i,1)) ^ 2 + ...
                                  (sinky - nodeArch.nodesLoc(i,2)) ^ 2); 
    end
    % Store the total number of nodes and the number of dead nodes in the network.
    nodeArch.numNode = numNode; % Total number of nodes.
    nodeArch.numDead = 0; % Initially, there are no dead nodes.
end

