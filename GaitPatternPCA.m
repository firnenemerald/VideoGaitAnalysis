%% Principal component analysis between two groups

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [PCA_eigen, e, GIS_Yz, C, explained] = GaitPatternPCA(groupX, groupY, groups, saveDir, doSave)

% Get group names
X_name = Num2Group(groups(1));
Y_name = Num2Group(groups(2));
expTitle = strcat(X_name, {' '}, 'vs', {' '}, Y_name);

% Training data and index
PCA_train = [groupX; groupY];
PCA_index = [zeros(size(groupX, 1), 1); ones(size(groupY, 1), 1)];
PCA_size = size(groupX, 1) + size(groupY, 1);

% Normalize for each row data
PCA_trainz = zeros(size(PCA_train));
for idx = 1:PCA_size
    PCA_trainz(idx, :) = zscore(PCA_train(idx, :));
end
PCA_trainzc = PCA_trainz - mean(PCA_trainz);

% Construct the C matrix
C = zeros(PCA_size, PCA_size);
for idxA = 1:PCA_size
    for idxB = 1:PCA_size
        C(idxA, idxB) = sum(PCA_trainzc(idxA, :).*PCA_trainzc(idxB, :));
    end
end

% Do PCA analysis
[coeff, score, ~, ~, explained, mu] = pca(C);
PCA_eigen = PCA_trainzc' * score;

% Make combination of components
tt = 0;
for idxA = 1:5
    temp = nchoosek(1:5, idxA);
    for idxB = 1:nchoosek(5, idxA)
        tt = tt + 1;
        CCC(tt, 1) = {temp(idxB, :)};
    end
end

% Make model for each combination
for idxA = 1:length(CCC)
    temp = cell2mat(CCC(idxA));
    for idxB = 1:length(temp)
        pred = score(:, temp);
        %mdl = fitglm(pred, PCA_index > 0, 'Distribution', 'binomial', 'Link', 'logit');
        mdl = fitglm(pred, PCA_index > 0, 'Distribution', 'binomial', 'Link', 'logit', 'LikelihoodPenalty', 'jeffreys-prior');
        lscore = mdl.Fitted.Probability;
        [X, Y, T, AUC] = perfcurve((PCA_index > 0), lscore, 'true');
        e = mdl.Coefficients.SE(2:end);
        AIC = mdl.ModelCriterion.AICc;
        AUClist(idxA, 1) = AUC;
        AIClist(idxA, 1) = AIC;
    end
end

% Indexing for best model
mind = find(AUClist == max(AUClist));
mind = mind(end);

pred = score(:, cell2mat(CCC(mind)));
%mdl = fitglm(pred, PCA_index > 0, 'Distribution', 'binomial', 'Link', 'logit');
mdl = fitglm(pred, PCA_index > 0, 'Distribution', 'binomial', 'Link', 'logit', 'LikelihoodPenalty', 'jeffreys-prior');
lscore = mdl.Fitted.Probability;
[X, Y, T, AUC] = perfcurve((PCA_index > 0), lscore, 'true');
e = mdl.Coefficients.Estimate(2:end);
AIC = mdl.ModelCriterion.AICc;

% Plot and save ROC curve to file if doSave is true
if doSave == true
    figROC = figure;
    plot(X, Y);
    title(expTitle, "Interpreter", "none");
    aucText = sprintf('%s\nAUC = %.4f', expTitle, AUC);
    text(0.5, 0.5, aucText, 'FontSize', 16, 'HorizontalAlignment', 'center');
    pbaspect([1, 1, 1]);

    saveas(figROC, strcat(saveDir, Y_name, '_vs_', X_name, '_ROCcurve'), 'svg');
    saveas(figROC, strcat(saveDir, Y_name, '_vs_', X_name, '_ROCcurve'), 'png');
end

num_e = length(e);

if num_e >= 4
    GIS_Y = PCA_eigen(:,1)*e(1) + PCA_eigen(:,2)*e(2)  + PCA_eigen(:,3)*e(3) + PCA_eigen(:,4)*e(4);
elseif num_e == 3
    GIS_Y = PCA_eigen(:,1)*e(1) + PCA_eigen(:,2)*e(2)  + PCA_eigen(:,3)*e(3);
elseif num_e == 2
    GIS_Y = PCA_eigen(:,1)*e(1) + PCA_eigen(:,2)*e(2);
elseif num_e == 1
    GIS_Y = PCA_eigen(:,1)*e(1);
else
    disp('e has no elements');
end

% Display the combination of principal components used for the best model
best_combination = cell2mat(CCC(mind));
disp(['Best combination of principal components: PC' num2str(best_combination)]);

GIS_Yz = zscore(GIS_Y);

end