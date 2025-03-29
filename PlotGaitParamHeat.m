%% PlotGaitParamHeat.m (ver 1.1.241024)
% Plot gait parameters in a heatmap

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

function [] = PlotGaitParamHeat(cngdat, cohortName, saveDir, doSave)

fig = figure;
imagesc(cngdat);
%yline(size(cngdat_aPDoff, 1)+0.5, "LineWidth", 2, "Color", [0 0 0], "Alpha", 1);
%yline(size(cngdat_aPDoff, 1)+size(cngdat_HC, 1)+0.5, "LineWidth", 2, "Color", [0 0 0], "Alpha", 1);
clim([-3, 3]);
colormap(redblue)
colorbar
axis off

if doSave
    saveas(fig, strcat(saveDir, cohortName, '_GaitParamHeat'), 'svg');
    saveas(fig, strcat(saveDir, cohortName, '_GaitParamHeat'), 'png');
end

end