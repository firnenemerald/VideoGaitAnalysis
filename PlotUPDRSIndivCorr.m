%% UPDRS individual score correlation with gait pattern score

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [] = PlotUPDRSIndivCorr(updrs, score, scoreGroup, groupName, updrsName, saveDir)

updrs_u3 = updrs(:, 18:28);  % UPDRS Part 3 scores

% Create descriptive tags for UPDRS Part 3
u3_tags = {"Speech", "Facial expression", "Tremor", "Rigidity", "Hand movement", ...
           "Leg agility", "Arise from chair", "Posture", "Gait", "Postural instability", "Bradykinesia"};

% Calculate correlation and p-values
updrsNum = size(updrs_u3, 2);
corrTable = zeros(1, updrsNum);
signTable = ones(1, updrsNum);
for idx = 1:updrsNum
    [r, p] = corr(updrs_u3(:, idx), score);
    corrTable(1, idx) = r;
    signTable(1, idx) = p;
end

% Create heatmap
figure;
hold on
ax1 = gca;
ax1.PlotBoxAspectRatio = [updrsNum, 1, 1];
imagesc(ConvertPValue(signTable));

colormap(ax1, [1 1 1; linspace(1, 1, 256)', linspace(1, 0, 256)', linspace(1, 0, 256)']);
clim([0, exp(1-20*0.001)]);
colorbar;

for i = 1:updrsNum
    text(ax1, i, 1, sprintf('%.3f\n(%.5f)', corrTable(i), signTable(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'k', 'FontSize', 16);
end

plot(ax1, [0.5, updrsNum+0.5], [0.5, 0.5], 'k-', 'LineWidth', 1);
plot(ax1, [0.5, updrsNum+0.5], [1.5, 1.5], 'k-', 'LineWidth', 1);

for i = 0.5:updrsNum+0.5
    plot(ax1, [i, i], [0.5, 1.5], 'k-', 'LineWidth', 1);
end

% Adjust layout and save figure
sgtitle(sprintf('UPDRS Part 3 Correlation with %s', groupName));
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

xlabel('UPDRS Part 3 Items');
xticks(1:updrsNum);
xticklabels(u3_tags);

% Save the figure
if ~exist(saveDir, 'dir')
    mkdir(saveDir);
end
saveas(gcf, fullfile(saveDir, sprintf('UPDRS_IndivCorr_%s.png', updrsName)));
saveas(gcf, fullfile(saveDir, sprintf('UPDRS_IndivCorr_%s.svg', updrsName)));

end

function psig = ConvertPValue(pvalTable)
    [i, j] = size(pvalTable);
    psig = zeros(i, j);
    for idx = 1:i
        for jdx = 1:j
            psig(idx, jdx) = ConvertPValueSingle(pvalTable(idx, jdx));
        end
    end
end

function psig = ConvertPValueSingle(pval)
    if pval < 0.05
        psig = exp(1-20*pval);
    else
        psig = 0;
    end
end