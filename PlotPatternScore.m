%% Plot and compare multiple gait pattern score distributions

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [] = PlotPatternScore(tdat, cngdat, GIS_Yz, groups, saveDir)

X_name = Num2Group(groups(1));
Y_name = Num2Group(groups(2));
expTitle = strcat(X_name, {' '}, 'vs', {' '}, Y_name);

% Get each group's indices
HC_idx = tdat(:, 1) == 1;
RBD_idx = tdat(:, 1) == 2;
ePD_idx = tdat(:, 1) == 3;
aPDoff_idx = tdat(:, 1) == 4;
% aPDon_idx = tdat(:, 1) == 5;
MSAC_idx = tdat(:, 1) == 6

% Get each group's corrected normalized gait parameters
cngdat_HC = cngdat(HC_idx, :);
cngdat_RBD = cngdat(RBD_idx, :);
cngdat_ePD = cngdat(ePD_idx, :);
cngdat_aPDoff = cngdat(aPDoff_idx, :);
% cngdat_aPDon = cngdat(aPDon_idx, :);
cngdat_MSAC = cngdat(MSAC_idx, :);

% Calculate each group's gait pattern score
score_HC = cngdat_HC * GIS_Yz;
score_RBD = cngdat_RBD * GIS_Yz;
score_ePD = cngdat_ePD * GIS_Yz;
score_aPDoff = cngdat_aPDoff * GIS_Yz;
% score_aPDon = cngdat_aPDon * GIS_Yz;
score_MSAC = cngdat_MSAC * GIS_Yz;

% Normalize gait pattern score
msHC = mean(score_HC);
ssHC = std(score_HC);
score_HC = (score_HC - msHC)/ssHC;
score_RBD = (score_RBD - msHC)/ssHC;
score_ePD = (score_ePD - msHC)/ssHC;
score_aPDoff = (score_aPDoff - msHC)/ssHC;
% score_aPDon = (score_aPDon - msHC)/ssHC;
score_MSAC = (score_MSAC - msHC)/ssHC;

group_HC = cell(sum(HC_idx), 1);
group_HC(:, 1) = cellstr('HC');
group_RBD = cell(sum(RBD_idx), 1);
group_RBD(:, 1) = cellstr('RBD');
group_ePD = cell(sum(ePD_idx), 1);
group_ePD(:, 1) = cellstr('ePD');
group_aPDoff = cell(sum(aPDoff_idx), 1);
group_aPDoff(:, 1) = cellstr('aPDoff');
% group_aPDon = cell(sum(aPDon_idx), 1);
% group_aPDon(:, 1) = cellstr('aPDon');
group_MSAC = cell(sum(MSAC_idx), 1);
group_MSAC(:, 1) = cellstr('MSAC');

% Calculate mean and standard error values
mean_HC = mean(score_HC);
se_HC = std(score_HC)/sqrt(length(score_HC));
mean_RBD = mean(score_RBD);
se_RBD = std(score_RBD)/sqrt(length(score_RBD));
mean_ePD = mean(score_ePD);
se_ePD = std(score_ePD)/sqrt(length(score_ePD));
mean_aPDoff = mean(score_aPDoff);
se_aPDoff = std(score_aPDoff)/sqrt(length(score_aPDoff));
% mean_aPDon = mean(score_aPDon);
% se_aPDon = std(score_aPDon)/sqrt(length(score_aPDon));
mean_MSAC = mean(score_MSAC);
se_MSAC = std(score_MSAC)/sqrt(length(score_MSAC));

%% Statistical analysis (ANOVA post-hoc Tukey)
score = [score_HC; score_RBD; score_ePD; score_aPDoff]; %%%%% CHANGE HERE %%%%%
group = [group_HC; group_RBD; group_ePD; group_aPDoff]; %%%%% CHANGE HERE %%%%%
[p, table, stats] = anova1(score, group, 'on');
headingObj = findall(0,'Type','uicontrol','Tag','Heading');
headingObj(1).String = [expTitle, 'ANOVA table'];

[c, ~, ~, gnames] = multcompare(stats, 'alpha', 0.05, 'ctype', 'hsd');
tbl = array2table(c,"VariableNames", ["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"]);
tbl.("Group A") = gnames(tbl.("Group A"));
tbl.("Group B") = gnames(tbl.("Group B"))

%% Draw bar graph
barComp = figure;
hold on

bar_groups = {'HC', 'RBD', 'ePD', 'aPD'}; %%%%% CHANGE HERE %%%%%
bar_means = [mean_HC, mean_RBD, mean_ePD, mean_aPDoff]; %%%%% CHANGE HERE %%%%%
bar_ses = [se_HC, se_RBD, se_ePD, se_aPDoff]; %%%%% CHANGE HERE %%%%%

% Plot bar
barX = categorical(bar_groups);
barX = reordercats(barX, bar_groups);
bar(barX, bar_means, 'EdgeColor', 'black', 'FaceColor', [0.5, 0.5, 0.5], 'FaceAlpha', 0.5);

% Plot individual datapoints
pointEdgeColor = [1, 1, 1];
pointFaceColor = [0.3, 0.3, 0.3];
pointJitterAmount = 0.12;
%%%%% CHANGE HERE %%%%%
scatter(ones(size(score_HC)) * find(barX == 'HC'), score_HC, 15, 'o', 'MarkerEdgeColor', pointEdgeColor, 'MarkerFaceColor', pointFaceColor, 'jitter', 'on', 'jitterAmount', pointJitterAmount);
scatter(ones(size(score_RBD)) * find(barX == 'RBD'), score_RBD, 15, 'o', 'MarkerEdgeColor', pointEdgeColor, 'MarkerFaceColor', pointFaceColor, 'jitter', 'on', 'jitterAmount', pointJitterAmount);
scatter(ones(size(score_ePD)) * find(barX == 'ePD'), score_ePD, 15, 'o', 'MarkerEdgeColor', pointEdgeColor, 'MarkerFaceColor', pointFaceColor, 'jitter', 'on', 'jitterAmount', pointJitterAmount);
scatter(ones(size(score_aPDoff)) * find(barX == 'aPD'), score_aPDoff, 15, 'o', 'MarkerEdgeColor', pointEdgeColor, 'MarkerFaceColor', pointFaceColor, 'jitter', 'on', 'jitterAmount', pointJitterAmount);

% Plot errorbar
errorbar(barX, bar_means, bar_ses, 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'black');

% Title and axis labels
title(expTitle);
xlabel('Groups')
ylabel('Gait pattern Z-score')
ylim([-4, 10]);

hold off

saveas(barComp, strcat(saveDir, Y_name, '_vs_', X_name, '_groupcomparison'), 'svg');
saveas(barComp, strcat(saveDir, Y_name, '_vs_', X_name, '_groupcomparison'), 'png');

end