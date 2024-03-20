function NetRound = newRound(numRound, packetLength, ctrPacketLength)
    % Initializes a structure with parameters for simulation rounds in a wireless sensor network.
    %
    % Inputs:
    % numRound - Number of rounds for the network simulation.
    % packetLength - Length of packets sent from CH to BS (in bits).
    % ctrPacketLength - Length of control packets sent from nodes to CH (in bits).
    %
    % Output:
    % NetRound - A structure containing the initialized parameters for network rounds.

    % Check if 'numRound' is provided, else default to 9000 rounds.
    if nargin < 1 || isempty(numRound)
        NetRound.numRound = 9000;
    else
        NetRound.numRound = numRound;
    end
    
    % Check if 'packetLength' is provided, else default to 6400 bits.
    if nargin < 2 || isempty(packetLength)
        NetRound.packetLength = 6400;
    else
        NetRound.packetLength = packetLength;
    end
    
    % Check if 'ctrPacketLength' is provided, else default to 200 bits.
    if nargin < 3 || isempty(ctrPacketLength)
        NetRound.ctrPacketLength = 200;
    else
        NetRound.ctrPacketLength = ctrPacketLength;
    end
end

