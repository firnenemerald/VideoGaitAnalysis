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

## Old UPDRS Score Mapping
(Column Name) ~ (Full item name) ~ (Raw data item name)
### Part I: Mentation, Behavior, and Mood
- u1-1 ~ Intellectual impairment ~ Mentation [1]
- u1-2 ~ Thought disorder ~ ThoughtDisorder [2]
- u1-3 ~ Depression ~ Depression [3]
- u1-4 ~ Motivation/Initiative ~ MotivationInitiative [4]
### Part II: Activities of Daily Living
- u2-1 ~ Speech ~ Speech [5]
- u2-2 ~ Salivation ~ Salivation [6]
- u2-3 ~ Swallowing ~ Swallowing [7]
- u2-4 ~ Handwriting ~ Handwriting [8]
- u2-5 ~ Cutting food and handling utensils ~ CuttingFood [9]
- u2-6 ~ Dressing ~ Dressing [10]
- u2-7 ~ Hygiene ~ Hygiene [11]
- u2-8 ~ Turning in bed and adjusting bed clothes ~ TurningInBed [12]
- u2-9 ~ Falling ~ Falling [13]
- u2-10 ~ Freezing when walking ~ Freezing [14]
- u2-11 ~ Walking ~ Walking [15]
- u2-12 ~ Tremor ~ Tremor [16]
- u2-13 ~ Sensory complaints related to parkinsonism ~ SensorySymptoms [17]
### Part III: Motor Examination
- u3-1 ~ Speech ~ Speech [18]
- u3-2 ~ Facial Expression ~ FacialExpression [25]
- u3-3 ~ Tremor at rest ~ LimbAxialRestingTremor [26]
- u3-4 ~ Action or postural tremor of hands ~ LimbActionTremor [27]
- u3-5 ~ Rigidity ~ NeckRigidity [19] + LimbRigidity [28]
- u3-6 ~ Finger taps, Hand movements, Rapid alternating movements of hands, Leg agility ~ LimbAKNS [29]
- u3-7 ~ Arising from chair ~ AriseFromChair [20]
- u3-8 ~ Posture ~ Posture [21]
- u3-9 ~ Gait ~ Gait [22]
- u3-10 ~ Postural stability ~ PosturalInstability [23]
- u3-11 ~ Body bradykinesia and hypokinesia ~ BodyBradykinesia [24]

## To-do
- Addendum PD LEDD value (chart review)