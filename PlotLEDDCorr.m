%% Function to plot Gait score vs LEDD correlation

function [] = PlotLEDDCorr(score, ledd, scoreGroup, groupName, saveDir)

    X_name = Num2Group(scoreGroup(1));
    Y_name = Num2Group(scoreGroup(2));
    
    %% Inspect data and remove NaN values
    nanIdx = isnan(ledd) | isnan(score);
    ledd(nanIdx) = [];
    score(nanIdx) = [];

    %% Plot the data
    fig = figure;
    hold on
    scatter(ledd, score, 20, 'o', 'MarkerEdgeColor', [1, 1, 1], 'MarkerFaceColor', [0.3, 0.3, 0.3]);
    title(groupName)
    xlabel('LEDD');
    ylabel('Gait pattern Z-score');

    [r, p] = corr(ledd, score);
    linearfit = polyfit(ledd, score, 1);
    xfit = linspace(min(ledd), max(ledd), 100);
    yfit = polyval(linearfit, xfit);
    plot(xfit, yfit, '-r', 'Linewidth', 1.5);
    xlimit = xlim; ylimit = ylim;
    text(xlimit(2), ylimit(2), sprintf('R = %.2f, p = %.5f', r, p), 'HorizontalAlignment', 'right');
    hold off

    saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_leddcorr'), 'svg');
    saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_leddcorr'), 'png');

end