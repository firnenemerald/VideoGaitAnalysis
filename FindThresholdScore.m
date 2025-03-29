%% Function to find the threshold score for two datasets

% SPDX-FileCopyrightText: © 2025 Chanhee Jeong <chanheejeong@snu.ac.kr> Pil-ung Lee <vlfdnd221@naver.com>, Jung Hwan Shin <neo2003@snu.ac.kr>
% SPDX-License-Identifier: GPL-3.0-or-later

function [threshold] = FindThresholdScore(score1, score2)

    % Plot scatter plots for both scores
    figure;
    scatter(ones(size(score1)), score1, 'b', 'jitter', 'on', 'jitterAmount', 0.1);
    hold on;
    scatter(2*ones(size(score2)), score2, 'r', 'jitter', 'on', 'jitterAmount', 0.1);
    
    % Add bar and error bar
    mean_score1 = mean(score1);
    mean_score2 = mean(score2);
    std_score1 = std(score1);
    std_score2 = std(score2);
    
    bar(1, mean_score1, 'FaceColor', 'b', 'FaceAlpha', 0.5);
    bar(2, mean_score2, 'FaceColor', 'r', 'FaceAlpha', 0.5);
    
    errorbar(1, mean_score1, std_score1, 'k', 'LineWidth', 2);
    errorbar(2, mean_score2, std_score2, 'k', 'LineWidth', 2);
    
    % Customize plot
    xlim([0 3]);
    xticks([1 2]);
    xticklabels({'Score 1', 'Score 2'});
    ylabel('Score');
    title('Scatter Plot with Bar and Error Bar');
    legend('Score 1', 'Score 2', 'Location', 'best');
    hold off;

    % % Plot histograms for both scores
    % figure;
    % histogram(score1, 'Normalization', 'probability', 'FaceColor', 'b', 'FaceAlpha', 0.5);
    % hold on;
    % histogram(score2, 'Normalization', 'probability', 'FaceColor', 'r', 'FaceAlpha', 0.5);
    % xlabel('Score');
    % ylabel('Probability');
    % title('Score Distributions');
    % legend('Score 1', 'Score 2');
    % hold off;

    % Define a range of threshold values
    min_score = min([score1; score2]);
    max_score = max([score1; score2]);
    thresholds = linspace(min_score, max_score, 100);

    % Calculate TPR and FPR for each threshold
    tpr = zeros(size(thresholds));
    fpr = zeros(size(thresholds));

    for i = 1:length(thresholds)
        t = thresholds(i);
        
        % True Positive: score1 > t (assuming score1 is positive class)
        tpr(i) = sum(score1 > t) / length(score1);
        
        % False Positive: score2 > t (assuming score2 is negative class)
        fpr(i) = sum(score2 > t) / length(score2);
    end

    % Plot ROC curve
    figure;
    plot(fpr, tpr, 'LineWidth', 2);
    hold on;
    plot([0, 1], [0, 1], 'r--');
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title('ROC Curve');
    hold off;

    % Calculate area under the ROC curve
    auc = abs(trapz(fpr, tpr));
    fprintf('AUC: %.4f\n', auc);

    % Find optimal threshold (Youden's J statistic: max(TPR - FPR))
    youden = tpr - fpr;
    [max_youden, max_idx] = max(youden);
    threshold = thresholds(max_idx);

    % Mark optimal threshold on ROC curve
    figure;
    plot(fpr, tpr, 'LineWidth', 2);
    hold on;
    plot([0, 1], [0, 1], 'r--');
    plot(fpr(max_idx), tpr(max_idx), 'ro', 'MarkerSize', 10);
    text(fpr(max_idx)+0.05, tpr(max_idx), sprintf('Threshold = %.2f', threshold));
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    title(sprintf('ROC Curve (AUC = %.4f)', auc));
    legend('ROC', 'Random Classifier', 'Optimal Threshold', 'Location', 'southeast');
    hold off;

    fprintf('Optimal threshold: %.4f\n', threshold);
    fprintf('At this threshold: TPR = %.4f, FPR = %.4f\n', tpr(max_idx), fpr(max_idx));    

end