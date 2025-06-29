%% Main script for gait pattern extraction, gait pattern scoring, and gait pattern analysis

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

% Clear workspace and close all figures
clear
close all

% Construct save directory as ../Figures/YYMMDD/
currentDate = datetime('today', 'Format', 'yyMMdd');
saveDir = fullfile(strcat('C:\\Users\\chanh\\OneDrive\\문서\\__MyDocuments__\\3. Research\\3. Gait Analysis (Pf. Shin)\\Gaitome PD Paper\\Figures_', char(currentDate)), '\\');

% Create the directory if it does not exist
if ~exist(saveDir, 'dir')
    mkdir(saveDir);
end

%% 18 Gait parameter description
% Forward parameters (8 -> 7)
% 1 - step length (mean)
% 2 - step length (cv)
% 3 - step time (mean)
% 4 - step time (cv)
% 5 - step width (mean)
% 6 - step width (cv) -> omitted
% 7 - cadence
% 8 - velocity

% Asymmetry parameters (2)
% 9 - step length asymmetry
% 10 - arm swing asymmetry

% Turning variables (12 -> 7)
% 11 - turning time (mean)
% 12 - turning time (cv) -> omitted
% 13 - turning step length (mean)
% 14 - turning step length (cv) -> omitted
% 15 - turning step time (mean)
% 16 - turning step time (cv) -> omitted
% 17 - turning step width (mean)
% 18 - turning step width (cv) -> omitted
% 19 - turning step number (mean)
% 20 - turning step number (cv) -> omitted
% 21 - turning cadence
% 22 - turning velocity

% Posture variables (2)
% 23 - anterior flexion angle
% 24 - dropped head angle

%% Import gait parameters
% HC_tdat = 30 healthy controls [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3 = 0, duration = 0]
% RBD_tdat = 85 REM sleep behavior disorder patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration = 0]
% ePD_tdat = 35 early PD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration, u1_1-13, u2_1-13, u3_1-18 (18), HY, CIT-PET ROI 1-69 (69)]
% aPDoff_tdat = 56 medication OFF advanced PD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration, LEDD, u1_1-4, u2_1-13, u3_1-11 (11), HY, CIT-PET ROI 1-69 (69)]
% aPDon_tdat = 32 medication ON advanced PD patients [PID, Name, Age, Sex, Height, 24 params, updrs p1,2,3, duration, LEDD, u1_1-4, u2_1-13, u3_1-11 (11), HY]

% Import HC_tdat (N=30)
HC_data = readtable('data/HC_tdat.xlsx', 'VariableNamingRule', 'preserve');
HC_numeric = HC_data{:, vartype('numeric')};
HC_tdat = HC_numeric(:,2:32); % [30x31: Age, Sex, Height, 24 params, updrs p1,2,3 = 0, duration = 0]

% Import RBD_tdat (N=85, 1 patient outlier)
RBD_data = readtable('data\RBD_tdat.xlsx', 'VariableNamingRule', 'preserve');
RBD_numeric = RBD_data{:, vartype('numeric')};
RBD_tdat = RBD_numeric(:, 2:32); % [85x31: Age, Sex, Height, 24 params, updrs p1,2,3, duration = 0]
% Remove 7th patient (outlier)
RBD_tdat(7, :) = [];

% Import ePD_tdat, ePD_updrs, ePD_citpet (N=35)
ePD_data = readtable('data\ePD_tdat.xlsx', 'VariableNamingRule', 'preserve');
ePD_numeric = ePD_data{:, vartype('numeric')};
ePD_tdat = ePD_numeric(:, 2:32); % [35x31: Age, Sex, Height, 24 params, updrs p1,2,3, duration]
% Import ePD_updrs
ePD_updrs = ePD_numeric(:, 33:77); % [35x41: MDS-UPDRS u1-1~13, u2-1~13, u3-1~18, HY]
% Import ePD_citpet
ePD_citpet = ePD_numeric(:, 78:146); % [35x69: CIT-PET ROI 1~69]
% Import ePD_mmse
ePD_mmse = ePD_numeric(:, 147); % [35x1: MMSE]

% Import aPDoff_tdat, aPDoff_updrs, aPD_ledd, aPD_citpet, aPD_cognitive (N=56, 2 patient outlier)
aPDoff_data = readtable('data\aPDoff_tdat.xlsx', 'VariableNamingRule', 'preserve');
aPDoff_numeric = aPDoff_data{:, vartype('numeric')};
aPDoff_tdat = aPDoff_numeric(:, 2:32); % [56x31: Age, Sex, Height, 24 params, updrs p1,2,3, duration]
% Import aPD_ledd
aPD_ledd = aPDoff_numeric(:, 33); % [56x1: LEDD]
aPD_ledd([10], :) = NaN * ones(1, 1);
% Import aPDoff_updrs
aPDoff_updrs = aPDoff_numeric(:, 34:62); % [56x29: Old UPDRS u1-1~4, u2-1~13, u3-1~11, HY]
% Import aPD_citpet
aPD_citpet = aPDoff_numeric(:, 63:131); % [56x69: CIT-PET ROI 1~69]
aPD_citpet([7, 11, 38, 56], :) = NaN * ones(4, 69);
% aPD_citpet([6, 7, 11, 13, 38, 45, 56], :) = NaN * ones(7, 69);
% Import aPD_cognitive
aPD_mmse = aPDoff_numeric(:, 132); % [56x1: MMSE]
aPD_cognitive = aPDoff_numeric(:, 133:148); % [56x16: Edu, TMT_A, TMT_B, TMT_C, Lang, KA_trial, KA_DRc, KA_DRn, KC_Draw, KC_IRc, KC_DRc, STR_color, STR_word, STR_CW, FLU_pho, FLU_sem]
% Remove 10th, 52nd patient (outlier)
aPDoff_tdat([10, 52], :) = []; aPD_ledd([10, 52], :) = []; aPDoff_updrs([10, 52], :) = []; aPD_citpet([10, 52], :) = []; aPD_mmse([10, 52], :) = []; aPD_cognitive([10, 52], :) = [];

% Import aPDon_tdat, aPDon_updrs (N=32, 1 patient outlier)
aPDon_data = readtable('data\aPDon_tdat.xlsx', 'VariableNamingRule', 'preserve');
aPDon_numeric = aPDon_data{:, vartype('numeric')};
aPDon_tdat = aPDon_numeric(:, 2:32); % [32x31: Age, Sex, Height, 24 params, updrs1,2,3, duration]
% Import aPDon_updrs
aPDon_updrs = aPDon_numeric(:, 33:61); % [32x29: Old UPDRS u1-1~4, u2-1~13, u3-1~11, HY]
% Remove 10th patient (outlier)
aPDon_tdat([10], :) = []; aPDon_updrs([10], :) = [];

% Import MSAC_tdat (N=35)
MSAC_data = readtable('data\MSAC_tdat.xlsx', 'VariableNamingRule', 'preserve');
MSAC_numeric = MSAC_data{:, vartype('numeric')};
MSAC_tdat = MSAC_numeric(:, 2:32); % [35x31: Age, Sex, Height, 24 params, umsar p1,2, null, duration]

% Import MSACSc_tdat (N=39)
MSACSc_data = readtable('data\MSAC_tdat_39.xlsx', 'VariableNamingRule', 'preserve');
MSACSc_numeric = MSACSc_data{:, vartype('numeric')};
MSACSc_tdat = MSACSc_numeric(:, 2:32); % [39x31: Age, Sex, Height, 24 params, umsar p1,2, null, null]

% Get age, sex, height, updrs data from tdat
HC_age = HC_tdat(:, 1); HC_sex = HC_tdat(:, 2); HC_height = HC_tdat(:, 3);
RBD_age = RBD_tdat(:, 1); RBD_sex = RBD_tdat(:, 2); RBD_height = RBD_tdat(:, 3);
RBD_u1 = RBD_tdat(:, 28); RBD_u2 = RBD_tdat(:, 29); RBD_u3 = RBD_tdat(:, 30); RBD_ut = RBD_u1 + RBD_u2 + RBD_u3;
ePD_age = ePD_tdat(:, 1); ePD_sex = ePD_tdat(:, 2); ePD_height = ePD_tdat(:, 3);
ePD_u1 = ePD_tdat(:, 28); ePD_u2 = ePD_tdat(:, 29); ePD_u3 = ePD_tdat(:, 30); ePD_ut = ePD_u1 + ePD_u2 + ePD_u3; ePD_dur = ePD_tdat(:, 31);
aPDoff_age = aPDoff_tdat(:, 1); aPDoff_sex = aPDoff_tdat(:, 2); aPDoff_height = aPDoff_tdat(:, 3);
aPDoff_u1 = aPDoff_tdat(:, 28); aPDoff_u2 = aPDoff_tdat(:, 29); aPDoff_u3 = aPDoff_tdat(:, 30); aPDoff_ut = aPDoff_u1 + aPDoff_u2 + aPDoff_u3; aPDoff_dur = aPDoff_tdat(:, 31);
aPDon_age = aPDon_tdat(:, 1); aPDon_sex = aPDon_tdat(:, 2); aPDon_height = aPDon_tdat(:, 3);
aPDon_u1 = aPDon_tdat(:, 28); aPDon_u2 = aPDon_tdat(:, 29); aPDon_u3 = aPDon_tdat(:, 30); aPDon_ut = aPDon_u1 + aPDon_u2 + aPDon_u3; aPDon_dur = aPDon_tdat(:, 31);
MSAC_age = MSAC_tdat(:, 1); MSAC_sex = MSAC_tdat(:, 2); MSAC_height = MSAC_tdat(:, 3); MSAC_dur = MSAC_tdat(:, 31);

%% Result: Baseline characteristics [table]
disp("Baseline characteristics");
disp("HC: " + size(HC_tdat, 1) + " patients" + " (Age: " + mean(HC_age, "omitmissing") + " ± " + std(HC_age, "omitmissing") + " years, Sex: " + sum(HC_sex==1) + "M/" + sum(HC_sex==2) + "F, Height: " + mean(HC_height, "omitmissing") + " ± " + std(HC_height, "omitmissing") + " cm)");
disp("RBD: " + size(RBD_tdat, 1) + " patients" + " (Age: " + mean(RBD_age, "omitmissing") + " ± " + std(RBD_age, "omitmissing") + " years, Sex: " + sum(RBD_sex==1) + "M/" + sum(RBD_sex==2) + "F, Height: " + mean(RBD_height, "omitmissing") + " ± " + std(RBD_height, "omitmissing") + " cm)");
disp("... u1: " + mean(RBD_u1, "omitmissing") + " ± " + std(RBD_u1, "omitmissing") + ", u2: " + mean(RBD_u2, "omitmissing") + " ± " + std(RBD_u2, "omitmissing") + ", u3: " + mean(RBD_u3, "omitmissing") + " ± " + std(RBD_u3, "omitmissing"));
disp("ePD: " + size(ePD_tdat, 1) + " patients" + " (Age: " + mean(ePD_age, "omitmissing") + " ± " + std(ePD_age, "omitmissing") + " years, Sex: " + sum(ePD_sex==1) + "M/" + sum(ePD_sex==2) + "F, Height: " + mean(ePD_height, "omitmissing") + " ± " + std(ePD_height, "omitmissing") + " cm)");
disp("... duration: " + mean(ePD_dur, "omitmissing") + " ± " + std(ePD_dur, "omitmissing"));
disp("... u1: " + mean(ePD_u1, "omitmissing") + " ± " + std(ePD_u1, "omitmissing") + ", u2: " + mean(ePD_u2, "omitmissing") + " ± " + std(ePD_u2, "omitmissing") + ", u3: " + mean(ePD_u3, "omitmissing") + " ± " + std(ePD_u3, "omitmissing"));
disp("aPDoff: " + size(aPDoff_tdat, 1) + " patients" + " (Age: " + mean(aPDoff_age, "omitmissing") + " ± " + std(aPDoff_age, "omitmissing") + " years, Sex: " + sum(aPDoff_sex==1) + "M/" + sum(aPDoff_sex==2) + "F, Height: " + mean(aPDoff_height, "omitmissing") + " ± " + std(aPDoff_height, "omitmissing") + " cm)");
disp("... duration: " + mean(aPDoff_dur, "omitmissing") + " ± " + std(aPDoff_dur, "omitmissing"));
disp("... u1: " + mean(aPDoff_u1, "omitmissing") + " ± " + std(aPDoff_u1, "omitmissing") + ", u2: " + mean(aPDoff_u2, "omitmissing") + " ± " + std(aPDoff_u2, "omitmissing") + ", u3: " + mean(aPDoff_u3, "omitmissing") + " ± " + std(aPDoff_u3, "omitmissing"));

%% Structure data into one array: total data (tdat)
HC = [1*ones(size(HC_tdat, 1), 1), HC_tdat];
RBD = [2*ones(size(RBD_tdat, 1), 1), RBD_tdat];
ePD = [3*ones(size(ePD_tdat, 1), 1), ePD_tdat];
aPDoff = [4*ones(size(aPDoff_tdat, 1), 1), aPDoff_tdat];
aPDon = [5*ones(size(aPDon_tdat, 1), 1), aPDon_tdat];
MSAC = [6*ones(size(MSAC_tdat, 1), 1), MSAC_tdat];
tdat = [HC; RBD; ePD; aPDoff; aPDon; MSAC];

% Get gait parameters (gdat)
gdat = tdat(:, 5:28);
gdat(:, [6, 12, 14, 16, 18, 20]) = [];

% Remove data with NaN element within gait parameters
nanIdx = any(isnan(gdat), 2);
tdat(nanIdx, :) = []; gdat(nanIdx, :) = [];

%% Normalize gait parameters
mHC = mean(gdat(tdat(:, 1) == 1, :));
sHC = std(gdat(tdat(:, 1) == 1, :));
ngdat = zeros(size(gdat));
for idx = 1:size(gdat, 2)
    ngdat(:, idx) = (gdat(:, idx) - mHC(:, idx))/sHC(:, idx);
end

%% Multivariate linear regression
cngdat = GaitPatternMLR(tdat, ngdat);
cngdat_HC = cngdat(tdat(:, 1) == 1, :);
cngdat_RBD = cngdat(tdat(:, 1) == 2, :);
cngdat_ePD = cngdat(tdat(:, 1) == 3, :);
cngdat_aPDoff = cngdat(tdat(:, 1) == 4, :);
cngdat_aPDon = cngdat(tdat(:, 1) == 5, :);
cngdat_MSAC = cngdat(tdat(:, 1) == 6, :);

%========================================%
% Select groups for analysis             %
scoreGroup = [1, 3]; % ePD (vs HC)     %
% scoreGroup = [1, 4]; % aPDoff (vs HC)  %
% scoreGroup = [1, 6]; % MSAC (vs HC)    %
% scoreGroup = [3, 4]; % aPDoff vs ePD   %
% scoreGroup = [6, 3]; % ePD vs MSAC     %
% scoreGroup = [6, 4]; % aPDoff vs MSAC  %
%========================================%

groupX = cngdat(tdat(:, 1) == scoreGroup(1), :);
groupY = cngdat(tdat(:, 1) == scoreGroup(2), :);

%% Result: Gait parameter visualization (heatmap) [figure]
% PlotGaitParamHeat(cngdat_HC, "HC", saveDir, true);
% PlotGaitParamHeat(cngdat_ePD, "ePD", saveDir, true);
% PlotGaitParamHeat(cngdat_aPDoff, "aPD", saveDir, true);

%% Result: SSM-PCA and visualization (AOC curve, Covariate matrix, Explained bar graph) [figure]
[PCA_eigen, e, GIS_Yz, C, explained] = GaitPatternPCA(groupX, groupY, scoreGroup, saveDir, true);

% Plot covariate matrix and explained components
PlotPCAProcess(C, explained, scoreGroup, saveDir);

%% Result: Gait pattern and visualization (pattern bar graph) [figure]
PlotGaitPattern(GIS_Yz, scoreGroup, saveDir);

%% Calculate each group's gait pattern score
score_HC = cngdat_HC * GIS_Yz;
score_RBD = cngdat_RBD * GIS_Yz;
score_ePD = cngdat_ePD * GIS_Yz;
score_aPDoff = cngdat_aPDoff * GIS_Yz;
score_aPDon = cngdat_aPDon * GIS_Yz;
score_MSAC = cngdat_MSAC * GIS_Yz;

% Normalize gait pattern score
msHC = mean(score_HC); ssHC = std(score_HC);
score_HC = (score_HC - msHC)/ssHC;
score_RBD = (score_RBD - msHC)/ssHC;
score_ePD = (score_ePD - msHC)/ssHC;
score_aPDoff = (score_aPDoff - msHC)/ssHC;
score_aPDon = (score_aPDon - msHC)/ssHC;
score_MSAC = (score_MSAC - msHC)/ssHC;

%% Figure out threshold for aPDoff vs MSA-C
% disp(FindThresholdScore(score_MSAC, score_HC));

%% Result: Gait pattern score - Multiple group comparison (bar graph) [figure]
% PlotPatternScore(tdat, cngdat, GIS_Yz, scoreGroup, saveDir);

%% Result: Gait pattern score - UPDRS total correlation (scatter plot) [figure]
% PlotUPDRSCorr(aPDoff_u1, score_aPDoff, scoreGroup, "aPD", "u1", saveDir);
% PlotUPDRSCorr(aPDoff_u2, score_aPDoff, scoreGroup, "aPD", "u2", saveDir);
% PlotUPDRSCorr(aPDoff_u3, score_aPDoff, scoreGroup, "aPD", "u3", saveDir);
% PlotUPDRSCorr(aPDoff_ut, score_aPDoff, scoreGroup, "aPD", "ut", saveDir);
% PlotUPDRSCorr(ePD_u1, score_ePD, scoreGroup, "ePD", "u1", saveDir);
% PlotUPDRSCorr(ePD_u2, score_ePD, scoreGroup, "ePD", "u2", saveDir);
% PlotUPDRSCorr(ePD_u3, score_ePD, scoreGroup, "ePD", "u3", saveDir);
% PlotUPDRSCorr(ePD_ut, score_ePD, scoreGroup, "ePD", "ut", saveDir);

%% Result: Gait pattern score - UPDRS part3 individual correlation (scatter plot) [figure]
% PlotUPDRSIndivCorr(aPDoff_updrs, score_aPDoff, scoreGroup, "aPD", "u3", saveDir);
% PlotUPDRSIndivCorr(ePD_updrs, score_ePD, scoreGroup, "ePD", "u3", saveDir);

%% Result: Gait pattern score - LEDD correlation (scatter plot) [figure]
% PlotLEDDCorr(score_aPDoff, aPD_ledd, scoreGroup, "aPD", saveDir);

%% Result: Gait pattern score - aPD ON vs OFF states with LEDD
% aPDoff_concat = [score_aPDoff, aPDoff_u1, aPDoff_u2, aPDoff_u3, aPDoff_ut];
% aPDoff_concat = aPDoff_concat(1:size(aPDon_tdat, 1), :);

% aPDon_nanIdx = isnan(aPDon_tdat(:, 26));
% aPDon_nanIdx(end) = 1;
% aPDoff_concat(aPDon_nanIdx, :) = [];

% aPD_ledd = aPD_ledd(1:size(aPDon_tdat, 1), :);
% aPD_ledd(aPDon_nanIdx, :) = [];

% score_aPDon(end) = [];
% aPDon_u1(aPDon_nanIdx, :) = []; aPDon_u2(aPDon_nanIdx, :) = []; aPDon_u3(aPDon_nanIdx, :) = []; aPDon_ut(aPDon_nanIdx, :) = [];
% aPDon_concat = [score_aPDon, aPDon_u1, aPDon_u2, aPDon_u3, aPDon_ut];

% PlotOnOffBar(aPDoff_concat, aPDon_concat, aPD_ledd, 'u3', saveDir);

%% Result: Gait pattern score - CIT-PET correlation (scatter plot) [figure]
% PlotCITPETCorrWorse(score_aPDoff, aPD_citpet, "worse", scoreGroup, saveDir);
% PlotCITPETCorrWorse(score_ePD, ePD_citpet, scoreGroup, saveDir);

% PlotCITPETCorr(score_aPDoff, aPD_citpet, scoreGroup, 'ALL', 'b', saveDir);
% PlotCITPETCorr(score_aPDoff, aPD_citpet, scoreGroup, 'Pdp', 'b', saveDir);
% PlotCITPETCorr(score_aPDoff, aPD_citpet, scoreGroup, 'GP', 'b', saveDir);
% PlotCITPETCorr(score_aPDoff, aPD_citpet, scoreGroup, 'LC', 'b', saveDir);
% PlotCITPETCorr(score_aPDoff, aPD_citpet, scoreGroup, 'PC_rat', 'b', saveDir);
% PlotCITPETCorr(score_ePD, ePD_citpet, scoreGroup, 'ALL', 'b', saveDir);
% PlotCITPETCorr(score_ePD, ePD_citpet, scoreGroup, 'Pdp', 'b', saveDir);
% PlotCITPETCorr(score_ePD, ePD_citpet, scoreGroup, 'GP', 'b', saveDir);
% PlotCITPETCorr(score_ePD, ePD_citpet, scoreGroup, 'LC', 'b', saveDir);
% PlotCITPETCorr(score_ePD, ePD_citpet, scoreGroup, 'PC_rat', 'b', saveDir);

% %% Result: Gait pattern score - MMSE correlation (scatter plot) [figure]
% PlotMMSECorr(score_aPDoff, aPD_mmse, scoreGroup, "aPD", saveDir);
% PlotMMSECorr(score_ePD, ePD_mmse, scoreGroup, "ePD", saveDir);

% %% Result: Gait pattern score - Cognitive test correlation (scatter plot) [figure]
% PlotCognitionCorr(score_aPDoff, aPD_cognitive, scoreGroup, "aPD", saveDir);












%{
%% More subgroups
cngdat_MSAC_CITlow = cngdat_MSACSc([3, 11, 15, 16, 26, 27, 29, 33, 34], :);
cngdat_MSAC_CIThigh = cngdat_MSACSc([2, 7, 9, 10, 12, 17, 18, 19, 20, 23, 25, 32, 36, 37, 38, 39], :);
cngdat_MSAC_CITint = cngdat_MSACSc([22, 24, 28, 35], :);
cngdat_MSAC_CITlowint = [cngdat_MSAC_CITlow; cngdat_MSAC_CITint];

% scoreGroup = [8, 9];
% groupX = cngdat_MSAC_CITlow;
% groupY = cngdat_MSAC_CIThigh;

% scoreGroup = [10, 9];
% groupX = cngdat_MSAC_CITlowint;
% groupY = cngdat_MSAC_CIThigh;

% Plot score vs covar graph (before and after regression)
% PlotParameterRegression(tdat, ngdat_p, cngdat, GIS_Yz, 'height');
%}