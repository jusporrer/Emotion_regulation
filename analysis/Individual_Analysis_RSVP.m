% JS initial individual analysis script for the effect of incentives on emotion regulation 
% in a RSVP Task
% Creation : February 2020

%function []    = Individual_Analysis_RSVP(ID, fig)
clearvars;
close all; 

ID              =  90255;
fig             = 1;

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

cfg_training    = data_rsvp(1).cfg;
nTrain          = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp         = data_rsvp(nTrain+1).cfg;
%(0 = training, 1 = Small reward, 2 = Large reward)
reward          = [data_rsvp(nTrain+1:end).reward];
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition       = [data_rsvp(nTrain+1:end).condition];
block           = [data_rsvp(nTrain+1:end).block];
trial           = [data_rsvp(nTrain+1:end).trial];
rt              = [data_rsvp(nTrain+1:end).RTs];
% (1 = femquest, 2 = homquest)
instQuest       = [data_rsvp(nTrain+1:end).instQuest];
% (1 = [o] / oui; 2 = [n] / non)
response        = [data_rsvp(nTrain+1:end).response];
posCritDist     = [data_rsvp(nTrain+1:end).posCritDist];
posTarget       = [data_rsvp(nTrain+1:end).posTarget];
% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale)
distractor      = [data_rsvp(nTrain+1:end).distractor];
target          = [data_rsvp(nTrain+1:end).target];

%% =================== Basic Information                ===================

nTrial          = 1:length(trial); % allows the indexing

if length(trial) == cfg_exp.nTrialsExp * cfg_exp.nBlocksExp
    disp(['No data loss : There were ',num2str(length(trial)), ' trials']);
else
    disp(['Problem : There were only ',num2str(length(trial)), ' trials out of the normal ', ...
        num2str(cfg_exp.nTrialsExp * cfg_exp.nBlocksExp), 'trial expected']);
end

%% =================== Exclude 3 STD RTs                ===================

rtExp           = rt(nTrial);
mean_RtExp      = mean(rtExp) ;
std_RtExp       = std(rtExp)*3 ;

% Recalculate nTrial with only non-outlier RT trials
low_RtExp       = mean_RtExp-std_RtExp ;
up_RtExp        = mean_RtExp+std_RtExp ;

kept_RtExp      = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp));
excl_RtExp      = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

nTrial          = nTrial(kept_RtExp);
rt              = rt(nTrial); 
block           = block(nTrial);

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Correct Trials     ===================

% Correctly detect fem when fem was target
correct_Fem     = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));
correct_FearFem = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                           % fearful fem targets
    & target(nTrial) == 1);
correct_NeutralFem  = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...                       % neutral fem targets
    & target(nTrial) == 3);

% Correctly detect hom when hom was target
correct_Hom     = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));
correct_FearHom = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                           % fearful hom targets
    & target(nTrial) == 2);
correct_NeutralHom  = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...                       % neutral hom taregts
    & target(nTrial) == 4);

% Correctly reject fem when hom was target
correct_NotFem  = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));
correct_NotFem_FearHom = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & target(nTrial) == 2);
correct_NotFem_NeutralHom = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...
    & target(nTrial) == 4);

% Correctly reject hom when fem was target
correct_NotHom  = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));
correct_NotHom_FearFem = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & target(nTrial) == 1);
correct_NotHom_NeutralFem = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...
    & target(nTrial) == 3);

% Sum of all the correct trials
correct         = (correct_Fem) + (correct_Hom) + (correct_NotFem) + (correct_NotHom);
nCorrect        = sum(correct);

% SDT: correct hit
hit             = (correct_Fem) + (correct_Hom);
hit_rate        = (sum(hit)/nCorrect)*100;

% SDT: correct rejection
reject  = (correct_NotFem) + (correct_NotHom);
reject_rate     = (sum(reject)/nCorrect)*100;

% General performance
performance     = nCorrect/length(nTrial)*100;

disp(['Performance : ',num2str(ceil(performance)), ...
    '% correct trials with ',num2str(ceil(hit_rate)), '% hits & ', ...
    num2str(ceil(reject_rate)), '% rejections' ]);

%% =================== Performance - Incorrect Trials   ===================

% Incorrectly not detect fem when fem was target ( false alarm: says present when not present)
incorrect_Fem = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                             % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));
incorrect_FearFem = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                         % fearful fem targets
    & target(nTrial) == 1);
incorrect_NeutralFem = (response(nTrial) == 2 & instQuest(nTrial) == 1 ...                      % neutral fem targets
    & target(nTrial) == 3);

% Incorrectly not detect hom when hom was target
incorrect_Hom = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                             % all hom targets
    & (target(nTrial) == 2 | target(nTrial) == 4));
incorrect_FearHom = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                         % fearful hom targets
    & target(nTrial) == 2);
incorrect_NeutralHom = (response(nTrial) == 2 & instQuest(nTrial) == 2 ...                      % neutral hom taregts
    & target(nTrial) == 4);

% Incorrectly reject hom when hom was target ( miss: says not preset when present)
incorrect_NotFem = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));
incorrect_NotFem_FearHom = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & target(nTrial) == 2);
incorrect_NotFem_NeutralHom = (response(nTrial) == 1 & instQuest(nTrial) == 1 ...
    & target(nTrial) == 4);

% Incorrectly reject fem when fem was target
incorrect_NotHom = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));
incorrect_NotHom_FearFem = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & target(nTrial) == 1);
incorrect_NotHom_NeutralFem = (response(nTrial) == 1 & instQuest(nTrial) == 2 ...
    & target(nTrial) == 3);

% Sum of all the incorrect trials
incorrect       = (incorrect_Fem) + (incorrect_Hom) + (incorrect_NotFem) + (incorrect_NotHom);
nIncorrect      = sum(incorrect);

% SDT: false alarms
falseAlarm      = (incorrect_Fem) + (incorrect_Hom);
falseAlarm_rate = (sum(falseAlarm)/nIncorrect)*100;

% SDT: misses
miss            = (incorrect_NotFem) + (incorrect_NotHom);
miss_rate       = (sum(miss)/nIncorrect)*100;

% General performance
perf_incorrect  = nIncorrect/length(nTrial)*100;

disp(['Performance : ',num2str(ceil(perf_incorrect)), ...
    '% incorrect trials with ',num2str(ceil(falseAlarm_rate)), '% false alarms & ', ...
    num2str(ceil(miss_rate)), '% misses' ]);

%% =================== Performance - Rewards            ===================

smallRwd        = (reward(nTrial) == 1);
smallRwdBlock   = unique(block(smallRwd == 1));
correct_smallRwd= (correct(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1);
smallRwd_rate   = sum(correct_smallRwd)/sum(smallRwd)*100;

largeRwd        = (reward(nTrial) == 2);
largeRwdBlock   = unique(block(largeRwd == 1));
correct_largeRwd= (correct(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1);
largeRwd_rate   = sum(correct_largeRwd)/sum(largeRwd)*100;

disp(['Reward : ',num2str(ceil(smallRwd_rate)), '% were correct for small rwd & ', ...
    num2str(ceil(largeRwd_rate)), '% were correct for large rwd' ]);

%% =================== Performance - Conditions         ===================
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)

% Detrimental condition
DC_hom          = (condition(nTrial) == 1);
correct_DC_hom  = (correct(1:length(nTrial)) == 1 & DC_hom(1:length(nTrial)) == 1);
incorrect_DC_hom= (incorrect(1:length(nTrial)) == 1 & DC_hom(1:length(nTrial)) == 1);
DC_hom_rate     = sum(correct_DC_hom)/sum(DC_hom)*100;

DC_fem          = (condition(nTrial) == 2);
correct_DC_fem  = (correct(1:length(nTrial)) == 1 & DC_fem(1:length(nTrial)) == 1);
incorrect_DC_fem= (incorrect(1:length(nTrial)) == 1 & DC_fem(1:length(nTrial)) == 1);
DC_fem_rate     = sum(correct_DC_fem)/sum(DC_fem)*100;

% Control Conditions
CC_hom          = (condition(nTrial) == 3);
correct_CC_hom  = (correct(1:length(nTrial)) == 1 & CC_hom(1:length(nTrial)) == 1);
incorrect_CC_hom= (incorrect(1:length(nTrial)) == 1 & CC_hom(1:length(nTrial)) == 1);
CC_hom_rate     = sum(correct_CC_hom)/sum(CC_hom)*100;

CC_fem          = (condition(nTrial) == 4);
correct_CC_fem  = (correct(1:length(nTrial)) == 1 & CC_fem(1:length(nTrial)) == 1);
incorrect_CC_fem= (incorrect(1:length(nTrial)) == 1 & CC_fem(1:length(nTrial)) == 1);
CC_fem_rate     = sum(correct_CC_fem)/sum(CC_fem)*100;

% Beneficial Conditions
BC_hom          = (condition(nTrial) == 5);
correct_BC_hom  = (correct(1:length(nTrial)) == 1 & BC_hom(1:length(nTrial)) == 1);
incorrect_BC_hom= (incorrect(1:length(nTrial)) == 1 & BC_hom(1:length(nTrial)) == 1);
BC_hom_rate     = sum(correct_BC_hom)/sum(BC_hom)*100;

BC_fem          = (condition(nTrial) == 6);
correct_BC_fem  = (correct(1:length(nTrial)) == 1 & BC_fem(1:length(nTrial)) == 1);
incorrect_BC_fem= (correct(1:length(nTrial)) == 1 & BC_fem(1:length(nTrial)) == 1);
BC_fem_rate     = sum(correct_BC_fem)/sum(BC_fem)*100;

% Number of trials in each conditions
if sum(DC_hom) == sum(DC_fem) == sum(CC_hom) == sum(CC_fem) == sum(BC_hom) ==  sum(BC_fem)
    disp(['All conditions have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), 'trials']);
else
    disp(['Warning, not all condition have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), ' trials']);
end

% Condition Emotions
perf_DC         = (DC_hom_rate + DC_fem_rate) / 2;
perf_CC         = (CC_hom_rate + CC_fem_rate) / 2;
perf_BC         = (BC_hom_rate + BC_fem_rate) / 2;

disp(['Performance Emotion : ',num2str(ceil(perf_DC)), '% for detrimental condition, ', ...
    num2str(ceil(perf_CC)), '% for control condition & ',num2str(ceil(perf_BC)), '% for beneficial condition']);

inabi_inhibit   = perf_CC - perf_DC;
abi_enhance     = perf_BC - perf_CC;

% Condition Gender
perf_fem        = (DC_fem_rate + CC_fem_rate + BC_fem_rate) / 3;
perf_hom        = (DC_hom_rate + CC_hom_rate + BC_hom_rate) / 3;

disp(['Performance Gender: ',num2str(ceil(perf_fem)), '% for condition femme & ', ...
    num2str(ceil(perf_hom)), '% for condition homme ']);

%% =================== Performance - Conditions & Rewards===================

perf_DC_smallRwd = ((sum(correct_DC_hom(smallRwd == 1))/sum(DC_hom(smallRwd == 1)))*100 ...
    + (sum(correct_DC_fem(smallRwd == 1))/sum(DC_fem(smallRwd == 1)))*100) / 2;

perf_DC_largeRwd = ((sum(correct_DC_hom(largeRwd ==1))/sum(DC_hom(largeRwd ==1)))*100 ...
    + (sum(correct_DC_fem(largeRwd == 1))/sum(DC_fem(largeRwd == 1)))*100) / 2;

perf_CC_smallRwd = ((sum(correct_CC_hom(smallRwd == 1))/sum(CC_hom(smallRwd == 1)))*100 ...
    + (sum(correct_CC_fem(smallRwd == 1))/sum(CC_fem(smallRwd == 1)))*100) / 2;

perf_CC_largeRwd = ((sum(correct_CC_hom(largeRwd == 1))/sum(CC_hom(largeRwd == 1)))*100 ...
    + (sum(correct_CC_fem(largeRwd == 1))/sum(CC_fem(largeRwd == 1)))*100) / 2;

perf_BC_smallRwd = ((sum(correct_BC_hom(smallRwd == 1))/sum(BC_hom(smallRwd == 1)))*100 ...
    + (sum(correct_BC_fem(smallRwd ==1))/sum(BC_fem(smallRwd ==1)))*100) / 2;

perf_BC_largeRwd = ((sum(correct_BC_hom(largeRwd == 1))/sum(BC_hom(largeRwd == 1)))*100 ...
    + (sum(correct_BC_fem(largeRwd == 1))/sum(BC_fem(largeRwd == 1)))*100) / 2;

%% =================== Performance - Lags               ===================

lag             = posTarget-posCritDist;

lag2            = (lag(nTrial) == 2);
nlag2           = sum(lag2);
correct_lag2    = (correct(1:length(nTrial)) == 1 & lag2(1:length(nTrial)) == 1);
lag2_rate       = sum(correct_lag2)/nlag2*100;

lag4            = (lag(nTrial) == 4);
nlag4           = sum(lag4);
correct_lag4    = (correct(1:length(nTrial)) == 1 & lag4(1:length(nTrial)) == 1);
lag4_rate       = sum(correct_lag4)/nlag4*100;

disp(['Performance Lag : ',num2str(ceil(lag2_rate)), '% were correct after a lag 2 & ', ...
    num2str(ceil(lag4_rate)), '% were correct after a lag 4' ]);

%% =================== RTs - Correct & Incorrect Trials ===================

rt_correct      = rt(correct == 1);
rt_hit          = rt(hit == 1);
rt_reject       = rt(reject == 1);

rt_incorrect    = rt(incorrect == 1);
rt_falseAlarm   = rt(falseAlarm == 1);
rt_miss         = rt(miss == 1);

disp(['RTs correct : ',num2str(mean(rt_correct)), ' s for correct trials including ', ...
    num2str(mean(rt_hit)), ' s for hits & ', num2str(mean(rt_reject)), ' s for rejections']);

disp(['RTs incorrect : ',num2str(mean(rt_incorrect)), ' s for incorrect trials including ', ...
    num2str(mean(rt_falseAlarm)), ' s for false alarms & ', num2str(mean(rt_miss)), ' s for misses']);

%% =================== RTs - Rewards                    ===================

rt_smallRwd     = rt(smallRwd);
rt_smallRwd_correct = rt(correct_smallRwd == 1);

rt_largeRwd     = rt(largeRwd);
rt_largeRwd_correct = rt(correct_largeRwd == 1);

disp(['RTs reward : ',num2str(mean(rt_smallRwd)), ' s for small rewards & ', ...
    num2str(mean(rt_largeRwd)), ' s for large rewards ']);

%% =================== RTs - Conditions                 ===================

rt_DC_hom       = rt(DC_hom == 1);
rt_DC_hom_correct= rt(correct_DC_hom == 1);
rt_DC_hom_incorrect= rt(incorrect_DC_hom == 1);

rt_DC_fem       = rt(DC_fem == 1);
rt_DC_fem_correct= rt(correct_DC_fem == 1);
rt_DC_fem_incorrect= rt(incorrect_DC_fem == 1);

rt_CC_hom       = rt(CC_hom == 1);
rt_CC_hom_correct= rt(correct_CC_hom == 1);
rt_CC_hom_incorrect= rt(incorrect_CC_hom == 1);

rt_CC_fem       = rt(CC_fem == 1);
rt_CC_fem_correct= rt(correct_CC_fem == 1);
rt_CC_fem_incorrect= rt(incorrect_CC_fem == 1);

rt_BC_hom       = rt(BC_hom == 1);
rt_BC_hom_correct= rt(correct_BC_hom == 1);
rt_BC_hom_incorrect= rt(incorrect_BC_hom == 1);

rt_BC_fem       = rt(BC_fem == 1);
rt_BC_fem_correct= rt(correct_BC_fem == 1);
rt_BC_fem_incorrect= rt(incorrect_BC_fem == 1);

% Condition Emotions
rt_DC           = (mean(rt_DC_hom) + mean(rt_DC_fem)) / 2;
rt_CC           = (mean(rt_CC_hom) + mean(rt_CC_fem)) / 2;
rt_BC           = (mean(rt_BC_hom) + mean(rt_BC_fem)) / 2;

disp(['RTs Emotion : ',num2str(rt_DC), ' s for detrimental condition, ', ...
    num2str(rt_CC), ' s for control condition & ',num2str(rt_BC), ' s for beneficial condition']);

% Condition Gender
rt_fem          = (mean(rt_DC_fem) + mean(rt_CC_fem) + mean(rt_BC_fem)) / 3;
rt_hom          = (mean(rt_DC_hom) + mean(rt_CC_hom) + mean(rt_BC_hom)) / 3;

disp(['RTs Gender: ',num2str(rt_fem), ' s for condition femme & ', ...
    num2str(rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions & Rewards       ===================

rt_DC_smallRwd = (mean(rt(smallRwd == 1 & DC_hom == 1)) + mean(rt(smallRwd == 1 & DC_fem == 1)))/ 2;

rt_DC_largeRwd = (mean(rt(largeRwd == 1 & DC_hom == 1)) + mean(rt(largeRwd == 1 & DC_fem == 1)))/ 2;

rt_CC_smallRwd = (mean(rt(smallRwd == 1 & CC_hom == 1)) + mean(rt(smallRwd == 1 & CC_fem == 1)))/ 2;

rt_CC_largeRwd = (mean(rt(largeRwd == 1 & CC_hom == 1)) + mean(rt(largeRwd == 1 & CC_fem == 1)))/ 2;

rt_BC_smallRwd = (mean(rt(smallRwd == 1 & BC_hom == 1)) + mean(rt(smallRwd == 1 & BC_fem == 1)))/ 2;

rt_BC_largeRwd = (mean(rt(largeRwd == 1 & BC_hom == 1)) + mean(rt(largeRwd == 1 & BC_fem == 1)))/ 2;

%% =================== Learning Curve                   ===================

LC              = zeros(1,cfg_exp.nBlocksExp);
for i = 1:cfg_exp.nBlocksExp
    LC(i)       = (sum(correct(block == i)))/(length(nTrial)/cfg_exp.nBlocksExp)*100;
end

LC_smallRwd     = zeros(1,length(smallRwdBlock));
for i = 1:length(smallRwdBlock)
     LC_smallRwd(i) = (sum(correct_smallRwd(block == smallRwdBlock(i))))/(length(nTrial)/cfg_exp.nBlocksExp)*100;
end

LC_largeRwd     = zeros(1,length(largeRwdBlock));
for i = 1:length(largeRwdBlock)
    LC_largeRwd(i) = (sum(correct_largeRwd(block == largeRwdBlock(i))))/(length(nTrial)/cfg_exp.nBlocksExp)*100;
end

%% =================== PLOT PART                        ===================
if fig == 1
    
    %% Performance Plots
    % Performance par conditions 
    figure('Name', 'Performance Plots');
    subplot(2,2,1)
    hold on;
    bar([perf_DC 0 0],'FaceColor',[0.55 0.25 0.35]);
    bar([0 perf_CC 0],'FaceColor',[0.75 0.75 0.75]);
    bar([0 0 perf_BC],'FaceColor',[0.40 0.55 0.40]);
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
    bar([smallRwd_rate 0],'FaceColor',[0.75, 0.85, 0.90]);
    bar([0 largeRwd_rate],'FaceColor',[0.35, 0.50, 0.60]);
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
    bar([perf_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 perf_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 perf_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 perf_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 perf_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 perf_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
    xticks([1 2 3 4 5 6])
    xticklabels({'DC Small Rwd','DC Large Rwd','CC Small Rwd','CC Large Rwd','BC Small Rwd',' BC Large Rwd'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to reward & conditions','fontsize', 10)
    axis([0 7 50 105])
    grid minor 
    box on 
    hold off

    %% RTs Plots 
    % RTs par conditions 
    figure('Name', 'RTs Plots');
    subplot(2,2,1)
    hold on;
    bar([rt_DC 0 0],'FaceColor',[0.75 0.45 0.55]);
    bar([0 rt_CC 0],'FaceColor',[0.75 0.75 0.75]);
    bar([0 0 rt_BC],'FaceColor',[0.40 0.55 0.40]);
    xticks([1 2 3 4])
    xticklabels({'DC','CC', 'BC'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to conditions','fontsize', 10)
    axis([0 4 0 2])
    grid minor 
    box on 
    hold off
    
    % RTs par rewards 
    subplot(2,2,2)
    hold on;
    bar([mean(rt_smallRwd) 0],'FaceColor',[0.75, 0.85, 0.90]);
    bar([0 mean(rt_largeRwd)],'FaceColor',[0.35, 0.50, 0.60]);
    errorbar(1, mean(rt_smallRwd), std(rt_smallRwd), 'k.','LineWidth',1.5);
    errorbar(2, mean(rt_largeRwd), std(rt_largeRwd), 'k.','LineWidth',1.5);
    xticks([1 2])
    xticklabels({'Small Reward','Large Reward'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to reward','fontsize', 10)
    axis([0 3 0 2])
    grid minor 
    box on 
    hold off

    % RTs par conditions & rewards 
    subplot(2,1,2)
    hold on;
    bar([rt_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 rt_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 rt_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 rt_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 rt_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 rt_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
    xticks([1 2 3 4 5 6])
    xticklabels({'DC Small Rwd','DC Large Rwd','CC Small Rwd','CC Large Rwd','CC Small Rwd',' CC Large Rwd'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to reward & conditions','fontsize', 10)
    axis([0 7 0 2])
    grid minor 
    box on 
    hold off
    
    %% Learning Curves Plots
    figure('Name', 'Learning Curve Plots');
    LC_plots    = {LC, LC_smallRwd, LC_largeRwd};
    LC_titles   = {'Learning Curve Experiment', 'Learning Curve for Small Rewards', 'Learning Curve for Large Rewards'};
    LC_xtick    = {unique(block), smallRwdBlock, largeRwdBlock};
    LC_color    = {[0 0 0], [0.75, 0.85, 0.90], [0.35, 0.50, 0.60]};
    for i = 1:3
        subplot(2,2,i)
        p = plot(1:(length(LC_plots{i})), LC_plots{i},'linew',1.5);
        p.Color = LC_color{i};
        line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
        ylabel('Performance','fontsize', 10)
        xlabel('Number of blocks','fontsize', 10)
        xticks(1:(length(LC_plots{i})))
        xticklabels(LC_xtick{i})
        title(LC_titles{i},'fontsize', 10)
        axis([0 (length(LC_plots{i})+1) 40 105])
        grid minor
        box on
    end
    
    subplot(2,2,4)
    hold on
    p1 = plot(smallRwdBlock, LC_smallRwd,'linew',1.5);
    p1.Color = LC_color{2};
    p2 = plot(largeRwdBlock, LC_largeRwd,'linew',1.5);
    p2.Color = LC_color{3};
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:12); xticklabels(unique(block))
    title('Learning Curve for Small and Large Rewards','fontsize', 10)
    axis([0 (length(unique(block))+1) 40 105])
    hold off
    grid minor
    box on
    
    %% Gender Plots 
    
    % Performance par gender 
    figure('Name', 'Gender Plots');
    
    gender_fem = {perf_fem, rt_fem};
    gender_hom = {perf_hom, rt_hom};
    gender_labels ={'Performance','RTs'};
    gender_titles ={'Performance according to gender', 'RTs according to gender'};
    gender_axis = {[0 3 50 105], [0 3 0 2]};
    
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
    bar([DC_fem_rate 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 DC_hom_rate 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 CC_fem_rate 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 CC_hom_rate 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 BC_fem_rate 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 BC_hom_rate],'FaceColor',[0.30 0.45 0.30]);
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
