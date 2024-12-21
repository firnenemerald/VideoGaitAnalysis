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

## MDS-UPDRS Score Mapping
(Column Name) ~ (Full item name) ~ (Raw data item name)
### Part I: Non-Motor Aspects of Experiences of Daily Living (nM-EDL)
- u1-1 ~ Cognitive impairment ~ Cognition [1]
- u1-2 ~ Hallucinations and psychosis ~ Psychosis [2]
- u1-3 ~ Depressed mood ~ Depression [3]
- u1-4 ~ Anxious mood ~ Anxious [4]
- u1-5 ~ Apathy ~ Apathy [5]
- u1-6 ~ Features of dopamine dysregulation syndrome ~ DDS [6]
- u1-7 ~ Sleep problems ~ Sleep [7]
- u1-8 ~ Daytime sleepiness ~ DaytimeSleepy [8]
- u1-9 ~ Pain and other sensations ~ Pain [9]
- u1-10 ~ Urinary problems ~ Urinary [10]
- u1-11 ~ Constipation problems ~ Constipation [11]
- u1-12 ~ Light headedness on standing ~ OrthoDz [12]
- u1-13 ~ Fatigue ~ Fatigue [13]
### Part II: Motor Aspects of Experiences of Daily Living (M-EDL)
- u2-1 ~ Speech ~ Speech [14]
- u2-2 ~ Saliva and drooling ~ Drooling [15]
- u2-3 ~ Chewing and swallowing ~ ChewSwallow [16]
- u2-4 ~ Eating tasks ~ EatingTask [17]
- u2-5 ~ Dressing ~ Dressing [18]
- u2-6 ~ Hygiene ~ Hygiene [19]
- u2-7 ~ Handwriting ~ Handwriting [20]
- u2-8 ~ Doing hobbies and other activities ~ HobbiesActivities [21]
- u2-9 ~ Turning in bed ~ TurningInBed [22]
- u2-10 ~ Tremor ~ Tremor [23]
- u2-11 ~ Getting out of bed, car, deep chair ~ GetOutOfBed [24]
- u2-12 ~ Walking and balance ~ WalkingBalance [25]
- u2-13 ~ Freezing ~ Freezing [26]
### Part III: Motor Examination
- u3-1 ~ Speech ~ Speech [27]
- u3-2 ~ Facial expression ~ Face [28]
- u3-3 ~ Rigidity ~ Rgd_Neck [29] + Rgd_RUE [30] + Rgd_LUE [31] + Rgd_RLE [32] + Rgd_LLE [33]
- u3-4 ~ Finger tapping ~ fTap_Rt [34] + fTap_Lt [35]
- u3-5 ~ Hand movements ~ Jam_Rt [36] + Jam_Lt [37]
- u3-6 ~ Pronation-supination movements of hands ~ RAM_Rt [38] + RAM_Lt [39]
- u3-7 ~ Toe tapping ~ tTap_Rt [40] + tTap_Lt [41]
- u3-8 ~ Leg agility ~ Agil_Rt [42] + Agil_Lt [43]
- u3-9 ~ Arising from chair ~ Arising [44]
- u3-10 ~ Gait ~ Gait [45]
- u3-11 ~ Freezing of gait ~ FOG [46]
- u3-12 ~ Postural instability ~ PI [47]
- u3-13 ~ Posture ~ Posture [48]
- u3-14 ~ Body bradykinesia (Global spontaneity of movement) ~ Bradykinesia [49]
- u3-15 ~ Postural tremor of the hands ~ pTremor_Rt [50] + pTremor_Lt [51]
- u3-16 ~ Kinetic tremor of the hands ~ kTremor_Rt [52] + kTremor_Lt [53]
- u3-17 ~ Resting tremor amplitude ~ rTamp_RUE [54] + rTamp_LUE [55] + rTamp_RLE [56] + rTamp_LLE [57] + rTamp_LJ [58]
- u3-18 ~ Resting tremor constancy ~ rTcon [59]

## Data Description
### Healthy Controls (n=30)
- Patient Information: PID, Name, Age, Sex (M=1, F=2), Height
- Gait Parameters (total 24)
```
Step length (mean), Step length (cv), Step time (mean), Step time (cv), Step width (mean), Step width (cv),  
Cadence, Velocity, Step length asymmetry, Arm swing asymmetry, Turning time (mean), Turning time (cv),  
Turning step length (mean), Turning step length (cv), Turning step time (mean), Turning step time (cv),  
Turning step width (mean), Turning step width (cv), Turning step number (mean), Turning step number (cv),  
Turning cadence, Turning velocity, Anterior flexion angle, Dropped head angle
```
- UPDRS score: updrs p1, updrs p2, updrs p3
- Duration: Duration
### ePD Patients (n=35)
- Patient Information: PID, Name, Age, Sex (M=1, F=2), Height `[1-5]`
- Gait Parameters (total 24 parameters) `[6-29]`
```
Step length (mean), Step length (cv), Step time (mean), Step time (cv), Step width (mean), Step width (cv),  
Cadence, Velocity, Step length asymmetry, Arm swing asymmetry, Turning time (mean), Turning time (cv),  
Turning step length (mean), Turning step length (cv), Turning step time (mean), Turning step time (cv),  
Turning step width (mean), Turning step width (cv), Turning step number (mean), Turning step number (cv),  
Turning cadence, Turning velocity, Anterior flexion angle, Dropped head angle
```
- UPDRS score: updrs p1, updrs p2, updrs p3 `[30-32]`
- Duration `[33]`
- UPDRS subscores: u1-1~13, u2-1~13, u3-1~18, HY `[34-46, 47-59, 60-77]`
- CIT PET data (total 69 ROIs) `[78-96, 97-115, 116-134, 135-146]`
```
Sd(b), C(b), Cda(b), Cva(b), Ct(b), Cb(b), P(b), Pda(b), Pva(b), Pdp(b), Pvp(b), GP(b), GPa(b), GPp(b), Sv(b), DRN(b), LC(b), SN(b), STN(b),  
Sd(l), C(l), Cda(l), Cva(l), Ct(l), Cb(l), P(l), Pda(l), Pva(l), Pdp(l), Pvp(l), GP(l), GPa(l), GPp(l), Sv(l), DRN(l), LC(l), SN(l), STN(l),  
Sd(r), C(r), Cda(r), Cva(r), Ct(r), Cb(r), P(r), Pda(r), Pva(r), Pdp(r), Pvp(r), GP(r), GPa(r), GPp(r), Sv(r), DRN(r), LC(r), SN(r), STN(r),  
S_asym, C_asym, P_asym, PC_rat(b), CP_rat(b), apP_rat(b), PC_rat(l), CP_rat(l), apP_rat(l), PC_rat(r), CP_rat(r), apP_rat(r)
```
### aPD Patients, OFF (n=57)
- Patient Information: PID, Name, Age, Sex (M=1, F=2), Height `[1-5]`
- Gait Parameters (total 24 parameters) `[6-29]`
```
Step length (mean), Step length (cv), Step time (mean), Step time (cv), Step width (mean), Step width (cv),  
Cadence, Velocity, Step length asymmetry, Arm swing asymmetry, Turning time (mean), Turning time (cv),  
Turning step length (mean), Turning step length (cv), Turning step time (mean), Turning step time (cv),  
Turning step width (mean), Turning step width (cv), Turning step number (mean), Turning step number (cv),  
Turning cadence, Turning velocity, Anterior flexion angle, Dropped head angle
```
- UPDRS score: updrs p1, updrs p2, updrs p3 `[30-32]`
- Duration `[33]`
- LEDD `[34]`
- UPDRS subscores: u1-1~4, u2-1~13, u3-1~11, HY `[35-38, 39-51, 52-62, 63]`
- CIT PET data (total 69 ROIs) `[64-82, 83-101, 102-120, 121-132]`
```
Sd(b), C(b), Cda(b), Cva(b), Ct(b), Cb(b), P(b), Pda(b), Pva(b), Pdp(b), Pvp(b), GP(b), GPa(b), GPp(b), Sv(b), DRN(b), LC(b), SN(b), STN(b),  
Sd(l), C(l), Cda(l), Cva(l), Ct(l), Cb(l), P(l), Pda(l), Pva(l), Pdp(l), Pvp(l), GP(l), GPa(l), GPp(l), Sv(l), DRN(l), LC(l), SN(l), STN(l),  
Sd(r), C(r), Cda(r), Cva(r), Ct(r), Cb(r), P(r), Pda(r), Pva(r), Pdp(r), Pvp(r), GP(r), GPa(r), GPp(r), Sv(r), DRN(r), LC(r), SN(r), STN(r),  
S_asym, C_asym, P_asym, PC_rat(b), CP_rat(b), apP_rat(b), PC_rat(l), CP_rat(l), apP_rat(l), PC_rat(r), CP_rat(r), apP_rat(r)
```
### aPD Patients, ON (n=57)
- Patient Information: PID, Name, Age, Sex (M=1, F=2), Height `[1-5]`
- Gait Parameters (total 24 parameters) `[6-29]`
```
Step length (mean), Step length (cv), Step time (mean), Step time (cv), Step width (mean), Step width (cv),  
Cadence, Velocity, Step length asymmetry, Arm swing asymmetry, Turning time (mean), Turning time (cv),  
Turning step length (mean), Turning step length (cv), Turning step time (mean), Turning step time (cv),  
Turning step width (mean), Turning step width (cv), Turning step number (mean), Turning step number (cv),  
Turning cadence, Turning velocity, Anterior flexion angle, Dropped head angle
```
- UPDRS score: updrs p1, updrs p2, updrs p3 `[30-32]`
- Duration `[33]`
- UPDRS subscores: u1-1~4, u2-1~13, u3-1~11, HY `[34-37, 38-50, 51-61, 62]`

## To-do
- Addendum PD LEDD value (chart review)
- aPD ON UPDRS recheck