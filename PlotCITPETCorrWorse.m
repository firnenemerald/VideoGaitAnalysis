%% FP-CIT PET worse value correlation with gait pattern score

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [] = PlotCITPETCorrWorse(score, citpet, option, scoreGroup, saveDir)

citpet_nanIdx = any(isnan(citpet), 2);
score(citpet_nanIdx, :) = [];
citpet(citpet_nanIdx, :) = [];

patternName = Num2Group(scoreGroup(2));

roiList = {'Sd', 'C', 'Cda', 'Cva', 'Ct', 'Cb', 'P', 'Pda', 'Pva', 'Pdp', 'Pvp', 'GP', 'GPa', 'GPp', 'Sv', 'DRN', 'LC', 'SN', 'STN'};

citData_both = citpet(:, 1:19);
citData_left = citpet(:, 20:38);
citData_right = citpet(:, 39:57);
citData_worse = min(citData_left, citData_right);

if option == "both"
    citData = citData_both;
elseif option == "left"
    citData = citData_left;
elseif option == "right"
    citData = citData_right;
elseif option == "worse"
    citData = citData_worse;
else
    error('Invalid option');
end

roiNum = size(citData, 2);
corrTable = zeros(1, roiNum);
signTable = ones(1, roiNum);
for idx = 1:roiNum
    [r, p] = corr(citData(:, idx), score);
    corrTable(1, idx) = r;
    signTable(1, idx) = p;
end

figure
hold on
ax1 = gca;
ax1.PlotBoxAspectRatio = [roiNum, 1, 1];
imagesc(ConvertPValue(signTable));

colormap(ax1, [1 1 1; linspace(1, 1, 256)', linspace(1, 0, 256)', linspace(1, 0, 256)']);
clim([0, 20]);
colorbar;

for i = 1:19
    text(ax1, i, 1, sprintf('%.3f\n(%.5f)', corrTable(i), signTable(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'k', 'FontSize', 6);
end

plot(ax1, [0.5, 19.5], [0.5, 0.5], 'k-', 'LineWidth', 1);
plot(ax1, [0.5, 19.5], [1.5, 1.5], 'k-', 'LineWidth', 1);
for i = 0.5:19.5
    plot(ax1, [i, i], [0.5, 1.5], 'k-', 'LineWidth', 1);
end
hold off

ax1.XTick = 1:19;
ax1.XTickLabel = roiList;

% save figure
if ~isempty(saveDir)
    saveas(gcf, fullfile(saveDir, sprintf('CITPET_corr_%s_%s.png', patternName, option)));
    saveas(gcf, fullfile(saveDir, sprintf('CITPET_corr_%s_%s.svg', patternName, option)));
end

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