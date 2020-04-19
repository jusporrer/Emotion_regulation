% Individual analysis script for the effect of motivation on emotion regulation 
% in a RSVP Task
% Author : Juliana Sporrer 
% Creation : February 2020

%function [rsvp]                 = Individual_Analysis_RSVP(ID, fig)

ID                          =  90255;
fig                         = 0;

%% =================== Load the data                    ===================
resp_folder                     = '../results';

resp_rsvp                       = [num2str(ID),'_rsvp.mat'];

resp_file_rsvp                  = fullfile(resp_folder,resp_rsvp);

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

cfg_training                = data_rsvp(1).cfg;
nTrain                      = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp                     = data_rsvp(nTrain+1).cfg;
%(0 = training, 1 = Small reward, 2 = Large reward)
reward                      = [data_rsvp(nTrain+1:end).reward];
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition                   = [data_rsvp(nTrain+1:end).condition];
block                       = [data_rsvp(nTrain+1:end).block];
trial                       = [data_rsvp(nTrain+1:end).trial];
rt                          = [data_rsvp(nTrain+1:end).RTs];
% (1 = femquest, 2 = homquest)
instQuest                   = [data_rsvp(nTrain+1:end).instQuest];
% (1 = [o] / oui; 2 = [n] / non)
response                    = [data_rsvp(nTrain+1:end).response];
posCritDist                 = [data_rsvp(nTrain+1:end).posCritDist];
posTarget                   = [data_rsvp(nTrain+1:end).posTarget];
% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale)
%distractor                  = [data_rsvp(nTrain+1:end).distractor];
target                      = [data_rsvp(nTrain+1:end).target];

%% =================== Basic Information                ===================

nTrial                      = 1:length(trial); % allows the indexing

if length(trial) == cfg_exp.nTrialsExp * cfg_exp.nBlocksExp
    disp(['No data loss : There were ',num2str(length(trial)), ' trials']);
else
    disp(['Problem : There were only ',num2str(length(trial)), ' trials out of the normal ', ...
        num2str(cfg_exp.nTrialsExp * cfg_exp.nBlocksExp), 'trial expected']);
end

%% =================== Exclude 3 STD RTs                ===================

rt                          = (rt(nTrial));
mean_RtExp                  = mean(rt) ;
std_RtExp                   = std(rt)*3 ;

% Recalculate nTrial with only non-outlier RT trials
low_RtExp                   = mean_RtExp-std_RtExp ;
up_RtExp                    = mean_RtExp+std_RtExp ;

kept_RtExp                  = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp));
excl_RtExp                  = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

rsvp.nExcTrial              = length(excl_RtExp); 

if ID == 81477
    kept_RtExp(31) = [];
end 

nTrial                      = nTrial(kept_RtExp);
rsvp.rt                     = log(rt(nTrial)); 
rt                          = log(rt(nTrial)); 
block                       = block(nTrial);

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Correct Trials     ===================

% Correctly detect fem when fem was target
correct_Fem                 = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));
% correct_FearFem             = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % fearful fem targets
%     & target(nTrial) == 1);
% correct_NeutralFem          = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                       % neutral fem targets
%     & target(nTrial) == 3);

% Correctly detect hom when hom was target
correct_Hom                 = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));
% correct_FearHom             = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % fearful hom targets
%     & target(nTrial) == 2);
% correct_NeutralHom          = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                       % neutral hom taregts
%     & target(nTrial) == 4);

% Correctly reject fem when hom was target
correct_NotFem              = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));
% correct_NotFem_FearHom      = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
%     & target(nTrial) == 2);
% correct_NotFem_NeutralHom   = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
%     & target(nTrial) == 4);

% Correctly reject hom when fem was target
correct_NotHom              = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));
% correct_NotHom_FearFem      = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
%     & target(nTrial) == 1);
% correct_NotHom_NeutralFem   = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
%     & target(nTrial) == 3);

% Sum of all the correct trials
correct                     = correct_Fem + correct_Hom + correct_NotFem + correct_NotHom;
nCorrect                    = sum(correct);

% SDT: correct hit
hit                         = correct_Fem + correct_Hom;
rsvp.hit_rate               = sum(hit) / length(nTrial);

% SDT: correct rejection
reject                      = correct_NotFem + correct_NotHom;
rsvp.reject_rate            = sum(reject) / length(nTrial);

% General performance
rsvp.performance            = nCorrect / length(nTrial) * 100;

disp(['Performance : ',num2str(round(rsvp.performance)), ...
    '% correct trials with ',num2str(round(rsvp.hit_rate)), '% hits & ', ...
    num2str(round(rsvp.reject_rate)), '% rejections' ]);

%% =================== Performance - Incorrect Trials   ===================

% Incorrectly not detect fem when fem was target ( false alarm: says present when not present)
incorrect_Fem               = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                             % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));
% incorrect_FearFem           = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                         % fearful fem targets
%     & target(nTrial) == 1);
% incorrect_NeutralFem        = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                      % neutral fem targets
%     & target(nTrial) == 3);

% Incorrectly not detect hom when hom was target
incorrect_Hom               = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                             % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));
% incorrect_FearHom           = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                         % fearful hom targets
%     & target(nTrial) == 2);
% incorrect_NeutralHom        = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                      % neutral hom taregts
%     & target(nTrial) == 4);

% Incorrectly reject hom when hom was target ( miss: says not preset when present)
incorrect_NotFem            = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));
% incorrect_NotFem_FearHom    = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
%     & target(nTrial) == 2);
% incorrect_NotFem_NeutralHom = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
%     & target(nTrial) == 4);

% Incorrectly reject fem when fem was target
incorrect_NotHom            = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));
% incorrect_NotHom_FearFem    = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
%     & target(nTrial) == 1);
% incorrect_NotHom_NeutralFem = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
%     & target(nTrial) == 3);

% Sum of all the incorrect trials
incorrect                   = incorrect_Fem + incorrect_Hom + incorrect_NotFem + incorrect_NotHom;
nIncorrect                  = sum(incorrect);

% SDT: false alarms
falseAlarm                  = incorrect_Fem + incorrect_Hom;
rsvp.falseAlarm_rate        = sum(falseAlarm) / length(nTrial);

% SDT: misses
miss                        = incorrect_NotFem + incorrect_NotHom;
rsvp.miss_rate              = sum(miss) / length(nTrial);

% General performance
rsvp.perf_incorrect         = nIncorrect / length(nTrial)*100;

disp(['Performance : ',num2str(round(rsvp.perf_incorrect)), ...
    '% incorrect trials with ',num2str(round(rsvp.falseAlarm_rate)), '% false alarms & ', ...
    num2str(round(rsvp.miss_rate)), '% misses' ]);

%% =================== Performance - Rewards            ===================

smallRwd                    = reward(nTrial) == 1;
rsvp.smallRwdBlock          = unique(block(smallRwd == 1));
smallRwd_correct            = correct & smallRwd;
smallRwd_incorrect          = incorrect & smallRwd;
rsvp.smallRwd_rate          = sum(smallRwd_correct)/sum(smallRwd)*100;

% SDT: smallRwd 
hit_rate_smallRwd           = (sum(smallRwd & (correct_Fem | correct_Hom)) / sum(smallRwd));
falseAlarm_rate_smallRwd    = (sum(smallRwd & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd));
[rsvp.dprime_smallRwd, rsvp.criterion_smallRwd, rsvp.aprime_smallRwd, rsvp.bprime_smallRwd] = sdt_measures(hit_rate_smallRwd, falseAlarm_rate_smallRwd); 

largeRwd                    = reward(nTrial) == 2;
rsvp.largeRwdBlock          = unique(block(largeRwd == 1));
largeRwd_correct            = correct & largeRwd;
largeRwd_incorrect          = incorrect & largeRwd;
rsvp.largeRwd_rate          = sum(largeRwd_correct)/sum(largeRwd)*100;

% SDT: CC 
hit_rate_largeRwd           = (sum(largeRwd & (correct_Fem | correct_Hom)) / sum(largeRwd));
falseAlarm_rate_largeRwd    = (sum(largeRwd & (incorrect_Fem | incorrect_Hom)) / sum(largeRwd));
[rsvp.dprime_largeRwd, rsvp.criterion_largeRwd, rsvp.aprime_largeRwd, rsvp.bprime_largeRwd] = sdt_measures(hit_rate_largeRwd, falseAlarm_rate_largeRwd); 

disp(['Reward : ',num2str(round(rsvp.smallRwd_rate)), '% were correct for small rwd & ', ...
    num2str(round(rsvp.largeRwd_rate)), '% were correct for large rwd' ]);

%% =================== Performance - Conditions         ===================
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)

% Detrimental condition
DC_condition                = condition(nTrial) == 1 | condition(nTrial) == 2;
DC_correct                  = correct & DC_condition;
DC_incorrect                = incorrect & DC_condition;
rsvp.DC_block               = unique(block(DC_condition));
DC_trials                   = zeros(1,length(nTrial));
for i = 1:length(rsvp.DC_block)
    DC_trials               = DC_trials + (block == rsvp.DC_block(i));
end 

DC_hom                      = condition(nTrial) == 1;
DC_hom_correct              = correct & DC_hom;
DC_hom_incorrect            = incorrect & DC_hom;
rsvp.DC_hom_rate            = sum(DC_hom_correct)/sum(DC_hom)*100;

DC_fem                      = condition(nTrial) == 2;
DC_fem_correct              = correct & DC_fem;
DC_fem_incorrect            = incorrect & DC_fem;
rsvp.DC_fem_rate            = sum(DC_fem_correct)/sum(DC_fem)*100;

% Beneficial Conditions
BC_condition                = condition(nTrial) == 5 | condition(nTrial) == 6;
BC_correct                  = correct & BC_condition;
BC_incorrect                = incorrect & BC_condition;
rsvp.BC_block               = unique(block(BC_condition));
BC_trials                   = zeros(1,length(nTrial));
for i = 1:length(rsvp.BC_block)
    BC_trials               = BC_trials + (block == rsvp.BC_block(i));
end 

BC_hom                      = condition(nTrial) == 5;
BC_hom_correct              = correct & BC_hom;
BC_hom_incorrect            = incorrect & BC_hom;
rsvp.BC_hom_rate            = sum(BC_hom_correct)/sum(BC_hom)*100;

BC_fem                      = condition(nTrial) == 6;
BC_fem_correct              = correct & BC_fem;
BC_fem_incorrect            = incorrect & BC_fem;
rsvp.BC_fem_rate            = sum(BC_fem_correct)/sum(BC_fem)*100;

% Control Conditions
CC_DC_condition             = DC_trials & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_DC_correct               = correct & CC_DC_condition;
% CC_DC_incorrect             = incorrect & CC_DC_condition;

CC_BC_condition             = BC_trials & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_BC_correct               = correct & CC_BC_condition;
% CC_BC_incorrect             = incorrect & CC_BC_condition;

CC_condition                = condition(nTrial) == 3 | condition(nTrial) == 4;
CC_correct                  = correct & CC_condition;
CC_incorrect                = incorrect & CC_condition;

CC_hom                      = condition(nTrial) == 3;
CC_hom_correct              = correct & CC_hom;
CC_hom_incorrect            = incorrect & CC_hom;
rsvp.CC_hom_rate            = sum(CC_hom_correct)/sum(CC_hom)*100;

CC_fem                      = condition(nTrial) == 4;
CC_fem_correct              = correct & CC_fem;
CC_fem_incorrect            = incorrect & CC_fem;
rsvp.CC_fem_rate            = sum(CC_fem_correct)/sum(CC_fem)*100;

% Number of trials in each conditions
if sum(DC_hom) == sum(DC_fem) == sum(CC_hom) == ...
        sum(CC_fem) == sum(BC_hom) ==  sum(BC_fem)
    disp(['All conditions have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), 'trials']);
else
    disp(['Warning, not all condition have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), ' trials']);
end

% Condition Emotions
rsvp.perf_DC                = sum(DC_correct)/sum(DC_condition)*100;  
rsvp.perf_BC                = sum(BC_correct)/sum(BC_condition)*100; 
rsvp.perf_CC_DC             = sum(CC_DC_correct)/sum(CC_DC_condition)*100; 
rsvp.perf_CC_BC             = sum(CC_BC_correct)/sum(CC_BC_condition)*100; 
rsvp.perf_CC                = sum(CC_correct)/sum(CC_condition)*100;

disp(['Performance Emotion : ',num2str(round(rsvp.perf_DC)), '% for detrimental condition, ', ...
    num2str(round(rsvp.perf_CC)), '% for control condition & ',num2str(round(rsvp.perf_BC)), '% for beneficial condition']);

%% =================== Performance - Gender             ===================

fem_condition               = condition(nTrial) == 2 | condition(nTrial) == 4 | condition(nTrial) == 6;
fem_correct                 = correct & fem_condition;
fem_incorrect               = incorrect & fem_condition;

hom_condition               = condition(nTrial) == 1 | condition(nTrial) == 3 | condition(nTrial) == 5;
hom_correct                 = correct & hom_condition;
hom_incorrect               = incorrect & hom_condition;

rsvp.perf_fem               = sum(fem_correct) / sum(fem_condition) * 100; 
rsvp.perf_hom               = sum(hom_correct) / sum(hom_condition) * 100; 

disp(['Performance Gender: ',num2str(round(rsvp.perf_fem)), '% for condition femme & ', ...
    num2str(round(rsvp.perf_hom)), '% for condition homme ']);

%% =================== Performance - Conditions & Rewards =================

rsvp.perf_DC_smallRwd       = sum(DC_correct & smallRwd) / sum(DC_condition & smallRwd) * 100 ;
rsvp.perf_DC_largeRwd       = sum(DC_correct & largeRwd) / sum(DC_condition & largeRwd) * 100 ;

rsvp.perf_CC_DC_smallRwd    = sum(CC_DC_correct & smallRwd) / sum(CC_DC_condition & smallRwd) * 100 ;
rsvp.perf_CC_DC_largeRwd    = sum(CC_DC_correct & largeRwd) / sum(CC_DC_condition & largeRwd) * 100 ;

rsvp.perf_CC_smallRwd       = sum(CC_correct & smallRwd) / sum(CC_condition & smallRwd) * 100 ;
rsvp.perf_CC_largeRwd       = sum(CC_correct & largeRwd) / sum(CC_condition & largeRwd) * 100 ;

rsvp.perf_CC_BC_smallRwd    = sum(CC_BC_correct & smallRwd) / sum(CC_BC_condition & smallRwd) * 100 ;
rsvp.perf_CC_BC_largeRwd    = sum(CC_BC_correct & largeRwd) / sum(CC_BC_condition & largeRwd) * 100 ;

rsvp.perf_BC_smallRwd       = sum(BC_correct & smallRwd) / sum(BC_condition & smallRwd) * 100;
rsvp.perf_BC_largeRwd       = sum(BC_correct & largeRwd) / sum(BC_condition & largeRwd) * 100 ;

%% =================== Performance - Gender & Rewards   ===================

rsvp.perf_fem_smallRwd      = sum(fem_correct & smallRwd) / sum(fem_condition & smallRwd) * 100 ;
rsvp.perf_fem_largeRwd      = sum(fem_correct & largeRwd) / sum(fem_condition & largeRwd) * 100 ;

rsvp.perf_CC_fem_smallRwd   = sum(CC_fem_correct & smallRwd) / sum(CC_fem & smallRwd) * 100 ;
rsvp.perf_CC_fem_largeRwd   = sum(CC_fem_correct & largeRwd) / sum(CC_fem & largeRwd) * 100 ;

rsvp.perf_DC_fem_smallRwd   = sum(DC_fem_correct & smallRwd) / sum(DC_fem & smallRwd) * 100 ;
rsvp.perf_DC_fem_largeRwd   = sum(DC_fem_correct & largeRwd) / sum(DC_fem & largeRwd) * 100 ;

rsvp.perf_BC_fem_smallRwd   = sum(BC_fem_correct & smallRwd) / sum(BC_fem & smallRwd) * 100 ;
rsvp.perf_BC_fem_largeRwd   = sum(BC_fem_correct & largeRwd) / sum(BC_fem & largeRwd) * 100 ;

rsvp.perf_hom_smallRwd      = sum(hom_correct & smallRwd) / sum(hom_condition & smallRwd) * 100;
rsvp.perf_hom_largeRwd      = sum(hom_correct & largeRwd) / sum(hom_condition & largeRwd) * 100;

rsvp.perf_DC_hom_smallRwd   = sum(DC_hom_correct & smallRwd) / sum(DC_hom & smallRwd) * 100 ;
rsvp.perf_DC_hom_largeRwd   = sum(DC_hom_correct & largeRwd) / sum(DC_hom & largeRwd) * 100 ;

rsvp.perf_CC_hom_smallRwd   = sum(CC_hom_correct & smallRwd) / sum(CC_hom & smallRwd) * 100 ;
rsvp.perf_CC_hom_largeRwd   = sum(CC_hom_correct & largeRwd) / sum(CC_hom & largeRwd) * 100 ;

rsvp.perf_BC_hom_smallRwd   = sum(BC_hom_correct & smallRwd) / sum(BC_hom & smallRwd) * 100 ;
rsvp.perf_BC_hom_largeRwd   = sum(BC_hom_correct & largeRwd) / sum(BC_hom & largeRwd) * 100 ;

%% =================== Performance - Lags               ===================

lag                         = posTarget-posCritDist;

lag2                        = lag(nTrial) == 2;
rsvp.nlag2                  = sum(lag2);
correct_lag2                = correct & lag2;
rsvp.lag2_rate              = sum(correct_lag2)/rsvp.nlag2*100;

lag4                        = lag(nTrial) == 4;
rsvp.nlag4                  = sum(lag4);
correct_lag4                = correct & lag4;
rsvp.lag4_rate              = sum(correct_lag4)/rsvp.nlag4*100;

disp(['Performance Lag : ',num2str(round(rsvp.lag2_rate)), '% were correct after a lag 2 & ', ...
    num2str(round(rsvp.lag4_rate)), '% were correct after a lag 4' ]);

%% =================== Signal Detection Theory          ===================

[rsvp.dprime, rsvp.criterion, rsvp.aprime, rsvp.bprime] = sdt_measures(rsvp.hit_rate, rsvp.falseAlarm_rate); 

% SDT: DC
rsvp.hit_rate_DC            = sum(DC_condition & (correct_Fem | correct_Hom)) / sum(DC_condition);
rsvp.reject_rate_DC         = sum(DC_condition & (correct_NotFem | correct_NotHom)) / sum(DC_condition);
rsvp.falseAlarm_rate_DC     = sum(DC_condition & (incorrect_Fem | incorrect_Hom)) / sum(DC_condition);
rsvp.miss_rate_DC           = sum(DC_condition & (incorrect_NotFem | incorrect_NotHom)) / sum(DC_condition);
[rsvp.dprime_DC, rsvp.criterion_DC, rsvp.aprime_DC, rsvp.bprime_DC] = sdt_measures(rsvp.hit_rate_DC, rsvp.falseAlarm_rate_DC); 

hit_rate_DC_smallRwd        = sum(smallRwd & DC_condition & (correct_Fem | correct_Hom)) / sum(smallRwd & DC_condition);
falseAlarm_rate_DC_smallRwd = sum(smallRwd & DC_condition & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd & DC_condition);
[rsvp.dprime_DC_smallRwd, rsvp.criterion_DC_smallRwd, rsvp.aprime_DC_smallRwd, rsvp.bprime_DC_smallRwd] = ...
    sdt_measures(hit_rate_DC_smallRwd, falseAlarm_rate_DC_smallRwd); 

hit_rate_DC_largeRwd        = sum(largeRwd & DC_condition & (correct_Fem | correct_Hom)) / sum(largeRwd & DC_condition);
falseAlarm_rate_DC_largeRwd = sum(largeRwd & DC_condition & (incorrect_Fem | incorrect_Hom)) / sum( largeRwd & DC_condition);
[rsvp.dprime_DC_largeRwd, rsvp.criterion_DC_largeRwd, rsvp.aprime_DC_largeRwd, rsvp.bprime_DC_largeRwd] = ...
    sdt_measures(hit_rate_DC_largeRwd, falseAlarm_rate_DC_largeRwd); 

% SDT: BC
rsvp.hit_rate_BC            = sum(BC_condition & (correct_Fem | correct_Hom)) / sum(BC_condition);
rsvp.reject_rate_BC         = sum(BC_condition & (correct_NotFem | correct_NotHom)) / sum(BC_condition);
rsvp.falseAlarm_rate_BC     = sum(BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(BC_condition);
rsvp.miss_rate_BC           = sum(BC_condition & (incorrect_NotFem | incorrect_NotHom))/ sum(BC_condition);
[rsvp.dprime_BC, rsvp.criterion_BC, rsvp.aprime_BC, rsvp.bprime_BC] = sdt_measures(rsvp.hit_rate_BC, rsvp.falseAlarm_rate_BC); 

hit_rate_BC_smallRwd        = sum(smallRwd & BC_condition & (correct_Fem | correct_Hom)) / sum(smallRwd & BC_condition);
falseAlarm_rate_BC_smallRwd = sum(smallRwd & BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd & BC_condition);
[rsvp.dprime_BC_smallRwd, rsvp.criterion_BC_smallRwd, rsvp.aprime_BC_smallRwd, rsvp.bprime_BC_smallRwd] = ...
    sdt_measures(hit_rate_BC_smallRwd, falseAlarm_rate_BC_smallRwd); 

hit_rate_BC_largeRwd        = sum(largeRwd & BC_condition & (correct_Fem | correct_Hom)) / sum(largeRwd & BC_condition);
falseAlarm_rate_BC_largeRwd = sum(largeRwd & BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(largeRwd & BC_condition);
[rsvp.dprime_BC_largeRwd, rsvp.criterion_BC_largeRwd, rsvp.aprime_BC_largeRwd, rsvp.bprime_BC_largeRwd] = ...
    sdt_measures(hit_rate_BC_largeRwd, falseAlarm_rate_BC_largeRwd); 

% SDT: CC DC 
rsvp.hit_rate_CC_DC         = (sum(CC_DC_condition & (correct_Fem | correct_Hom)) / sum(CC_DC_condition));
rsvp.reject_rate_CC_DC      = (sum(CC_DC_condition & (correct_NotFem | correct_NotHom)) / sum(CC_DC_condition));
rsvp.falseAlarm_rate_CC_DC  = (sum(CC_DC_condition & (incorrect_Fem | incorrect_Hom)) / sum(CC_DC_condition));
rsvp.miss_rate_CC_DC        = (sum(CC_DC_condition & (incorrect_NotFem | incorrect_NotHom))/ sum(CC_DC_condition));
[rsvp.dprime_CC_DC, rsvp.criterion_CC_DC, rsvp.aprime_CC_DC, rsvp.bprime_CC_DC] = sdt_measures(rsvp.hit_rate_CC_DC, rsvp.falseAlarm_rate_CC_DC); 

hit_rate_CC_DC_smallRwd     = sum(smallRwd & CC_DC_condition & (correct_Fem | correct_Hom)) / sum(smallRwd & CC_DC_condition);
falseAlarm_rate_CC_DC_smallRwd = sum(smallRwd & CC_DC_condition & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd & CC_DC_condition);
[rsvp.dprime_CC_DC_smallRwd, rsvp.criterion_CC_DC_smallRwd, rsvp.aprime_CC_DC_smallRwd, rsvp.bprime_CC_DC_smallRwd] = ...
    sdt_measures(hit_rate_CC_DC_smallRwd, falseAlarm_rate_CC_DC_smallRwd); 

hit_rate_CC_DC_largeRwd     = sum(largeRwd & CC_DC_condition & (correct_Fem | correct_Hom)) / sum(largeRwd & CC_DC_condition);
falseAlarm_rate_CC_DC_largeRwd = sum(largeRwd & CC_DC_condition & (incorrect_Fem | incorrect_Hom)) / sum(largeRwd & CC_DC_condition);
[rsvp.dprime_CC_DC_largeRwd, rsvp.criterion_CC_DC_largeRwd, rsvp.aprime_CC_DC_largeRwd, rsvp.bprime_CC_DC_largeRwd] = ...
    sdt_measures(hit_rate_CC_DC_largeRwd, falseAlarm_rate_CC_DC_largeRwd); 

% SDT: CC BC 
rsvp.hit_rate_CC_BC         = (sum(CC_BC_condition & (correct_Fem | correct_Hom)) / sum(CC_BC_condition));
rsvp.reject_rate_CC_BC      = (sum(CC_BC_condition & (correct_NotFem | correct_NotHom)) / sum(CC_BC_condition));
rsvp.falseAlarm_rate_CC_BC  = (sum(CC_BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(CC_BC_condition));
rsvp.miss_rate_CC_BC        = (sum(CC_BC_condition & (incorrect_NotFem | incorrect_NotHom))/ sum(CC_BC_condition));
[rsvp.dprime_CC_BC, rsvp.criterion_CC_BC, rsvp.aprime_CC_BC, rsvp.bprime_CC_BC] = sdt_measures(rsvp.hit_rate_CC_BC, rsvp.falseAlarm_rate_CC_BC); 

hit_rate_CC_BC_smallRwd     = sum(smallRwd & CC_BC_condition & (correct_Fem | correct_Hom)) / sum(smallRwd & CC_BC_condition);
falseAlarm_rate_CC_BC_smallRwd = sum(smallRwd & CC_BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd & CC_BC_condition);
[rsvp.dprime_CC_BC_smallRwd, rsvp.criterion_CC_BC_smallRwd, rsvp.aprime_CC_BC_smallRwd, rsvp.bprime_CC_BC_smallRwd] = ...
    sdt_measures(hit_rate_CC_BC_smallRwd, falseAlarm_rate_CC_BC_smallRwd); 

hit_rate_CC_BC_largeRwd     = sum(largeRwd & CC_BC_condition & (correct_Fem | correct_Hom)) / sum(largeRwd & CC_BC_condition);
falseAlarm_rate_CC_BC_largeRwd  = sum(largeRwd & CC_BC_condition & (incorrect_Fem | incorrect_Hom)) / sum(largeRwd & CC_BC_condition);
[rsvp.dprime_CC_BC_largeRwd, rsvp.criterion_CC_BC_largeRwd, rsvp.aprime_CC_BC_largeRwd, rsvp.bprime_CC_BC_largeRwd] = ...
    sdt_measures(hit_rate_CC_BC_largeRwd, falseAlarm_rate_CC_BC_largeRwd); 

% SDT: CC 
rsvp.hit_rate_CC            = (sum(CC_condition & (correct_Fem | correct_Hom)) / sum(CC_condition));
rsvp.reject_rate_CC         = (sum(CC_condition & (correct_NotFem | correct_NotHom)) / sum(CC_condition));
rsvp.falseAlarm_rate_CC     = (sum(CC_condition & (incorrect_Fem | incorrect_Hom)) / sum(CC_condition));
rsvp.miss_rate_CC           = (sum(CC_condition & (incorrect_NotFem | incorrect_NotHom))/ sum(CC_condition));
[rsvp.dprime_CC, rsvp.criterion_CC, rsvp.aprime_CC, rsvp.bprime_CC] = sdt_measures(rsvp.hit_rate_CC, rsvp.falseAlarm_rate_CC); 

hit_rate_CC_smallRwd        = sum(smallRwd & CC_condition & (correct_Fem | correct_Hom)) / sum(smallRwd & CC_condition);
falseAlarm_rate_CC_smallRwd = sum(smallRwd & CC_condition & (incorrect_Fem | incorrect_Hom)) / sum(smallRwd & CC_condition);
[rsvp.dprime_CC_smallRwd, rsvp.criterion_CC_smallRwd, rsvp.aprime_CC_smallRwd, rsvp.bprime_CC_smallRwd] = ...
    sdt_measures(hit_rate_CC_smallRwd, falseAlarm_rate_CC_smallRwd); 

hit_rate_CC_largeRwd        = sum(largeRwd & CC_condition & (correct_Fem | correct_Hom)) / sum(largeRwd & CC_condition);
falseAlarm_rate_CC_largeRwd = sum(largeRwd & CC_condition & (incorrect_Fem | incorrect_Hom)) / sum(largeRwd & CC_condition);
[rsvp.dprime_CC_largeRwd, rsvp.criterion_CC_largeRwd, rsvp.aprime_CC_largeRwd, rsvp.bprime_CC_largeRwd] = ...
    sdt_measures(hit_rate_CC_largeRwd, falseAlarm_rate_CC_largeRwd); 

%% =================== RTs - Correct & Incorrect Trials ===================

rsvp.rt_correct             = mean(rt(correct == 1));
rsvp.rt_hit                 = mean(rt(hit == 1));
rsvp.rt_reject              = mean(rt(reject == 1));

rsvp.rt_incorrect           = mean(rt(incorrect == 1));
rsvp.rt_falseAlarm          = mean(rt(falseAlarm == 1));
rsvp.rt_miss                = mean(rt(miss == 1));

disp(['RTs correct : ',num2str(rsvp.rt_correct), ' s for correct trials including ', ...
    num2str(rsvp.rt_hit), ' s for hits & ', num2str(rsvp.rt_reject), ' s for rejections']);

disp(['RTs incorrect : ',num2str(rsvp.rt_incorrect), ' s for incorrect trials including ', ...
    num2str(rsvp.rt_falseAlarm), ' s for false alarms & ', num2str(rsvp.rt_miss), ' s for misses']);

%% =================== RTs - Rewards                    ===================

rsvp.rt_smallRwd            = mean(rt(smallRwd));
rsvp.rt_smallRwd_correct    = mean(rt(smallRwd_correct));
rsvp.rt_smallRwd_incorrect  = mean(rt(smallRwd_incorrect));

rsvp.rt_largeRwd            = mean(rt(largeRwd));
rsvp.rt_largeRwd_correct    = mean(rt(largeRwd_correct));
rsvp.rt_largeRwd_incorrect  = mean(rt(largeRwd_incorrect));

disp(['RTs reward : ',num2str(rsvp.rt_smallRwd), ' s for small rewards & ', ...
    num2str(rsvp.rt_largeRwd), ' s for large rewards ']);

%% =================== RTs - Conditions                 ===================

% Detrimental condition
rsvp.rt_DC                  = mean(rt(DC_condition));
rsvp.rt_DC_correct          = mean(rt(DC_correct));
rsvp.rt_DC_incorrect        = mean(rt(DC_incorrect));

rsvp.rt_DC_hom              = mean(rt(DC_hom));
rsvp.rt_DC_hom_correct      = mean(rt(DC_hom_correct));
rsvp.rt_DC_hom_incorrect    = mean(rt(DC_hom_incorrect));

rsvp.rt_DC_fem              = mean(rt(DC_fem));
rsvp.rt_DC_fem_correct      = mean(rt(DC_fem_correct));
rsvp.rt_DC_fem_incorrect    = mean(rt(DC_fem_incorrect));

% Control Condition
rsvp.rt_CC                  = mean(rt(CC_condition));
rsvp.rt_CC_correct          = mean(rt(CC_correct));
rsvp.rt_CC_incorrect        = mean(rt(CC_incorrect));

rsvp.rt_CC_hom              = mean(rt(CC_hom));
rsvp.rt_CC_hom_correct      = mean(rt(CC_hom_correct));
rsvp.rt_CC_hom_incorrect    = mean(rt(CC_hom_incorrect));

rsvp.rt_CC_fem              = mean(rt(CC_fem));
rsvp.rt_CC_fem_correct      = mean(rt(CC_fem_correct));
rsvp.rt_CC_fem_incorrect    = mean(rt(CC_fem_incorrect));

% Benefitial Condition
rsvp.rt_BC                  = mean(rt(BC_condition));
rsvp.rt_BC_correct          = mean(rt(BC_correct));
rsvp.rt_BC_incorrect        = mean(rt(BC_incorrect));

rsvp.rt_BC_hom              = mean(rt(BC_hom));
rsvp.rt_BC_hom_correct      = mean(rt(BC_hom_correct));
rsvp.rt_BC_hom_incorrect    = mean(rt(BC_hom_incorrect));

rsvp.rt_BC_fem              = mean(rt(BC_fem));
rsvp.rt_BC_fem_correct      = mean(rt(BC_fem_correct));
rsvp.rt_BC_fem_incorrect    = mean(rt(BC_fem_incorrect));


disp(['RTs Emotion : ',num2str(rsvp.rt_DC), ' s for detrimental condition, ', ...
    num2str(rsvp.rt_CC), ' s for control condition & ',num2str(rsvp.rt_BC), ' s for beneficial condition']);

%% =================== RTs - Gender                     ===================
rsvp.rt_fem                 = mean(rt(fem_condition));
rsvp.rt_fem_correct         = mean(rt(fem_correct));
rsvp.rt_fem_incorrect       = mean(rt(fem_incorrect));

rsvp.rt_hom                 = mean(rt(hom_condition));
rsvp.rt_hom_correct         = mean(rt(hom_correct));
rsvp.rt_hom_incorrect       = mean(rt(hom_incorrect));

disp(['RTs Gender: ',num2str(rsvp.rt_fem), ' s for condition femme & ', ...
    num2str(rsvp.rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions & Rewards       ===================

rsvp.rt_DC_smallRwd         = mean(rt(smallRwd & DC_condition));
rsvp.rt_DC_largeRwd         = mean(rt(largeRwd & DC_condition));

rsvp.rt_CC_smallRwd         = mean(rt(smallRwd & CC_condition));
rsvp.rt_CC_largeRwd         = mean(rt(largeRwd & CC_condition));

rsvp.rt_BC_smallRwd         = mean(rt(smallRwd & BC_condition));
rsvp.rt_BC_largeRwd         = mean(rt(largeRwd & BC_condition));

%% =================== RTs - Gender & Rewards           ===================

rsvp.rt_fem_smallRwd        = mean(rt(smallRwd & fem_condition));
rsvp.rt_fem_largeRwd        = mean(rt(largeRwd & fem_condition));

rsvp.rt_hom_smallRwd        = mean(rt(smallRwd & hom_condition));
rsvp.rt_hom_largeRwd        = mean(rt(largeRwd & hom_condition));

%% =================== RTs - Link To Performance        ===================

rsvp.rt_median              = median(rt); 

rt_slow                     = find(rt > rsvp.rt_median); 
rsvp.rt_slow_perf           = sum(correct(rt_slow))/length(rt_slow)*100;
rt_fast                     = find(rt < rsvp.rt_median);
rsvp.rt_fast_perf           = sum(correct(rt_fast))/length(rt_fast)*100;

linearMdl                   = fitlm(correct,rt);
rsvp.linearCoef             = linearMdl.Coefficients.Estimate(2);


%% =================== Learning Curves                  ===================

rsvp.LC                     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC)
    rsvp.LC(i)              = (sum(correct(block == i)))/(length(nTrial(block == i)))*100;
end

rsvp.LC_smallRwd            = zeros(1,length(rsvp.smallRwdBlock));
for i = 1:length(rsvp.smallRwdBlock)
     rsvp.LC_smallRwd(i)    = sum(correct(block == rsvp.smallRwdBlock(i)))/sum(smallRwd(block == rsvp.smallRwdBlock(i)))*100;
end

rsvp.LC_largeRwd            = zeros(1,length(rsvp.largeRwdBlock));
for i = 1:length(rsvp.largeRwdBlock)
    rsvp.LC_largeRwd(i)     = sum(correct(block == rsvp.largeRwdBlock(i)))/sum(largeRwd(block == rsvp.largeRwdBlock(i)))*100;
end

rsvp.LC_DC                  = zeros(1,length(rsvp.DC_block));
for i = 1:length(rsvp.DC_block)
     rsvp.LC_DC(i)          = sum(DC_correct(block == rsvp.DC_block(i)))/ sum(DC_condition(block == rsvp.DC_block(i)))*100;
end

rsvp.LC_BC                  = zeros(1,length(rsvp.BC_block));
for i = 1:length(rsvp.BC_block)
     rsvp.LC_BC(i)          = sum(BC_correct(block == rsvp.BC_block(i))) / sum(BC_condition(block == rsvp.BC_block(i)))*100;
end

rsvp.LC_CC                  = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.LC_CC)
     rsvp.LC_CC(i)          = sum(CC_correct(block == i))/ sum(CC_condition(block == i))*100;
end

%% =================== RTs Curves                       ===================

rsvp.RTsC                   = zeros(1,cfg_exp.nBlocksExp);
for i = 1:cfg_exp.nBlocksExp
    rsvp.RTsC(i)            = mean(rt(block == i));
end

rsvp.RTsC_smallRwd          = zeros(1,length(rsvp.smallRwdBlock));
for i = 1:length(rsvp.smallRwdBlock)
     rsvp.RTsC_smallRwd(i)  = mean(rt(block == rsvp.smallRwdBlock(i)));
end

rsvp.RTsC_largeRwd          = zeros(1,length(rsvp.largeRwdBlock));
for i = 1:length(rsvp.largeRwdBlock)
    rsvp.RTsC_largeRwd(i)   = mean(rt(block == rsvp.largeRwdBlock(i)));
end

rsvp.RTsC_DC                = zeros(1,length(rsvp.DC_block));
for i = 1:length(rsvp.DC_block)
     rsvp.RTsC_DC(i)        = mean(rt(block == rsvp.DC_block(i) & DC_condition));
end

rsvp.RTsC_BC                = zeros(1,length(rsvp.BC_block));
for i = 1:length(rsvp.BC_block)
     rsvp.RTsC_BC(i)        = mean(rt(block == rsvp.BC_block(i) & BC_condition));
end

rsvp.RTsC_CC                = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(rsvp.RTsC_CC)
     rsvp.RTsC_CC(i)        = mean(rt(block == i & CC_condition));
end

%% =================== PLOT PART                        ===================
if fig
    
    %% Performance Plots
    % Performance par conditions 
    figure('Name', 'Performance Plots');
    subplot(2,2,1)
    hold on;
    bar([rsvp.perf_DC 0 0],'FaceColor',[0.55 0.25 0.35]);
    bar([0 rsvp.perf_CC 0],'FaceColor',[0.75 0.75 0.75]);
    bar([0 0 rsvp.perf_BC],'FaceColor',[0.40 0.55 0.40]);
    xticks([1 2 3 4])
    xticklabels({'DC','CC', 'BC'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to conditions','fontsize', 10)
    axis([0 4 50 105])
    grid minor 
    box on 
    hold off
    
    % Performance par rewards 
    subplot(2,2,2)
    hold on;
    bar([rsvp.smallRwd_rate 0],'FaceColor',[0.75, 0.85, 0.90]);
    bar([0 rsvp.largeRwd_rate],'FaceColor',[0.35, 0.50, 0.60]);
    xticks([1 2])
    xticklabels({'Small Reward','Large Reward'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to reward','fontsize', 10)
    axis([0 3 50 105])
    grid minor 
    box on 
    hold off

    % Performance par conditions & rewards 
    subplot(2,1,2)
    hold on;
    bar([rsvp.perf_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 rsvp.perf_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 rsvp.perf_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 rsvp.perf_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 rsvp.perf_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 rsvp.perf_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
    xticks([1 2 3 4 5 6])
    xticklabels({'DC Small Rwd','DC Large Rwd','CC Small Rwd','CC Large Rwd','BC Small Rwd',' BC Large Rwd'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to reward & conditions','fontsize', 10)
    axis([0 7 50 105])
    grid minor 
    box on 
    hold off

    % Title of the whole plot 
    sgtitle(['Performance Plots for Pilot n°',num2str(ID)])
    
    %% RTs Plots 
    figure('Name', 'RTs Plots');
    [h_RT, p_RT] = adtest(rt);
    subplot(2,3,1)
    histogram(rt,10,'FaceColor',[.5, .5, .5], 'EdgeColor', [.5 .5 .5])
    xlabel('Reaction Time','fontsize', 10)
    ylabel('Number of trials','fontsize', 10)
    title('Distribution of reaction times','fontsize', 12,'fontname', 'Calibri Light')
    if h_RT == 0
        text(-1,75,['The distribution is normal at p = ', num2str(round(p_RT,3))],'fontsize', 8,'fontname', 'Calibri')
    elseif h_RT == 1
        text(-1,75,['The distribution is not normal at p = ', num2str(round(p_RT,3))],'fontsize', 8,'fontname', 'Calibri')
    end
    axis([-1.5 1.5 0 80])
    grid minor
    box on

    % RTs par conditions 
    subplot(2,3,2)
    hold on;
    bar([rsvp.rt_DC 0 0],'FaceColor',[0.75 0.45 0.55]);
    bar([0 rsvp.rt_CC 0],'FaceColor',[0.75 0.75 0.75]);
    bar([0 0 rsvp.rt_BC],'FaceColor',[0.40 0.55 0.40]);
    xticks([1 2 3 4])
    xticklabels({'DC','CC', 'BC'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to conditions','fontsize', 10)
    axis([0 4 -1 1])
    grid minor 
    box on 
    hold off
    
    % RTs par rewards 
    subplot(2,3,3)
    hold on;
    bar([rsvp.rt_smallRwd 0],'FaceColor',[0.75, 0.85, 0.90]);
    bar([0 rsvp.rt_largeRwd],'FaceColor',[0.35, 0.50, 0.60]);
    xticks([1 2])
    xticklabels({'Small Reward','Large Reward'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to reward','fontsize', 10)
    axis([0 3 -1 1])
    grid minor 
    box on 
    hold off

    % RTs par conditions & rewards 
    subplot(2,1,2)
    hold on;
    bar([rsvp.rt_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 rsvp.rt_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 rsvp.rt_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 rsvp.rt_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 rsvp.rt_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 rsvp.rt_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
    xticks([1 2 3 4 5 6])
    xticklabels({'DC Small Rwd','DC Large Rwd','CC Small Rwd','CC Large Rwd','CC Small Rwd',' CC Large Rwd'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to reward & conditions','fontsize', 10)
    axis([0 7 -1 1])
    grid minor 
    box on 
    hold off
    
    % Title of the whole plot
    sgtitle(['RTs Plots for Pilot n°',num2str(ID)])
    
    %% Learning Curves Plots
    figure('Name', 'Learning Curve Plots');

    subplot(2,1,1)
    p = plot(1:(length(rsvp.LC)), rsvp.LC,'linew',1.5);
    p.Color = [0 0 0];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (Mean)','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:(length(rsvp.LC)))
    xticklabels(unique(block))
    title('Learning Curve Experiment','fontsize', 10)
    axis([0 (length(rsvp.LC)+1) 40 105])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p1 = plot(rsvp.smallRwdBlock, rsvp.LC_smallRwd,'-x','linew',1.5);
    p1.Color = [0.75, 0.85, 0.90];
    p2 = plot(rsvp.largeRwdBlock, rsvp.LC_largeRwd,'-o','linew',1.5);
    p2.Color = [0.35, 0.50, 0.60];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (Mean)','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:12); xticklabels(unique(block))
    title('Learning Curve for Small and Large Rewards','fontsize', 10)
    axis([0 (length(unique(block))+1) 40 110])
    hold off
    grid minor
    box on
    
    subplot(2,2,4)
    hold on
    p1 = plot(rsvp.DC_block, rsvp.LC_DC,'-x','linew',1.5);
    p1.Color = [.75 .45 .55];
    p2 = plot(unique(block), rsvp.LC_CC,'-+','linew',1.5);
    p2.Color = [.5 .5 .5];
    p3 = plot(rsvp.BC_block, rsvp.LC_BC,'-o','linew',1.5);
    p3.Color = [.40 .55 .40];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (Mean)','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:12); xticklabels(unique(block))
    title('Learning Curve for DC and BC','fontsize', 10)
    axis([0 (length(unique(block))+1) 40 110])
    hold off
    grid minor
    box on
    
    % Title of the whole plot
    sgtitle(['Learning Curve for Pilot n°',num2str(ID)])
    
    %% RTs Curves Plots
    figure('Name', ' RSVP RTs Curve Plots');

    subplot(2,1,1)
    p = plot(1:(length(rsvp.RTsC)), rsvp.RTsC,'linew',1.5);
    p.Color = [0 0 0];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Mean(log(RTS))','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:(length(rsvp.RTsC)))
    xticklabels(unique(block))
    title('RTs Curve RSVP Experiment','fontsize', 10)
    axis([0 (length(rsvp.RTsC)+1) -1 1])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p1 = plot(rsvp.smallRwdBlock, rsvp.RTsC_smallRwd,'-x','linew',1.5);
    p1.Color = [0.75, 0.85, 0.90];
    p2 = plot(rsvp.largeRwdBlock, rsvp.RTsC_largeRwd,'-o','linew',1.5);
    p2.Color = [0.35, 0.50, 0.60];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Mean(log(RTS))','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:12); xticklabels(unique(block))
    title('RTs Curve for Small and Large Rewards','fontsize', 10)
    axis([0 (length(unique(block))+1) -1 1])
    hold off
    grid minor
    box on
    
    subplot(2,2,4)
    hold on
    p1 = plot(rsvp.DC_block, rsvp.RTsC_DC,'-x','linew',1.5);
    p1.Color = [.75 .45 .55];
    p2 = plot(unique(block), rsvp.RTsC_CC,'-o','linew',1.5);
    p2.Color = [.50 .50 .50];
    p3 = plot(rsvp.BC_block, rsvp.RTsC_BC,'-+','linew',1.5);
    p3.Color = [.40 .55 .40];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Mean(log(RTS))','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:12); xticklabels(unique(block))
    title('RTs Curve for DC and BC','fontsize', 10)
    axis([0 (length(unique(block))+1) -1 1])
    hold off
    grid minor
    box on
    
    %% Gender Plots 
    
    % Performance par gender 
    figure('Name', 'Gender Plots');
    
    gender_fem = {rsvp.perf_fem, rsvp.rt_fem};
    gender_hom = {rsvp.perf_hom, rsvp.rt_hom};
    gender_labels ={'Performance','RTs'};
    gender_titles ={'Performance according to gender', 'RTs according to gender'};
    gender_axis = {[0 3 50 105], [0 3 -1 1]};
    
    for i = 1:2
        subplot(2,2,i)
        hold on;
        bar([gender_fem{i} 0],'FaceColor',[0.85 0.55 0.65]);
        bar([0 gender_hom{i}],'FaceColor',[0.45, 0.60, 0.70]);
        xticks([1 2])
        xticklabels({'Female','Male'})
        ylabel(gender_labels{i},'fontsize', 10)
        title(gender_titles{i},'fontsize', 10)
        axis(gender_axis{i})
        grid minor
        box on
        hold off
    end
    
        % Performance par genre & conditions
    subplot(2,1,2)
    hold on;
    bar([rsvp.DC_fem_rate 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 rsvp.DC_hom_rate 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 rsvp.CC_fem_rate 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 rsvp.CC_hom_rate 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 rsvp.BC_fem_rate 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 rsvp.BC_hom_rate],'FaceColor',[0.30 0.45 0.30]);
    xticks([1 2 3 4 5 6])
    xticklabels({'DC Fem','DC Hom','CC Fem','CC Hom','BC Fem','BC Hom'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to gender & conditions','fontsize', 10)
    axis([0 7 40 105])
    grid minor
    box on
    hold off
        
end


%end
