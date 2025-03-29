%% PlotPCACovar.m (ver 1.0.240923)
% Plot SSM-PCA covariate matrix in a heatmap fashion

% Copyright (C) 2024 Chanhee Jeong

% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

function [] = PlotPCAProcess(C, explained, scoreGroup, saveDir)

X_name = Num2Group(scoreGroup(1));
Y_name = Num2Group(scoreGroup(2));

pcac = figure;
imagesc(C);
clim([-10, 15]);
colormap(redblue);
colorbar
saveas(pcac, strcat(saveDir, Y_name, '_vs_', X_name, '_PCAcovmat'), 'svg');
saveas(pcac, strcat(saveDir, Y_name, '_vs_', X_name, '_PCAcovmat'), 'png');

pcae = figure;
bar(explained);
xlim([0, 20]);
yline(5);
saveas(pcae, strcat(saveDir, Y_name, '_vs_', X_name, '_PCAexplained'), 'svg');
saveas(pcae, strcat(saveDir, Y_name, '_vs_', X_name, '_PCAexplained'), 'png');

% Print the percentage of variance explained by PC1, PC2, PC3, PC4, and PC5
explainedPCs = explained(1:5);
disp('Percentage of variance explained by PC1, PC2, PC3, PC4, and PC5:');
disp(explainedPCs);

% Calculate and display the sum of the explained variance by the first 5 PCs
sumExplained = sum(explainedPCs);
disp('Sum of the percentage of variance explained by PC1 to PC5:');
disp(sumExplained);

end