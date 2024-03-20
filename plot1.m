% Prepare figure 1 for plotting and hold it to overlay multiple plots.
figure(1), hold on

% Plot the locations of all nodes in the network.
% nodeArch.nodesLoc contains the (x,y) coordinates of each node.
% The nodes are plotted as red circles with a marker size of 5.
plot(nodeArch.nodesLoc(1:nodeArch.numNode,1), nodeArch.nodesLoc(1:nodeArch.numNode,2), ...
    'o', 'MarkerSize', 5, 'MarkerFaceColor', 'r');

% Plot the location of the sink in the network.
% netArch.Sink.x and netArch.Sink.y contain the (x,y) coordinates of the sink.
% The sink is plotted as a green circle with a marker size of 10.
plot(netArch.Sink.x, netArch.Sink.y, 'o', ...
    'MarkerSize', 10, 'MarkerFaceColor', 'g');

