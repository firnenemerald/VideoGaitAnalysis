%% Main script for RBD conversion prediction

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

%% Clear workspace
clear
close all

% Construct save directory as ../Figures/YYMMDD/
currentDate = datetime('today', 'Format', 'yyMMdd');
saveDir = fullfile(strcat('C:\\Users\\chanh\\OneDrive\\문서\\__MyDocuments__\\3. Research\\3. Gait Analysis (Pf. Shin)\\Gaitome PD Paper\\Figures_', char(currentDate)), '\\');

% Create the directory if it does not exist
if ~exist(saveDir, 'dir')
    mkdir(saveDir);
end

THRESHOLD = -0.75;
THRESHOLD_1 = 1.7553;
THRESHOLD_2 = 1.3747;

%% Load the data
Score_data = readtable('data/ALL_tdat.xlsx', 'VariableNamingRule', 'preserve');
Score_numeric = Score_data{:, vartype('numeric')};
Score_tdat = Score_numeric(31:114, 9:14);

% Score_tdat = [aPD, ePD, aPD-ePD, MSAC, aPD-MSAC, ePD-MSAC]

%% Plot the data (ePD-MSAC vs ePD)

% Create a colormap based on conditions
colors = repmat('#808080', size(Score_tdat, 1), 1);
for i = 1:size(Score_tdat, 1)
    if Score_tdat(i, 6) > (THRESHOLD + 1) && Score_tdat(i, 2) > (THRESHOLD_1)
        colors(i, :) = '#FF0000';
        disp("RBD conversion to ePD likely index: " + i)
    end
end

% Re-plot with colored points
figure
hold on
for i = 1:size(Score_tdat, 1)
    scatter(Score_tdat(i, 6)-THRESHOLD, Score_tdat(i, 2), 20, 'filled', 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(i, :))
end
xlabel('ePD vs MSA-C')
ylabel('ePD')
title('RBD conversion to ePD likely')
grid on
axis equal
xlim([-4 6])
ylim([-4.5 5.5])

xline(0, 'k-', 'LineWidth', 2)
xline(+1, 'r--', 'LineWidth', 2)
xline(-1, 'k--', 'LineWidth', 2)

%yline(THRESHOLD_1, 'k-', 'LineWidth', 2)
yline(THRESHOLD_1, 'r--', 'LineWidth', 2)

%% Plot the data (ePD-MSAC vs MSAC)

% Create a colormap based on conditions
colors2 = repmat('#808080', size(Score_tdat, 1), 1);
for i = 1:size(Score_tdat, 1)
    if Score_tdat(i, 6) < (THRESHOLD-1) && Score_tdat(i, 4) > (THRESHOLD_2)
        colors2(i, :) = '#0000FF';
        disp("RBD conversion to MSA-C likely index: " + i)
    end
end

figure
hold on
for i = 1:size(Score_tdat, 1)
    scatter(Score_tdat(i, 6)-THRESHOLD, Score_tdat(i, 4), 20, 'filled', 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors2(i, :))
end
xlabel('ePD vs MSA-C')
ylabel('MSAC')
title('RBD conversion to MSA-C likely')
grid on
axis equal
xlim([-4 6])
ylim([-4.5 5.5])

xline(0, 'k-', 'LineWidth', 2)
xline(1, 'k--', 'LineWidth', 2)
xline(-1, 'b--', 'LineWidth', 2)

%yline(THRESHOLD_2, 'k--', 'LineWidth', 2)
yline(THRESHOLD_2, 'b--', 'LineWidth', 2)

% % Save the figure
% saveas(gcf, strcat(saveDir, 'RBDconv_aPD_MSAC'), 'svg')
% saveas(gcf, strcat(saveDir, 'RBDconv_aPD_MSAC'), 'png')