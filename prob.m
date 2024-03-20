function P = prob(r, i, p, nodeArch)
    % Calculates the adjusted probability of node i becoming a cluster head in round r,
    % considering the node's energy and distance from a certain point.
    %
    % Inputs:
    % r - The current round of the network operation.
    % i - The index of the node for which the probability is being calculated.
    % p - The base probability of becoming a cluster head.
    % nodeArch - The architecture of the network, detailing all nodes.
    %
    % Output:
    % P - The adjusted probability of node i becoming a cluster head in round r.

    % Retrieve the energy level and distance from the base station for node i.
    energy = nodeArch.node(i).energy; % Node's current energy level.
    dist = nodeArch.node(i).d;        % Node's distance to a certain point, likely the base station.

    % Coefficients for weighting the importance of energy and distance in the cost function.
    x = 0.3; % Weight for the energy component.
    y = 0.7; % Weight for the distance component.

    % Calculate the cost considering both energy and distance.
    % Higher energy and closer distance increase the node's candidacy for being a cluster head.
    cost = (energy * x) + (y / dist);

    % Adjust the base probability with the cost function and modulation by the current round.
    % This formula ensures that the probability is dynamically adjusted to favor nodes with
    % higher energy and closer proximity, while also spreading the chance of becoming a cluster
    % head evenly over different rounds.
    P = p / (1 - p * mod(r, round(1 / p))) * cost;
end

