function P = probi(r, i, p, nodeArch)
    % Calculates the probability of node i becoming a cluster head in round r.
    %
    % Inputs:
    % r - The current round of the network operation.
    % i - The index of the node for which the probability is being calculated.
    % p - The desired probability of becoming a cluster head. 
    %     If not provided, it defaults to 0.1.
    % nodeArch - The architecture of the network, including details of all nodes.
    %
    % Output:
    % P - The calculated probability of node i becoming a cluster head in round r.

    % Extract the energy and distance from the node structure for node i.
    energy = nodeArch.node(i).energy; % Node's current energy.
    dist = nodeArch.node(i).d;        % Node's distance to a certain point.

    % Coefficients influencing the cost calculation.
    x = 0.5;
    y = 0.5;

    % Calculate the cost based on energy and distance.
    % The cost calculation is customizable and affects the probability.
    cost = (energy * x) + round(y / dist);
    
    % If 'p' is not passed as an argument, default it to 0.1.
    if ~exist('p', 'var')
        p = 0.1;
    end
    
    % Calculate the probability for node i to become a cluster head in round r.
    % This formula adjusts 'p' based on the node's operation round to ensure
    % that the probability of becoming a cluster head is evenly distributed
    % over the rounds.
    P = p / (1 - p * mod(r, round(1 / p)));
end

