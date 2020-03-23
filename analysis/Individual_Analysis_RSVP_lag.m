function [rsvp]    = Individual_Analysis_RSVP_lag(ID)

%ID                              =  90255;
%fig             = 1;

%% =================== Load the data                    ===================
resp_folder     = '../results';

resp_rsvp       = [num2str(ID),'_rsvp.mat'];

resp_file_rsvp  = fullfile(resp_folder,resp_rsvp);

load(resp_file_rsvp,'data_rsvp');

if ID == 35923 || ID == 85841
    data_rsvp(1) = [];
    data_rsvp(13)= [];
end

if ~isfile(resp_file_rsvp)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% =================== Initialise                       ===================

cfg_training                    = data_rsvp(1).cfg;
nTrain                          = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp                         = data_rsvp(nTrain+1).cfg;
%(0 = training, 1 = Small reward, 2 = Large reward)
reward                          = [data_rsvp(nTrain+1:end).reward];
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition                       = [data_rsvp(nTrain+1:end).condition];
block                           = [data_rsvp(nTrain+1:end).block];
trial                           = [data_rsvp(nTrain+1:end).trial];
rt                              = [data_rsvp(nTrain+1:end).RTs];
% (1 = femquest, 2 = homquest)
instQuest                       = [data_rsvp(nTrain+1:end).instQuest];
% (1 = [o] / oui; 2 = [n] / non)
response                        = [data_rsvp(nTrain+1:end).response];
posCritDist                     = [data_rsvp(nTrain+1:end).posCritDist];
posTarget                       = [data_rsvp(nTrain+1:end).posTarget];
% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale)
distractor                      = [data_rsvp(nTrain+1:end).distractor];
target                          = [data_rsvp(nTrain+1:end).target];

%% =================== Basic Information                ===================

nTrial                          = 1:length(trial); % allows the indexing

disp(['There were ',num2str(length(trial)), ' trials']);

%% =================== Exclude 3 STD RTs                ===================

rt                              = (rt(nTrial));
mean_RtExp                      = mean(rt) ;
std_RtExp                       = std(rt)*3 ;

% Recalculate nTrial with only non-outlier RT trials
low_RtExp                       = mean_RtExp-std_RtExp ;
up_RtExp                        = mean_RtExp+std_RtExp ;

kept_RtExp                      = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp));
excl_RtExp                      = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

rsvp.nExcTrial                  = length(excl_RtExp);

if ID == 81477
    kept_RtExp(31) = [];
end

nTrial                          = nTrial(kept_RtExp);
rsvp.rt                         = log(rt(nTrial));
rt                              = log(rt(nTrial));
block                           = block(nTrial);

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Lags               ===================

lag                             = posTarget-posCritDist;

lag2                            = lag(nTrial) == 2;
rsvp.nlag2                      = sum(lag2);

lag4                            = lag(nTrial) == 4;
rsvp.nlag4                      = sum(lag4);

disp(['Lag distribution : ',num2str(rsvp.nlag2), ' lag 2 trials & ', ...
    num2str(rsvp.nlag4), ' lag 4 trials' ]);

%% =================== Performance - Correct Lag 2      ===================

% Correctly detect fem when fem was target
correct_Fem_lag2                = lag2 & (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));

correct_Hom_lag2                = lag2 & (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));

correct_NotFem_lag2             = lag2 & (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));

correct_NotHom_lag2             = lag2 & (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));

% Sum of all the correct trials
correct_lag2                    = (correct_Fem_lag2 ) + (correct_Hom_lag2 ) + (correct_NotFem_lag2 ) + (correct_NotHom_lag2 );
nCorrect_lag2                   = sum(correct_lag2);

% SDT: correct hit
hit_lag2                        = (correct_Fem_lag2 ) + (correct_Hom_lag2 );
rsvp.hit_rate_lag2              = (sum(hit_lag2 )/(rsvp.nlag2))*100;

% SDT: correct rejection
reject_lag2                     = (correct_NotFem_lag2 ) + (correct_NotHom_lag2 );
rsvp.reject_rate_lag2           = (sum(reject_lag2 )/(rsvp.nlag2))*100;

% General performance
rsvp.performance_lag2           = nCorrect_lag2 /(rsvp.nlag2)*100;

disp(['Performance lag 2 : ',num2str(round(rsvp.performance_lag2)), ...
    '% correct trials with ',num2str(round(rsvp.hit_rate_lag2)), '% hits & ', ...
    num2str(round(rsvp.reject_rate_lag2)), '% rejections' ]);

%% =================== Performance - Correct Lag 4      ===================

% Correctly detect fem when fem was target
correct_Fem_lag4                = lag4 & (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));

correct_Hom_lag4                = lag4 & (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));

correct_NotFem_lag4             = lag4 & (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));

correct_NotHom_lag4             = lag4 & (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));

% Sum of all the correct trials
correct_lag4                    = (correct_Fem_lag4 ) + (correct_Hom_lag4 ) + (correct_NotFem_lag4 ) + (correct_NotHom_lag4 );
nCorrect_lag4                   = sum(correct_lag4);

% SDT: correct hit
hit_lag4                        = (correct_Fem_lag4 ) + (correct_Hom_lag4 );
rsvp.hit_rate_lag4              = (sum(hit_lag4 )/(rsvp.nlag4))*100;

% SDT: correct rejection
reject_lag4                     = (correct_NotFem_lag4 ) + (correct_NotHom_lag4 );
rsvp.reject_rate_lag4           = (sum(reject_lag4 )/(rsvp.nlag4))*100;

% General performance
rsvp.performance_lag4           = nCorrect_lag4 /(rsvp.nlag4)*100;

disp(['Performance lag 4 : ',num2str(round(rsvp.performance_lag4)), ...
    '% correct trials with ',num2str(round(rsvp.hit_rate_lag4)), '% hits & ', ...
    num2str(round(rsvp.reject_rate_lag4)), '% rejections' ]);

%% =================== Performance - Incorrect Lag 2    ===================

% Incorrectly not detect fem when fem was target ( false alarm: says present when not present)
incorrect_Fem_lag2              = lag2 & (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                             % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));

incorrect_Hom_lag2              = lag2 & (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                             % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));

incorrect_NotFem_lag2           = lag2 & (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));

incorrect_NotHom_lag2           = lag2 & (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));

% Sum of all the incorrect trials
incorrect_lag2                  = (incorrect_Fem_lag2) + (incorrect_Hom_lag2) + (incorrect_NotFem_lag2) + (incorrect_NotHom_lag2);
nIncorrect_lag2                 = sum(incorrect_lag2);

% SDT: false alarms
falseAlarm_lag2                 = (incorrect_Fem_lag2) + (incorrect_Hom_lag2);
rsvp.falseAlarm_rate_lag2       = (sum(falseAlarm_lag2)/rsvp.nlag2)*100;

% SDT: misses
miss_lag2                       = (incorrect_NotFem_lag2) + (incorrect_NotHom_lag2);
rsvp.miss_rate_lag2             = (sum(miss_lag2)/rsvp.nlag2)*100;

% General performance
rsvp.perf_incorrect_lag2        = (nIncorrect_lag2/rsvp.nlag2)*100;

disp(['Performance lag 2: ',num2str(round(rsvp.perf_incorrect_lag2)), ...
    '% incorrect trials with ',num2str(round(rsvp.falseAlarm_rate_lag2)), '% false alarms & ', ...
    num2str(round(rsvp.miss_rate_lag2)), '% misses' ]);

%% =================== Performance - Incorrect Lag 4    ===================

% Incorrectly not detect fem when fem was target ( false alarm: says present when not present)
incorrect_Fem_lag4              = lag4 & (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                             % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));

incorrect_Hom_lag4              = lag4 & (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                             % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));

incorrect_NotFem_lag4           = lag4 & (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));

incorrect_NotHom_lag4           = lag4 & (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));

% Sum of all the incorrect trials
incorrect_lag4                  = (incorrect_Fem_lag4) + (incorrect_Hom_lag4) + (incorrect_NotFem_lag4) + (incorrect_NotHom_lag4);
nIncorrect_lag4                 = sum(incorrect_lag4);

% SDT: false alarms
falseAlarm_lag4                 = (incorrect_Fem_lag4) + (incorrect_Hom_lag4);
rsvp.falseAlarm_rate_lag4       = (sum(falseAlarm_lag4)/rsvp.nlag4)*100;

% SDT: misses
miss_lag4                       = (incorrect_NotFem_lag4) + (incorrect_NotHom_lag4);
rsvp.miss_rate_lag4             = (sum(miss_lag4)/rsvp.nlag4)*100;

% General performance
rsvp.perf_incorrect_lag4        = (nIncorrect_lag4/rsvp.nlag4)*100;

disp(['Performance lag 4: ',num2str(round(rsvp.perf_incorrect_lag4)), ...
    '% incorrect trials with ',num2str(round(rsvp.falseAlarm_rate_lag4)), '% false alarms & ', ...
    num2str(round(rsvp.miss_rate_lag4)), '% misses' ]);

%% =================== Performance - Rewards            ===================

smallRwd                        = (reward(nTrial) == 1);
rsvp.smallRwdBlock              = unique(block(smallRwd == 1));

largeRwd                        = (reward(nTrial) == 2);
rsvp.largeRwdBlock              = unique(block(largeRwd == 1));

smallRwd_lag2                   = lag2 & (reward(nTrial) == 1);
smallRwd_correct_lag2           = correct_lag2(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1;
smallRwd_incorrect_lag2         = incorrect_lag2(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1;
rsvp.smallRwd_rate_lag2         = sum(smallRwd_correct_lag2)/sum(smallRwd_lag2)*100;

largeRwd_lag2                   = lag2 & (reward(nTrial) == 2);
largeRwd_correct_lag2           = correct_lag2(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1;
largeRwd_incorrect_lag2         = incorrect_lag2(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1;
rsvp.largeRwd_rate_lag2         = sum(largeRwd_correct_lag2)/sum(largeRwd_lag2)*100;

disp(['Reward lag 2 : ',num2str(round(rsvp.smallRwd_rate_lag2)), '% were correct for small rwd & ', ...
    num2str(round(rsvp.largeRwd_rate_lag2)), '% were correct for large rwd' ]);

smallRwd_lag4                   = lag4 & (reward(nTrial) == 1);
smallRwd_correct_lag4           = correct_lag4(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1;
smallRwd_incorrect_lag4         = incorrect_lag4(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1;
rsvp.smallRwd_rate_lag4         = sum(smallRwd_correct_lag4)/sum(smallRwd_lag4)*100;

largeRwd_lag4                   = lag4 & (reward(nTrial) == 2);
largeRwd_correct_lag4           = correct_lag4(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1;
largeRwd_incorrect_lag4         = incorrect_lag4(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1;
rsvp.largeRwd_rate_lag4         = sum(largeRwd_correct_lag4)/sum(largeRwd_lag4)*100;

disp(['Reward lag 4 : ',num2str(round(rsvp.smallRwd_rate_lag4)), '% were correct for small rwd & ', ...
    num2str(round(rsvp.largeRwd_rate_lag4)), '% were correct for large rwd' ]);

%% =================== Performance - Conditions (Lag2)  ===================

% Detrimental condition
DC_condition_lag2               = lag2 & (condition(nTrial) == 1 | condition(nTrial) == 2);
DC_correct_lag2                 = correct_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1;
DC_incorrect_lag2               = incorrect_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1;
rsvp.DC_block_lag2              = unique(block(DC_condition_lag2));

% SDT: DC
hit_DC_lag2                     =  sum((correct_Fem_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_Hom_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1);
rsvp.hit_rate_DC_lag2           = (hit_DC_lag2 / sum(DC_condition_lag2))*100;

reject_DC_lag2                  = sum((correct_NotFem_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1);
rsvp.reject_rate_DC_lag2        = (reject_DC_lag2 / sum(DC_condition_lag2))*100;

falseAlarm_DC_lag2              = sum((incorrect_Fem_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_DC_lag2    = (falseAlarm_DC_lag2 / sum(DC_condition_lag2))*100;

miss_DC_lag2                    = sum((incorrect_NotFem_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag2(1:length(nTrial)) == 1 & DC_condition_lag2(1:length(nTrial)) == 1);
rsvp.miss_rate_DC_lag2          = (miss_DC_lag2/ sum(DC_condition_lag2))*100;

% Control Condition
CC_condition_lag2            = lag2 & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_correct_lag2              = correct_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1;
CC_incorrect_lag2            = incorrect_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1;

% SDT: CC
hit_CC_lag2                  =  sum((correct_Fem_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_Hom_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1);
rsvp.hit_rate_CC_lag2        = (hit_CC_lag2 / sum(CC_condition_lag2))*100;

reject_CC_lag2               = sum((correct_NotFem_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1);
rsvp.reject_rate_CC_lag2     = (reject_CC_lag2 / sum(CC_condition_lag2))*100;

falseAlarm_CC_lag2           = sum((incorrect_Fem_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_CC_lag2 = (falseAlarm_CC_lag2 / sum(CC_condition_lag2))*100;

miss_CC_lag2                 = sum((incorrect_NotFem_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag2(1:length(nTrial)) == 1 & CC_condition_lag2(1:length(nTrial)) == 1);
rsvp.miss_rate_CC_lag2       = (miss_CC_lag2/ sum(CC_condition_lag2))*100;

% Beneficial Conditions
BC_condition_lag2            = lag2 & (condition(nTrial) == 5 | condition(nTrial) == 6);
BC_correct_lag2              = (correct_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
BC_incorrect_lag2            = (incorrect_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
rsvp.BC_block_lag2           = unique(block(BC_condition_lag2));

% SDT: BC
hit_BC_lag2                  =  sum((correct_Fem_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_Hom_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
rsvp.hit_rate_BC_lag2        = (hit_BC_lag2 / sum(BC_condition_lag2))*100;

reject_BC_lag2               = sum((correct_NotFem_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
rsvp.reject_rate_BC_lag2     = (reject_BC_lag2 / sum(BC_condition_lag2))*100;

falseAlarm_BC_lag2           = sum((incorrect_Fem_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_BC_lag2 = (falseAlarm_BC_lag2 / sum(BC_condition_lag2))*100;

miss_BC_lag2                 = sum((incorrect_NotFem_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag2(1:length(nTrial)) == 1 & BC_condition_lag2(1:length(nTrial)) == 1);
rsvp.miss_rate_BC_lag2       = (miss_BC_lag2/ sum(BC_condition_lag2))*100;

% Condition Emotions
rsvp.perf_DC_lag2            = (sum(DC_correct_lag2))/sum(DC_condition_lag2)*100;
rsvp.perf_CC_lag2            = (sum(CC_correct_lag2))/sum(CC_condition_lag2)*100;
rsvp.perf_BC_lag2            = (sum(BC_correct_lag2))/sum(BC_condition_lag2)*100;

disp(['Performance Emotion Lag 2 : ',num2str(round(rsvp.perf_DC_lag2)), '% for DC, ', ...
    num2str(round(rsvp.perf_CC_lag2)), '% for CC & ',num2str(round(rsvp.perf_BC_lag2)), '% for BC']);

%% =================== Performance - Conditions (Lag 4) ===================

% Detrimental condition
DC_condition_lag4               = lag4 & (condition(nTrial) == 1 | condition(nTrial) == 2);
DC_correct_lag4                 = correct_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1;
DC_incorrect_lag4               = incorrect_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1;
rsvp.DC_block_lag4              = unique(block(DC_condition_lag4));

% SDT: DC
hit_DC_lag4                     =  sum((correct_Fem_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_Hom_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1);
rsvp.hit_rate_DC_lag4           = (hit_DC_lag4 / sum(DC_condition_lag4))*100;

reject_DC_lag4                  = sum((correct_NotFem_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1);
rsvp.reject_rate_DC_lag4        = (reject_DC_lag4 / sum(DC_condition_lag4))*100;

falseAlarm_DC_lag4              = sum((incorrect_Fem_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_DC_lag4    = (falseAlarm_DC_lag4 / sum(DC_condition_lag4))*100;

miss_DC_lag4                    = sum((incorrect_NotFem_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag4(1:length(nTrial)) == 1 & DC_condition_lag4(1:length(nTrial)) == 1);
rsvp.miss_rate_DC_lag4          = (miss_DC_lag4/ sum(DC_condition_lag4))*100;

% Control Condition
CC_condition_lag4            = lag4 & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_correct_lag4              = correct_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1;
CC_incorrect_lag4            = incorrect_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1;

% SDT: CC
hit_CC_lag4                  =  sum((correct_Fem_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_Hom_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1);
rsvp.hit_rate_CC_lag4        = (hit_CC_lag4 / sum(CC_condition_lag4))*100;

reject_CC_lag4               = sum((correct_NotFem_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1);
rsvp.reject_rate_CC_lag4     = (reject_CC_lag4 / sum(CC_condition_lag4))*100;

falseAlarm_CC_lag4           = sum((incorrect_Fem_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_CC_lag4 = (falseAlarm_CC_lag4 / sum(CC_condition_lag4))*100;

miss_CC_lag4                 = sum((incorrect_NotFem_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag4(1:length(nTrial)) == 1 & CC_condition_lag4(1:length(nTrial)) == 1);
rsvp.miss_rate_CC_lag4       = (miss_CC_lag4/ sum(CC_condition_lag4))*100;

% Beneficial Conditions
BC_condition_lag4            = lag4 & (condition(nTrial) == 5 | condition(nTrial) == 6);
BC_correct_lag4              = (correct_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
BC_incorrect_lag4            = (incorrect_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
rsvp.BC_block_lag4           = unique(block(BC_condition_lag4));

% SDT: BC
hit_BC_lag4                  =  sum((correct_Fem_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_Hom_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
rsvp.hit_rate_BC_lag4        = (hit_BC_lag4 / sum(BC_condition_lag4))*100;

reject_BC_lag4               = sum((correct_NotFem_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1) | ...
    correct_NotHom_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
rsvp.reject_rate_BC_lag4     = (reject_BC_lag4 / sum(BC_condition_lag4))*100;

falseAlarm_BC_lag4           = sum((incorrect_Fem_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_Hom_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
rsvp.falseAlarm_rate_BC_lag4 = (falseAlarm_BC_lag4 / sum(BC_condition_lag4))*100;

miss_BC_lag4                 = sum((incorrect_NotFem_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1) | ...
    incorrect_NotHom_lag4(1:length(nTrial)) == 1 & BC_condition_lag4(1:length(nTrial)) == 1);
rsvp.miss_rate_BC_lag4       = (miss_BC_lag4/ sum(BC_condition_lag4))*100;

rsvp.perf_DC_lag4            = (sum(DC_correct_lag4))/sum(DC_condition_lag4)*100;
rsvp.perf_BC_lag4            = (sum(BC_correct_lag4))/sum(BC_condition_lag4)*100;
rsvp.perf_CC_lag4            = (sum(CC_correct_lag4))/sum(CC_condition_lag4)*100;

disp(['Performance Emotion Lag 4 : ',num2str(round(rsvp.perf_DC_lag4)), '% for DC, ', ...
    num2str(round(rsvp.perf_CC_lag4)), '% for CC & ',num2str(round(rsvp.perf_BC_lag4)), '% for BC']);


%% =================== Performance - Conditions & Rewards =================
% Lag 2
rsvp.perf_DC_smallRwd_lag2   = sum(DC_correct_lag2(smallRwd == 1)) / sum(DC_condition_lag2(smallRwd == 1)) * 100 ;
rsvp.perf_DC_largeRwd_lag2   = sum(DC_correct_lag2(largeRwd == 1)) / sum(DC_condition_lag2(largeRwd == 1)) * 100 ;

rsvp.perf_CC_smallRwd_lag2   = sum(CC_correct_lag2(smallRwd == 1)) / sum(CC_condition_lag2(smallRwd == 1)) * 100 ;
rsvp.perf_CC_largeRwd_lag2   = sum(CC_correct_lag2(largeRwd == 1)) / sum(CC_condition_lag2(largeRwd == 1)) * 100 ;

rsvp.perf_BC_smallRwd_lag2   = sum(BC_correct_lag2(smallRwd == 1)) / sum(BC_condition_lag2(smallRwd == 1)) * 100;
rsvp.perf_BC_largeRwd_lag2   = sum(BC_correct_lag2(largeRwd == 1)) / sum(BC_condition_lag2(largeRwd == 1)) * 100 ;

% Lag 4
rsvp.perf_DC_smallRwd_lag4   = sum(DC_correct_lag4(smallRwd == 1)) / sum(DC_condition_lag4(smallRwd == 1)) * 100 ;
rsvp.perf_DC_largeRwd_lag4   = sum(DC_correct_lag4(largeRwd == 1)) / sum(DC_condition_lag4(largeRwd == 1)) * 100 ;

rsvp.perf_CC_smallRwd_lag4   = sum(CC_correct_lag4(smallRwd == 1)) / sum(CC_condition_lag4(smallRwd == 1)) * 100 ;
rsvp.perf_CC_largeRwd_lag4   = sum(CC_correct_lag4(largeRwd == 1)) / sum(CC_condition_lag4(largeRwd == 1)) * 100 ;

rsvp.perf_BC_smallRwd_lag4   = sum(BC_correct_lag4(smallRwd == 1)) / sum(BC_condition_lag4(smallRwd == 1)) * 100;
rsvp.perf_BC_largeRwd_lag4   = sum(BC_correct_lag4(largeRwd == 1)) / sum(BC_condition_lag4(largeRwd == 1)) * 100 ;

%% =================== Learning Curves - Lag 2          ===================

rsvp.LC_lag2              = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC_lag2)
    rsvp.LC_lag2(i)       = (sum(correct_lag2(block == i)))/(sum(lag2(block == i)))*100;
end

rsvp.LC_smallRwd_lag2     = zeros(1,length(rsvp.smallRwdBlock));
rsvp.LC_largeRwd_lag2     = zeros(1,length(rsvp.largeRwdBlock));
for i = 1:length(rsvp.smallRwdBlock)
    rsvp.LC_smallRwd_lag2(i) = (sum(correct_lag2(block == rsvp.smallRwdBlock(i))))/...
        (sum(lag2(block == rsvp.smallRwdBlock(i))))*100;
    rsvp.LC_largeRwd_lag2(i) = (sum(correct_lag2(block == rsvp.largeRwdBlock(i))))/...
        (sum(lag2(block == rsvp.largeRwdBlock(i))))*100;
end

rsvp.LC_DC_lag2     = zeros(1,length(rsvp.DC_block_lag2));
rsvp.LC_BC_lag2     = zeros(1,length(rsvp.BC_block_lag2));

for i = 1:length(rsvp.DC_block_lag2)
    rsvp.LC_DC_lag2(i) = (sum(DC_correct_lag2(block == rsvp.DC_block_lag2(i))))/ ...
        sum(DC_condition_lag2(block == rsvp.DC_block_lag2(i)))*100;
    rsvp.LC_BC_lag2(i) = (sum(BC_correct_lag2(block == rsvp.BC_block_lag2(i))))/ ...
        sum(BC_condition_lag2(block == rsvp.BC_block_lag2(i)))*100;
    
end

rsvp.LC_CC_lag2     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC_CC_lag2)
    rsvp.LC_CC_lag2(i) = (sum(CC_correct_lag2(block == i)))/ ...
        sum(CC_condition_lag2(block == i))*100;
end

%% =================== Learning Curves - Lag 2          ===================

rsvp.LC_lag4              = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC_lag4)
    rsvp.LC_lag4(i)       = (sum(correct_lag4(block == i)))/(sum(lag4(block == i)))*100;
end

rsvp.LC_smallRwd_lag4     = zeros(1,length(rsvp.smallRwdBlock));
rsvp.LC_largeRwd_lag4     = zeros(1,length(rsvp.largeRwdBlock));
for i = 1:length(rsvp.smallRwdBlock)
    rsvp.LC_smallRwd_lag4(i) = (sum(correct_lag4(block == rsvp.smallRwdBlock(i))))/...
        (sum(lag4(block == rsvp.smallRwdBlock(i))))*100;
    rsvp.LC_largeRwd_lag4(i) = (sum(correct_lag4(block == rsvp.largeRwdBlock(i))))/...
        (sum(lag4(block == rsvp.largeRwdBlock(i))))*100;
end

rsvp.LC_DC_lag4     = zeros(1,length(rsvp.DC_block_lag4));
rsvp.LC_BC_lag4     = zeros(1,length(rsvp.BC_block_lag4));

for i = 1:length(rsvp.DC_block_lag4)
    rsvp.LC_DC_lag4(i) = (sum(DC_correct_lag4(block == rsvp.DC_block_lag4(i))))/ ...
        sum(DC_condition_lag4(block == rsvp.DC_block_lag4(i)))*100;
    rsvp.LC_BC_lag4(i) = (sum(BC_correct_lag4(block == rsvp.BC_block_lag4(i))))/ ...
        sum(BC_condition_lag4(block == rsvp.BC_block_lag4(i)))*100;
    
end

rsvp.LC_CC_lag4     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC_CC_lag4)
    rsvp.LC_CC_lag4(i) = (sum(CC_correct_lag4(block == i)))/ ...
        sum(CC_condition_lag4(block == i))*100;
end
end 