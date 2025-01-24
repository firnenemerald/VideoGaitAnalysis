%% GaitPatternScoring.m (ver 1.0.240820)
% Gait pattern scoring with gait parameters

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

function [groupName] = Num2Group(number)

groupName = "";
switch number
    case 1
        groupName = "HC";
    case 2
        groupName = "RBD";
    case 3
        groupName = "ePD";
    case 4
        groupName = "aPDoff";
    case 5
        groupName = "aPDon";
    case 6
        groupName = "MSAC";
    case 7
        groupName = "MSAC";
    case 8
        groupName = "MSAC CIT low";
    case 9
        groupName = "MSAC CIT high";
    case 10
        groupName = "MSAC CIT lowint";
end

end