%% Function for importing gait parameters from gait extractor result .csv files

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

%% Data description
% HC_tdat.xlsx = 30 healthy controls [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3 = 0, duration = 0, u1_1-13, u2_1-13, u3_1-18 (18), HY]
% RBD_tdat.xlsx = 58 RBD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration = 0, u1_1-13, u2_1-13, u3_1-18 (33), HY]
% ePD_tdat.xlsx = 35 early PD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration, u1_1-13, u2_1-13, u3_1-18 (18), HY, CIT-PET ROI 1-69 (69)]
% aPDoff_tdat.xlsx = 56 medication OFF advanced PD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration, LEDD, u1_1-4, u2_1-13, u3_1-11 (11), HY, CIT-PET ROI 1-69 (69)]
% aPDon_tdat.xlsx = 24 medication ON advanced PD patients [PID, Name

% Sex 1 = Male, 2 = Female

% Forward gait parameters (8)
% 1 - step length (mean)
% 2 - step length (cv)
% 3 - step time (mean)
% 4 - step time (cv)
% 5 - step width (mean)
% 6 - step width (cv) -> omit in partial score
% 7 - cadence
% 8 - velocity

% Asymmetry parameters (2)
% 9 - step length asymmetry
% 10 - arm swing asymmetry

% Turning variables (12)
% 11 - turning time (mean)
% 12 - turning time (cv) -> omit in partial score
% 13 - turning step length (mean)
% 14 - turning step length (cv) -> omit in partial score
% 15 - turning step time (mean)
% 16 - turning step time (cv) -> omit in partial score
% 17 - turning step width (mean)
% 18 - turning step width (cv) -> omit in partial score
% 19 - turning step number (mean)
% 20 - turning step number (cv) -> omit in partial score
% 21 - turning cadence
% 22 - turning velocity

% Posture variables (2)
% 23 - anterior flexion angle*
% 24 - dropped head angle*

function [tdat, ngdat_p, ePD_updrs, ePD_citpet, aPD_ledd, aPDoff_updrs, aPD_citpet] = GetParams()

%% Import raw data (gait extractor results)

% Import HC_tdat: [Age, Sex, Height, 24 params, updrs p1,2,3 = 0, duration = 0]
HC_data = readtable('data/HC_tdat.xlsx', 'VariableNamingRule', 'preserve');
HC_numeric = HC_data{:, vartype('numeric')};
HC_tdat = HC_numeric(:,2:32);

% Import RBD_tdat: [Age, Sex, Height, 24 params, updrs p1,2,3, duration = 0]
RBD_data = readtable('data\RBD_tdat.xlsx', 'VariableNamingRule', 'preserve');
RBD_numeric = RBD_data{:, vartype('numeric')};
RBD_tdat = RBD_numeric(:, 2:32);

% Import ePD_tdat: [Age, Sex, Height, 24 params, updrs p1,2,3, duration]
ePD_data = readtable('data\ePD_tdat.xlsx', 'VariableNamingRule', 'preserve');
ePD_numeric = ePD_data{:, vartype('numeric')};
ePD_tdat = ePD_numeric(:, 2:32);
% Import ePD_updrs: [MDS-UPDRS u1-1~13, u2-1~13, u3-1~18, HY]
ePD_updrs = ePD_numeric(:, 33:77);
% Import ePD_citpet: [CIT-PET ROI 1~69]
ePD_citpet = ePD_numeric(:, 78:146);

% Import aPDoff_tdat: [Age, Sex, Height, 24 params, updrs p1,2,3, duration, LEDD]
aPDoff_data = readtable('data\aPDoff_tdat.xlsx', 'VariableNamingRule', 'preserve');
aPDoff_numeric = aPDoff_data{:, vartype('numeric')};
aPDoff_tdat = aPDoff_numeric(:, 2:32);
aPDoff_tdat = aPDoff_tdat([1:56], :); % Remove aPDoff 55th patient
% Import aPD_ledd: [LEDD]
aPD_ledd = aPDoff_numeric(:, 33);
% Import aPDoff_updrs: [OLD UPDRS u1-1~4, u2-1~13, u3-1~11, HY]
aPDoff_updrs = aPDoff_numeric(:, 34:62);
% Import aPD_citpet: [CIT-PET ROI 1~69]
aPD_citpet = aPDoff_numeric(:, 63:131);

% % Import aPDon_tdat
% % [PID, Name, Age, Sex, Height, 24 params, updrs1,2,3, duration]
% aPDon_data = readtable('data\aPDon_tdat.xlsx', 'VariableNamingRule', 'preserve');
% aPDon_numeric = aPDon_data{:, vartype('numeric')};
% aPDon_tdat = aPDon_numeric(:, 2:32);
% % Import aPDon_updrs
% aPDon_updrs = aPDon_numeric(:, 33:74);

% Import MSAC_tdat: [PID, Name, Age, Sex, Height, 24 params, umsar1,2, null, duration]
MSAC_data = readtable('data\MSAC_tdat.xlsx', 'VariableNamingRule', 'preserve');
MSAC_numeric = MSAC_data{:, vartype('numeric')};
MSAC_tdat = MSAC_numeric(:, 2:32);
% Import MSACSc_tdat (group for MSAC scoring): [PID, Name, Age, Sex, Height, 24 params, umsar1,2, null, duration]
MSACSc_data = readtable('data\MSAC_tdat_39.xlsx', 'VariableNamingRule', 'preserve');
MSACSc_numeric = MSACSc_data{:, vartype('numeric')};
MSACSc_tdat = MSACSc_numeric(:, 2:32);

% Structure data into one array: total data (tdat)
HC = [1*ones(size(HC_tdat, 1), 1), HC_tdat];
RBD = [2*ones(size(RBD_tdat, 1), 1), RBD_tdat];
ePD = [3*ones(size(ePD_tdat, 1), 1), ePD_tdat];
aPDoff = [4*ones(size(aPDoff_tdat, 1), 1), aPDoff_tdat];
% aPDon = [5*ones(size(aPDon_tdat, 1), 1), aPDon_tdat];
MSAC = [6*ones(size(MSAC_tdat, 1), 1), MSAC_tdat];
MSACSc = [7*ones(size(MSACSc_tdat, 1), 1), MSACSc_tdat];
tdat = [HC; RBD; ePD; aPDoff; MSAC; MSACSc];

% Get gait parameters (gdat) and partial gait parameters (gdat_p)
% Partial gait parameters are acquired by omitting cv parameters
gdat = tdat(:, 5:28);
gdat_p = gdat;
gdat_p(:, [6, 12, 14, 16, 18, 20]) = [];

% Remove data with NaN element within partial gait parameters
nanIdx = any(isnan(gdat_p), 2);
tdat(nanIdx, :) = [];
gdat(nanIdx, :) = [];
gdat_p(nanIdx, :) = [];

% Since there are some missing values in aPDon_tdat, we need to remove them when comparing with aPDoff_tdat
% Remove LEDD data with NaN element within aPDon partial gait parameters
% aPDon_g = aPDon(:, 4:27);
% aPDon_g_p = aPDon_g;
% aPDon_g_p(:, [6, 12, 14, 16, 18, 20]) = [];
% aPDon_nanIdx = any(isnan(aPDon_g_p), 2);
% aPD_ledd(aPDon_nanIdx, :) = [];

%% Normalize data by HC group to get normalized partial gait parameters (ngdat_p)
mHC = mean(gdat_p(tdat(:, 1) == 1, :));
sHC = std(gdat_p(tdat(:, 1) == 1, :));
ngdat_p = zeros(size(gdat_p));
for idx = 1:size(gdat_p, 2)
    ngdat_p(:, idx) = (gdat_p(:, idx) - mHC(:, idx))/sHC(:, idx);
end

end