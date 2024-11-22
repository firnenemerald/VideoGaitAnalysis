# VideoGaitAnalysis
Repository for video gait analysis
MATLAB environment

## Gaitome algorithm
- Extraction of gait parameters
- Saved as .csv files

## Gait analysis
- GaitAnalysis.m
### Get gait parameters
- GaitParams.m
### Multivariate linear regression
- GaitPatternMLR.m
### Principal component analysis
- GaitPatternPCA.m

## Plot
### Visualize gait parameters (heatmap)
- PlotGaitParamHeat.m
### Draw PCA related figures (explained bar graph, AUC curve)
- PlotPCAProcess.m
### Draw gait pattern (z-score bar graph)
- PlotGaitPattern.m
### Plot pre- and post-MLR data (scatter, per variable)
- PlotParameterRegression.m
### Plot gait pattern scores (scatter, multiple group comparison)
- PlotPatternScore.m
### Plot UPDRS correlation (scatter)
- PlotUPDRSCorr.m
- PlotUPDRSIndivCorr.m
### Plot On vs Off states (bar)
- PlotOnOffBar.m
### Plot CIT-PET correlation (linear regression and p-value heatmap)
- PlotCITPETCorr