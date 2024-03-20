function NetArch = newNetwork(Length, Width, sinkX, sinkY, initEnergy, transEnergy, recEnergy, fsEnergy, mpEnergy, aggrEnergy)
    % Initializes the architecture of a wireless sensor network.
    %
    % Inputs:
    % Length, Width - The dimensions of the network area (yard).
    % sinkX, sinkY - The coordinates of the sink (base station).
    % initEnergy - The initial energy of each node (optional).
    % transEnergy - Energy consumed per bit to transmit data (optional).
    % recEnergy - Energy consumed per bit to receive data (optional).
    % fsEnergy - Energy of the free space model amplifier (optional).
    % mpEnergy - Energy of the multipath model amplifier (optional).
    % aggrEnergy - Energy consumed for data aggregation (optional).
    %
    % Output:
    % NetArch - A structure containing the network architecture.

    % Define the network's spatial layout (yard).
    Yard.Type = 'Rect';
    Yard.Length = Length;
    Yard.Width = Width;
    
    % Define the sink's location.
    Sink.x = sinkX;
    Sink.y = sinkY;
    
    % Set the initial energy for network nodes.
    Energy.init = initEnergy; % Edited to use function parameter.
   
    % Set the energy consumed per bit for transmitting and receiving data.
    Energy.transfer = transEnergy; % Edited to use function parameter.
    Energy.receive = recEnergy; % Edited to use function parameter.
    
    % Set the energy for the free space and multipath channel models.
    Energy.freeSpace = fsEnergy; % Edited to use function parameter.
    Energy.multiPath = mpEnergy; % Edited to use function parameter.
    
    % Set the energy consumed for data aggregation.
    Energy.aggr = aggrEnergy; % Edited to use function parameter.

    % Compile the network architecture into a structure.
    NetArch = struct('Yard', Yard, 'Sink', Sink, 'Energy', Energy);
end

