%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%           Improved LEACH Protocol for Wireless Sensor                %
%           Networks (I-LEACH)                                         %
%                                                                      %
%              Developed by MohammadHossein Homaei                     %
%                       Homaei@ieee.org                                %
%  https://scholar.google.com/citations?user=8IGmFIoAAAAJ&hl=en&oi=ao  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%  I-LEACH represents a significant enhancement over the traditional   %
%  LEACH protocol, incorporating dynamic cluster head selection,       %
%  adaptive transmission power, and advanced data aggregation          %
%  techniques. This protocol is designed to extend the operational     %
%  lifespan of wireless sensor networks through efficient energy       %
%  management and load distribution, making it ideal for               %
%  applications requiring long-term environmental monitoring and       %
%  resource management.                                                %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear the command window, clear all variables, and close all figures
clc, clear all, close all

% Initialize the number of nodes and the probability of becoming a cluster head
numNodes = 100;
p = 0.1;

% Create a new network architecture with specified dimensions and sink location
netArch = newNetwork(100, 100, 50, 175);

% Initialize the nodes within the network architecture
nodeArch = newNodes(netArch, numNodes);

% Initialize the round architecture with default settings
roundArch = newRound();

% Placeholder for a function 'plot1' - ensure this function exists or is defined elsewhere in your code
plot1

% Initialize a structure to hold graphing data
graph = struct;

% Begin simulation for the number of rounds specified in roundArch
for r = 1:roundArch.numRound
    % Create a new cluster for the current round using the I-LEACH algorithm
    clusterModel = newCluster(netArch, nodeArch, 'ileach', r, p);
    
    % Dissipate energy for cluster heads based on the current round settings
    clusterModel = dissEnergyCH(clusterModel, roundArch);
    
    % Dissipate energy for non-cluster head nodes based on the current round settings
    clusterModel = dissEnergyNonCH(clusterModel, roundArch);
    
    % Update the node architecture for the next iteration
    nodeArch = clusterModel.nodeArch;
    
    % Plot the results of the current round and update the graph structure
    graph = plotResults(clusterModel, r, graph);
    
    % If all nodes are dead, exit the loop
    if nodeArch.numDead == nodeArch.numNode
        break
    end
end


