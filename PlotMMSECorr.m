%% Function to plot Gait score vs MMSE correlation

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [] = PlotMMSECorr(score, mmse, scoreGroup, groupName, saveDir)

    X_name = Num2Group(scoreGroup(1));
    Y_name = Num2Group(scoreGroup(2));
    
    %% Inspect data and remove NaN values
    nanIdx = isnan(mmse) | isnan(score);
    mmse(nanIdx) = [];
    score(nanIdx) = [];

    %% Plot the data
    fig = figure;
    hold on
    scatter(mmse, score, 20, 'o', 'MarkerEdgeColor', [1, 1, 1], 'MarkerFaceColor', [0.3, 0.3, 0.3]);
    title(groupName)
    xlabel('MMSE');
    ylabel('Gait pattern Z-score');

    [r, p] = corr(mmse, score);
    linearfit = polyfit(mmse, score, 1);
    xfit = linspace(min(mmse), max(mmse), 100);
    yfit = polyval(linearfit, xfit);
    plot(xfit, yfit, '-r', 'Linewidth', 1.5);
    xlimit = xlim; ylimit = ylim;
    text(xlimit(2), ylimit(2), sprintf('R = %.2f, p = %.5f', r, p), 'HorizontalAlignment', 'right');
    hold off

    saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_mmsecorr'), 'svg');
    saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_mmsecorr'), 'png');

end