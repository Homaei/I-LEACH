% Define a MATLAB function named 'fig' with input arguments:
%   - 'data': the data to be plotted
%   - 'r': the number of rounds
%   - 'n': the position of the subplot within the figure
%   - 'yLabel': the label for the y-axis
%   - 'Title': the title for the subplot

function fig(data,r,n,yLabel,Title)

    % Create a new figure with the figure number 2
    figure(2);
    
    % Create a subplot within the figure. The subplot is positioned in a 
    % 1x3 grid, and 'n' specifies which position in the grid the subplot 
    % should occupy.
    subplot(1,3,n);
    
    % Plot the data against the rounds (from 1 to 'r')
    plot(1:r,data);
   
    % Set the x-axis label to 'Round' with specific font properties
    xlabel('Round','FontWeight','bold','FontSize',12,'FontName','Cambria');
    
    % Set the y-axis label to the input 'yLabel' with specific font properties
    ylabel(yLabel,'FontWeight','bold','FontSize',12,...
    'FontName','Cambria');
    
    % Set the subplot title to the input 'Title' with specific font properties
    title(Title,'FontWeight','bold','FontSize',13,...
    'FontName','Cambria');
    
end

