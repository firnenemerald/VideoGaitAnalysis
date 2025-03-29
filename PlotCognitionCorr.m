%% Function to plot Gait score vs Cognition correlation

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [] = PlotCognitionCorr(score, cognition, scoreGroup, groupName, saveDir)

    X_name = Num2Group(scoreGroup(1));
    Y_name = Num2Group(scoreGroup(2));

    cognition_label = ["Edu", "TMT_A", "TMT_B", "TMT_C", "Lang", "KA_trial", "KA_DRc", "KA_DRn", "KC_Draw", "KC_IRc", "KC_DRc", "STR_color", "STR_word", "STR_CW", "FLU_pho", "FLU_cat"];

    score_copy = score;

    %% Plot the data
    for i = 2:16
        
        cognition_sub = cognition(:, i);
        score = score_copy;

        % Remove NaN values
        nanIdx = isnan(cognition_sub);
        cognition_sub(nanIdx) = [];
        score(nanIdx) = [];
        
        fig = figure;
        hold on
        scatter(cognition_sub, score, 20, 'o', 'MarkerEdgeColor', [1, 1, 1], 'MarkerFaceColor', [0.3, 0.3, 0.3]);
        title(groupName)
        xlabel(cognition_label(i), "Interpreter", "none");
        ylabel('Gait pattern Z-score');

        [r, p] = corr(cognition_sub, score);
        linearfit = polyfit(cognition_sub, score, 1);
        xfit = linspace(min(cognition_sub), max(cognition_sub), 100);
        yfit = polyval(linearfit, xfit);
        plot(xfit, yfit, '-r', 'Linewidth', 1.5);
        xlimit = xlim; ylimit = ylim;
        text(xlimit(2), ylimit(2), sprintf('R = %.2f, p = %.5f', r, p), 'HorizontalAlignment', 'right');
        hold off

        saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_', cognition_label(i), '_corr'), 'svg');
        saveas(fig, strcat(saveDir, 'Group_', groupName, '_Pattern_', Y_name, '_', cognition_label(i), '_corr'), 'png');

    end

end