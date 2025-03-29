%% Multivariate linear regeression and with age, height, sex as covariates

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [cngdat] = GaitPatternMLR(tdat, ngdat)

% Get each group's indices
HC_idx = tdat(:, 1) == 1;
RBD_idx = tdat(:, 1) == 2;
ePD_idx = tdat(:, 1) == 3;
aPDoff_idx = tdat(:, 1) == 4;
aPDon_idx = tdat(:, 1) == 5;
MSAC_idx = tdat(:, 1) == 6;

% Get age, sex, height data from tdat
HC_age = tdat(HC_idx, 2); HC_sex = tdat(HC_idx, 3); HC_height = tdat(HC_idx, 4);
RBD_age = tdat(RBD_idx, 2); RBD_sex = tdat(RBD_idx, 3); RBD_height = tdat(RBD_idx, 4);
ePD_age = tdat(ePD_idx, 2); ePD_sex = tdat(ePD_idx, 3); ePD_height = tdat(ePD_idx, 4);
aPDoff_age = tdat(aPDoff_idx, 2); aPDoff_sex = tdat(aPDoff_idx, 3); aPDoff_height = tdat(aPDoff_idx, 4);
aPDon_age = tdat(aPDon_idx, 2); aPDon_sex = tdat(aPDon_idx, 3); aPDon_height = tdat(aPDon_idx, 4);
MSAC_age = tdat(MSAC_idx, 2); MSAC_sex = tdat(MSAC_idx, 3); MSAC_height = tdat(MSAC_idx, 4);

% Get normalized gait data for each group
HC_ngdat = ngdat(HC_idx, :);
RBD_ngdat = ngdat(RBD_idx, :);
ePD_ngdat = ngdat(ePD_idx, :);
aPDoff_ngdat = ngdat(aPDoff_idx, :);
aPDon_ngdat = ngdat(aPDon_idx, :);
MSAC_ngdat = ngdat(MSAC_idx, :);

% Linear regression for HC group
coefficients = cell(size(ngdat, 2), 1);
for idx = 1:size(ngdat, 2)
    independent_var = HC_ngdat(:, idx); % Individual gait parameter as independant variables
    dependent_vars = [HC_age, HC_height, HC_sex]; % Age, Height, and Sex as dependant variables
    [b, ~, ~] = glmfit(dependent_vars, independent_var, 'normal');
    coefficients{idx} = b;
end

% Correct each group by HC linear regression
HC_cngdat = SubgroupRegression(HC_ngdat, coefficients, HC_age, HC_height, HC_sex);
RBD_cngdat = SubgroupRegression(RBD_ngdat, coefficients, RBD_age, RBD_height, RBD_sex);
ePD_cngdat = SubgroupRegression(ePD_ngdat, coefficients, ePD_age, ePD_height, ePD_sex);
aPDoff_cngdat = SubgroupRegression(aPDoff_ngdat, coefficients, aPDoff_age, aPDoff_height, aPDoff_sex);
aPDon_cngdat = SubgroupRegression(aPDon_ngdat, coefficients, aPDon_age, aPDon_height, aPDon_sex);
MSAC_cngdat = SubgroupRegression(MSAC_ngdat, coefficients, MSAC_age, MSAC_height, MSAC_sex);

cngdat = [HC_cngdat; RBD_cngdat; ePD_cngdat; aPDoff_cngdat; aPDon_cngdat; MSAC_cngdat];

end

function [cngdat] = SubgroupRegression(ngdat, coefficients, age, height, sex)
cngdat = zeros(size(ngdat));
for idx = 1:size(ngdat, 2)
    b1 = coefficients{idx}(1);
    b2 = coefficients{idx}(2);
    b3 = coefficients{idx}(3);
    b4 = coefficients{idx}(4);
    correction = b1 + b2*age + b3*height + b4*sex;
    cngdat(:, idx) = ngdat(:, idx) - correction;
end

end