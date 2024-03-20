function clusterModel = newCluster(netArch, nodeArch, clusterFun, clusterFunParam, p_numCluster)
    % Initializes a new clustering model for a wireless sensor network.
    %
    % Inputs:
    % netArch - The network architecture including dimensions and sink location.
    % nodeArch - The architecture of the nodes, including their locations and energies.
    % clusterFun - The clustering function name as a string or function handle.
    % clusterFunParam - Additional parameters required by the clustering function.
    % p_numCluster - The inverse of the desired number of clusters or probability for cluster head selection.
    %
    % Output:
    % clusterModel - The updated cluster model after applying the specified clustering function.

    % Store the network and node architectures in the cluster model.
    clusterModel.netArch = netArch;
    clusterModel.nodeArch = nodeArch;
    
    % Store the specified clustering function and its parameters.
    clusterModel.clusterFun = clusterFun;
    clusterModel.clusterFunParam = clusterFunParam;
    
    % Calculate the number of clusters as the inverse of p_numCluster.
    % This approach assumes p_numCluster represents the desired fraction of cluster heads.
    numCluster = 1 / p_numCluster;
    
    % Update the cluster model with the calculated number of clusters and the provided probability.
    clusterModel.numCluster = numCluster;
    clusterModel.p = p_numCluster;
    
    % Dynamically invoke the clustering function with the current cluster model and its parameters.
    % This allows for flexible use of different clustering algorithms as needed.
    [nodeArch, clusterNode] = feval(clusterFun, clusterModel, clusterFunParam);
    
    % Update the cluster model with the results from the clustering function.
    clusterModel.nodeArch = nodeArch;        
    clusterModel.clusterNode = clusterNode; 
end

