% JS initial individual analysis script for the effect of incentives on emotion regulation
% in the memory Task
% Creation : Mars 2020

function [mem]              = Individual_Analysis_Memory(ID, fig)

%ID                         = 4515; %74239 %12346 %90255 %81473 % 33222 % 56560 %72605 %11310 %9022 %81731 % 19279; %46700; 5034 ; %10016;
%fig                        = 1;

%% =================== Load the data                    ===================
resp_folder     = '../results';

resp_memory       = [num2str(ID),'_memory.mat'];

resp_file_memory  = fullfile(resp_folder,resp_memory);

load(resp_file_memory,'data_memory');

if ~isfile(resp_file_memory)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% =================== Initialise                       ===================

cfg_training                = data_memory(1).cfg;
nTrain                      = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp                     = data_memory(nTrain+1).cfg;
imageDuration               = [data_memory(nTrain+1:end).imgDur];
%(0 = training, 1 = Small reward, 2 = Large reward)
reward                      = [data_memory(nTrain+1:end).reward];
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition                   = [data_memory(nTrain+1:end).condition];
instCondit                  = [data_memory(nTrain+1:end).instCondit];
block                       = [data_memory(nTrain+1:end).block];
trial                       = [data_memory(nTrain+1:end).trial];
rt                          = [data_memory(nTrain+1:end).RTs];
% (1 = femKey/f; 2=hommeKey/h)
response                    = [data_memory(nTrain+1:end).response];
setSizeFF                   = [data_memory(nTrain+1:end).setSizeFF];
setSizeNF                   = [data_memory(nTrain+1:end).setSizeNF];
% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale)
setSizeFM                   = [data_memory(nTrain+1:end).setSizeFM];
setSizeNM                   = [data_memory(nTrain+1:end).setSizeNM];

%% =================== Basic Information                ===================

nTrial                      = 1:length(trial); % allows the indexing

if length(trial) == cfg_exp.nTrialsExp * cfg_exp.nBlocksExp
    disp(['No data loss : There were ',num2str(length(trial)), ' trials']);
else
    disp(['Problem : There were only ',num2str(length(trial)), ' trials out of the normal ', ...
        num2str(cfg_exp.nTrialsExp * cfg_exp.nBlocksExp), 'trial expected']);
end

%% =================== Exclude 3 STD RTs                ===================

rt                  = (rt(nTrial));
mean_RtExp          = mean(rt) ;
std_RtExp           = std(rt)*3 ;

% Recalculate nTrial with only non-outlier RT trials
low_RtExp           = mean_RtExp-std_RtExp ;
up_RtExp            = mean_RtExp+std_RtExp ;

kept_RtExp          = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp));
excl_RtExp          = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

mem.nExcTrial       = length(excl_RtExp); 

nTrial              = nTrial(kept_RtExp);
mem.rt              = log(rt(nTrial)); 
rt                  = log(rt(nTrial)); 
block               = block(nTrial);

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Correct Trials     ===================

correct_Fem                 = (response(nTrial) == 1 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));
% correct_fem = (response(nTrial) == 1 & (condition(nTrial)==2 | condition(nTrial)==4 | condition(nTrial)==6));

correct_Hom                 = (response(nTrial) == 2 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));

% Sum of all the correct trials
correct                     = correct_Fem + correct_Hom;
nCorrect                    = sum(correct);

% General performance
mem.performance             = nCorrect / length(nTrial)*100;

disp(['Performance : ',num2str(round(mem.performance)),'%']);

%% =================== Performance - Incorrect Trials   ===================

% Incorrectly not detect fem when fem was target ( false alarm: says present when not present)
incorrect_Fem               = (response(nTrial) == 2 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));

% Incorrectly not detect hom when hom was target
incorrect_Hom               = (response(nTrial) == 1 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));

% Sum of all the incorrect trials
incorrect                   = incorrect_Fem + incorrect_Hom;
nIncorrect                  = sum(incorrect);

% General performance
mem.perf_incorrect          = nIncorrect / length(nTrial)*100;

%% =================== Performance - Rewards            ===================

smallRwd                    = reward(nTrial) == 1;
mem.smallRwdBlock           = unique(block(smallRwd == 1));
smallRwd_correct            = correct & smallRwd;
smallRwd_incorrect          = incorrect & smallRwd;
mem.smallRwd_rate           = sum(smallRwd_correct)/sum(smallRwd)*100;

largeRwd                    = reward(nTrial) == 2;
mem.largeRwdBlock           = unique(block(largeRwd == 1));
largeRwd_correct            = correct & largeRwd;
largeRwd_incorrect          = incorrect & largeRwd;
mem.largeRwd_rate           = sum(largeRwd_correct)/sum(largeRwd)*100;

disp(['Reward : ',num2str(round(mem.smallRwd_rate)), '% were correct for small rwd & ', ...
    num2str(round(mem.largeRwd_rate)), '% were correct for large rwd' ]);

%% =================== Performance - Conditions         ===================
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)

% Detrimental condition
DC_condition                = condition(nTrial) == 1 | condition(nTrial) == 2;
DC_correct                  = correct & DC_condition;
DC_incorrect                = incorrect & DC_condition;
mem.DC_block                = unique(block(DC_condition));
DC_trials                   = zeros(1,length(nTrial));
for i = 1:length(mem.DC_block)
    DC_trials               = DC_trials + (block == mem.DC_block(i));
end 

DC_hom                      = condition(nTrial) == 1;
DC_hom_correct              = correct & DC_hom;
DC_hom_incorrect            = incorrect & DC_hom;
mem.DC_hom_rate             = sum(DC_hom_correct) / sum(DC_hom)*100;

DC_fem                      = condition(nTrial) == 2;
DC_fem_correct              = correct & DC_fem;
DC_fem_incorrect            = incorrect & DC_fem;
mem.DC_fem_rate             = sum(DC_fem_correct) / sum(DC_fem)*100;

% Beneficial Conditions
BC_condition                = condition(nTrial) == 5 | condition(nTrial) == 6;
BC_correct                  = correct & BC_condition;
BC_incorrect                = incorrect & BC_condition;
mem.BC_block                = unique(block(BC_condition));
BC_trials                   = zeros(1,length(nTrial));
for i = 1:length(mem.BC_block)
    BC_trials               = BC_trials + (block == mem.BC_block(i));
end 

BC_hom                      = condition(nTrial) == 5;
BC_hom_correct              = correct & BC_hom;
BC_hom_incorrect            = incorrect & BC_hom;
mem.BC_hom_rate             = sum(BC_hom_correct) / sum(BC_hom)*100;

BC_fem                      = condition(nTrial) == 6;
BC_fem_correct              = correct & BC_fem;
BC_fem_incorrect            = correct & BC_fem;
mem.BC_fem_rate             = sum(BC_fem_correct)/sum(BC_fem)*100;

% Control Conditions

CC_condition                = condition(nTrial) == 3 | condition(nTrial) == 4;
CC_correct                  = correct & CC_condition;
CC_incorrect                = incorrect & CC_condition;

CC_DC_condition             = DC_trials & CC_condition;
CC_DC_correct               = correct & CC_DC_condition;

CC_BC_condition             = BC_trials & CC_condition;
CC_BC_correct               = correct & CC_BC_condition;

CC_hom                      = condition(nTrial) == 3;
CC_hom_correct              = correct & CC_hom;
CC_hom_incorrect            = incorrect & CC_hom;
mem.CC_hom_rate             = sum(CC_hom_correct)/sum(CC_hom)*100;

CC_fem                      = condition(nTrial) == 4;
CC_fem_correct              = correct& CC_fem;
CC_fem_incorrect            = incorrect & CC_fem;
mem.CC_fem_rate             = sum(CC_fem_correct)/sum(CC_fem)*100;

% Number of trials in each conditions
if sum(DC_hom) == sum(DC_fem) == sum(CC_hom) == ...
        sum(CC_fem) == sum(BC_hom) ==  sum(BC_fem)
    disp(['All conditions have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), 'trials']);
else
    disp(['Warning, not all condition have ',num2str(cfg_exp.nTrialsExp*cfg_exp.nBlocksExp/6), ' trials']);
end

% Condition Emotions
mem.perf_DC                 = sum(DC_correct)/sum(DC_condition)*100;  
mem.perf_BC                 = sum(BC_correct)/sum(BC_condition)*100; 
mem.perf_CC_DC              = sum(CC_DC_correct)/sum(CC_DC_condition)*100; 
mem.perf_CC_BC              = sum(CC_BC_correct)/sum(CC_BC_condition)*100; 
mem.perf_CC                 = sum(CC_correct)/sum(CC_condition)*100;

disp(['Performance Emotion : ',num2str(round(mem.perf_DC)), '% for detrimental condition, ', ...
    num2str(round(mem.perf_CC)), '% for control condition & ',num2str(round(mem.perf_BC)), '% for beneficial condition']);

%% =================== Performance - Gender             ===================
% Condition Gender

fem_condition               = condition(nTrial) == 2 | condition(nTrial) == 4 | condition(nTrial) == 6;
fem_correct                 = correct & fem_condition;
fem_incorrect               = incorrect & fem_condition;

hom_condition               = condition(nTrial) == 1 | condition(nTrial) == 3 | condition(nTrial) == 5;
hom_correct                 = correct & hom_condition;
hom_incorrect               = incorrect & hom_condition;

mem.perf_fem                = sum(fem_correct)/sum(fem_condition)*100; 
mem.perf_hom                = sum(hom_correct)/sum(hom_condition)*100; 

disp(['Performance Gender: ',num2str(round(mem.perf_fem)), '% for condition femme & ', ...
    num2str(round(mem.perf_hom)), '% for condition homme ']);

%% =================== Performance - Conditions & Rewards===================

mem.perf_DC_smallRwd       = sum(DC_correct & smallRwd) / sum(DC_condition & smallRwd) * 100 ;
mem.perf_DC_largeRwd       = sum(DC_correct & largeRwd) / sum(DC_condition & largeRwd) * 100 ;

mem.perf_CC_DC_smallRwd    = sum(CC_DC_correct & smallRwd) / sum(CC_DC_condition & smallRwd) * 100 ;
mem.perf_CC_DC_largeRwd    = sum(CC_DC_correct & largeRwd) / sum(CC_DC_condition & largeRwd) * 100 ;

mem.perf_CC_smallRwd       = sum(CC_correct & smallRwd) / sum(CC_condition & smallRwd) * 100 ;
mem.perf_CC_largeRwd       = sum(CC_correct & largeRwd) / sum(CC_condition & largeRwd) * 100 ;

mem.perf_CC_BC_smallRwd    = sum(CC_BC_correct & smallRwd) / sum(CC_BC_condition & smallRwd) * 100 ;
mem.perf_CC_BC_largeRwd    = sum(CC_BC_correct & largeRwd) / sum(CC_BC_condition & largeRwd) * 100 ;

mem.perf_BC_smallRwd       = sum(BC_correct & smallRwd) / sum(BC_condition & smallRwd) * 100;
mem.perf_BC_largeRwd       = sum(BC_correct & largeRwd) / sum(BC_condition & largeRwd) * 100 ;

%% =================== Performance - Gender & Rewards   ===================

% Females / Femmes 
mem.perf_fem_smallRwd      = sum(fem_correct & smallRwd) / sum(fem_condition & smallRwd) * 100 ;
mem.perf_fem_largeRwd      = sum(fem_correct & largeRwd) / sum(fem_condition & largeRwd) * 100 ;

mem.perf_CC_fem_smallRwd   = sum(CC_fem_correct & smallRwd) / sum(CC_fem & smallRwd) * 100 ;
mem.perf_CC_fem_largeRwd   = sum(CC_fem_correct & largeRwd) / sum(CC_fem & largeRwd) * 100 ;

mem.perf_DC_fem_smallRwd   = sum(DC_fem_correct & smallRwd) / sum(DC_fem & smallRwd) * 100 ;
mem.perf_DC_fem_largeRwd   = sum(DC_fem_correct & largeRwd) / sum(DC_fem & largeRwd) * 100 ;

mem.perf_BC_fem_smallRwd   = sum(BC_fem_correct & smallRwd) / sum(BC_fem & smallRwd) * 100 ;
mem.perf_BC_fem_largeRwd   = sum(BC_fem_correct & largeRwd) / sum(BC_fem & largeRwd) * 100 ;

% Males / Hommes 
mem.perf_hom_smallRwd      = sum(hom_correct & smallRwd) / sum(hom_condition & smallRwd) * 100;
mem.perf_hom_largeRwd      = sum(hom_correct & largeRwd) / sum(hom_condition & largeRwd) * 100;

mem.perf_DC_hom_smallRwd   = sum(DC_hom_correct & smallRwd) / sum(DC_hom & smallRwd) * 100 ;
mem.perf_DC_hom_largeRwd   = sum(DC_hom_correct & largeRwd) / sum(DC_hom & largeRwd) * 100 ;

mem.perf_CC_hom_smallRwd   = sum(CC_hom_correct & smallRwd) / sum(CC_hom & smallRwd) * 100 ;
mem.perf_CC_hom_largeRwd   = sum(CC_hom_correct & largeRwd) / sum(CC_hom & largeRwd) * 100 ;

mem.perf_BC_hom_smallRwd   = sum(BC_hom_correct & smallRwd) / sum(BC_hom & smallRwd) * 100 ;
mem.perf_BC_hom_largeRwd   = sum(BC_hom_correct & largeRwd) / sum(BC_hom & largeRwd) * 100 ;

%% =================== Performance - Img Duration       ===================

imgShort                        = imageDuration(nTrial) == 1.5;
mem.nimgShort                   = sum(imgShort);
correct_imgShort                = correct & imgShort;
mem.imgShort_rate               = sum(correct_imgShort)/mem.nimgShort*100;

imgLong                         = imageDuration(nTrial) == 2;
mem.nimgLong                    = sum(imgLong);
correct_imgLong                 = correct & imgLong;
mem.imgLong_rate                = sum(correct_imgLong)/mem.nimgLong*100;

disp(['Performance Img Duration : ',num2str(round(mem.imgShort_rate)), '% were correct after 1.5s & ', ...
    num2str(round(mem.imgLong_rate)), '% were correct after 2s' ]);

%% =================== RTs - Correct & Incorrect Trials ===================

mem.rt_correct                  = mean(rt(correct == 1));

mem.rt_incorrect                = mean(rt(incorrect == 1));

disp(['RTs correct : ',num2str(mem.rt_correct), ' s for correct trials ']);

disp(['RTs incorrect : ',num2str(mem.rt_incorrect), ' s for incorrect trials ']);

%% =================== RTs - Rewards                    ===================

mem.rt_smallRwd                 = mean(rt(smallRwd));
mem.rt_smallRwd_correct         = mean(rt(smallRwd_correct));
mem.rt_smallRwd_incorrect       = mean(rt(smallRwd_incorrect));

mem.rt_largeRwd                 = mean(rt(largeRwd));
mem.rt_largeRwd_correct         = mean(rt(largeRwd_correct));
mem.rt_largeRwd_incorrect       = mean(rt(largeRwd_incorrect));

disp(['RTs reward : ',num2str(mem.rt_smallRwd), ' s for small rewards & ', ...
    num2str(mem.rt_largeRwd), ' s for large rewards ']);

%% =================== RTs - Conditions                 ===================

% Detrimental condition
mem.rt_DC                       = mean(rt(DC_condition));
mem.rt_DC_correct               = mean(rt(DC_correct));
mem.rt_DC_incorrect             = mean(rt(DC_incorrect));

mem.rt_DC_hom                   = mean(rt(DC_hom));
mem.rt_DC_hom_correct           = mean(rt(DC_hom_correct));
mem.rt_DC_hom_incorrect         = mean(rt(DC_hom_incorrect));

mem.rt_DC_fem                   = mean(rt(DC_fem));
mem.rt_DC_fem_correct           = mean(rt(DC_fem_correct));
mem.rt_DC_fem_incorrect         = mean(rt(DC_fem_incorrect));

% Control Condition
mem.rt_CC                       = mean(rt(CC_condition));
mem.rt_CC_correct               = mean(rt(CC_correct));
mem.rt_CC_incorrect             = mean(rt(CC_incorrect));

mem.rt_CC_hom                   = mean(rt(CC_hom));
mem.rt_CC_hom_correct           = mean(rt(CC_hom_correct));
mem.rt_CC_hom_incorrect         = mean(rt(CC_hom_incorrect));

mem.rt_CC_fem                   = mean(rt(CC_fem));
mem.rt_CC_fem_correct           = mean(rt(CC_fem_correct));
mem.rt_CC_fem_incorrect         = mean(rt(CC_fem_incorrect));

% Benefitial Condition
mem.rt_BC                       = mean(rt(BC_condition));
mem.rt_BC_correct               = mean(rt(BC_correct));
mem.rt_BC_incorrect             = mean(rt(BC_incorrect));

mem.rt_BC_hom                   = mean(rt(BC_hom));
mem.rt_BC_hom_correct           = mean(rt(BC_hom_correct));
mem.rt_BC_hom_incorrect         = mean(rt(BC_hom_incorrect));

mem.rt_BC_fem                   = mean(rt(BC_fem));
mem.rt_BC_fem_correct           = mean(rt(BC_fem_correct));
mem.rt_BC_fem_incorrect         = mean(rt(BC_fem_incorrect));


disp(['RTs Emotion : ',num2str(mem.rt_DC), ' s for detrimental condition, ', ...
    num2str(mem.rt_CC), ' s for control condition & ',num2str(mem.rt_BC), ' s for beneficial condition']);

%% =================== RTs - Gender                     ===================
mem.rt_fem                      = mean(rt(fem_condition));
mem.rt_fem_correct              = mean(rt(fem_correct));
mem.rt_fem_incorrect            = mean(rt(fem_incorrect));

mem.rt_hom                      = mean(rt(hom_condition));
mem.rt_hom_correct              = mean(rt(hom_correct));
mem.rt_hom_incorrect            = mean(rt(hom_incorrect));

disp(['RTs Gender: ',num2str(mem.rt_fem), ' s for condition femme & ', ...
    num2str(mem.rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions & Rewards       ===================

mem.rt_DC_smallRwd              = mean(rt(smallRwd & DC_condition));
mem.rt_DC_largeRwd              = mean(rt(largeRwd & DC_condition));

mem.rt_CC_smallRwd              = mean(rt(smallRwd & CC_condition));
mem.rt_CC_largeRwd              = mean(rt(largeRwd & CC_condition));

mem.rt_BC_smallRwd              = mean(rt(smallRwd & BC_condition));
mem.rt_BC_largeRwd              = mean(rt(largeRwd & BC_condition));

%% =================== RTs - Gender & Rewards           ===================

mem.rt_fem_smallRwd             = mean(rt(smallRwd & fem_condition));
mem.rt_fem_largeRwd             = mean(rt(largeRwd & fem_condition));

mem.rt_hom_smallRwd             = mean(rt(smallRwd & hom_condition));
mem.rt_hom_largeRwd             = mean(rt(largeRwd & hom_condition));

%% =================== RTs - Link To Performance        ===================

mem.rt_median                   = median(rt); 

rt_slow                         = find(rt > mem.rt_median); 
mem.rt_slow_perf                = sum(correct(rt_slow))/length(rt_slow)*100;
rt_fast                         = find(rt < mem.rt_median);
mem.rt_fast_perf                = sum(correct(rt_fast))/length(rt_fast)*100;

%% =================== Learning Curve                   ===================

mem.LC                          = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC)
    mem.LC(i)                   = (sum(correct(block == i)))/(length(nTrial(block == i)))*100;
end

mem.LC_smallRwd                 = zeros(1,length(mem.smallRwdBlock));
for i = 1:length(mem.smallRwdBlock)
     mem.LC_smallRwd(i)         = (sum(correct(block == mem.smallRwdBlock(i))))/sum(smallRwd(block == mem.smallRwdBlock(i)))*100;
end

mem.LC_largeRwd                 = zeros(1,length(mem.largeRwdBlock));
for i = 1:length(mem.largeRwdBlock)
    mem.LC_largeRwd(i)          = (sum(correct(block == mem.largeRwdBlock(i))))/sum(largeRwd(block == mem.largeRwdBlock(i)))*100;
end

mem.LC_DC                       = zeros(1,length(mem.DC_block));
for i = 1:length(mem.DC_block)
     mem.LC_DC(i)               = (sum(DC_correct(block == mem.DC_block(i))))/ sum(DC_condition(block == mem.DC_block(i)))*100;
end

mem.LC_BC                       = zeros(1,length(mem.BC_block));
for i = 1:length(mem.BC_block)
     mem.LC_BC(i)               = (sum(BC_correct(block == mem.BC_block(i))))/ sum(BC_condition(block == mem.BC_block(i)))*100;
end

mem.LC_CC                       = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC_CC)
     mem.LC_CC(i)               = (sum(CC_correct(block == i)))/ sum(CC_condition(block == i))*100;
end 

%% =================== RTs Curves                       ===================

mem.RTsC                        = zeros(1,cfg_exp.nBlocksExp);
for i = 1:cfg_exp.nBlocksExp
    mem.RTsC(i)                 = mean(rt(block == i));
end

mem.RTsC_smallRwd               = zeros(1,length(mem.smallRwdBlock));
for i = 1:length(mem.smallRwdBlock)
     mem.RTsC_smallRwd(i)       = mean(rt(block == mem.smallRwdBlock(i)));
end

mem.RTsC_largeRwd               = zeros(1,length(mem.largeRwdBlock));
for i = 1:length(mem.largeRwdBlock)
    mem.RTsC_largeRwd(i)        = mean(rt(block == mem.largeRwdBlock(i)));
end

mem.RTsC_DC                     = zeros(1,length(mem.DC_block));
for i = 1:length(mem.DC_block)
     mem.RTsC_DC(i)             = mean(rt(block == mem.DC_block(i) & DC_condition == 1 ));
     % add the conditions as we do not want the CC trials 
end

mem.RTsC_BC                     = zeros(1,length(mem.BC_block));
for i = 1:length(mem.BC_block)
     mem.RTsC_BC(i) = mean(rt(block == mem.BC_block(i) & BC_condition == 1 ));
end

mem.RTsC_CC                     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.RTsC_CC)
     mem.RTsC_CC(i) = mean(rt(block == i & CC_condition == 1 ));
end
     
%% =================== PLOT PART                        ===================
if fig
    
    %% Performance Plots
    % Performance par conditions
    figure('Name', ['Performance Plots for pilot n°',num2str(ID)]);
    subplot(2,2,1)
    hold on;
    bar(1, mem.perf_DC,'FaceColor',[.55 .25 .35])
    b1 = bar((2-.8/3), mem.perf_CC_DC,'FaceColor',[.85 .75 .75], 'BarWidth',.8/3);
    b2 = bar((2), mem.perf_CC,'FaceColor',[.75 .75 .75], 'BarWidth',.8/3);
    b3 = bar((2+.8/3), mem.perf_CC_BC, 'FaceColor',[.75 .85 .75], 'BarWidth',.8/3);
    bar(3, mem.perf_BC,'FaceColor',[.40 .55 .40])
    xticks([1 2 3 4])
    xticklabels({'DC','CC','BC'})
    legend([b1 b2 b3],{'CC (DC)','CC', 'CC (BC)'},'fontsize', 6, 'location','northeast')
    ylabel('Performance (mean %)','fontsize', 10)
    title('Performance according to conditions','fontsize', 10)
    axis([0 4 50 100])
    grid minor
    box on
    hold off
    
    % Performance par rewards
    subplot(2,2,2)
    hold on;
    bar([mem.smallRwd_rate 0],'FaceColor',[.45, .75, .80]);
    bar([0 mem.largeRwd_rate],'FaceColor',[.00, .45, .55]);
    xticks([1 2])
    xticklabels({'Small Reward','Large Reward'})
    ylabel('Performance','fontsize', 10)
    title('Performance According to Reward','fontsize', 10)
    axis([0 3 50 100])
    grid minor
    box on
    hold off
    
    % Performance par conditions & rewards
    subplot(2,2,3)
    hold on;
    bar(1, mem.perf_DC_smallRwd,'FaceColor',[.65 .35 .45], 'BarWidth',.5)
    bar(1.5-.5/3, mem.perf_CC_DC_smallRwd,'FaceColor',[.95 .85 .85], 'BarWidth',.5/3)
    bar(1.5, mem.perf_CC_smallRwd,'FaceColor',[.85 .85 .85], 'BarWidth',.5/3)
    bar(1.5+.5/3, mem.perf_CC_BC_smallRwd,'FaceColor',[.85 .95 .85], 'BarWidth',.5/3)
    bar(2, mem.perf_BC_smallRwd,'FaceColor',[.50 .65 .50], 'BarWidth',.5)
    bar(3, mem.perf_DC_largeRwd,'FaceColor',[.45 .15 .25], 'BarWidth',.5)
    bar(3.5-.5/3, mem.perf_CC_DC_largeRwd,'FaceColor',[.75 .65 .65], 'BarWidth',.5/3)
    bar(3.5, mem.perf_CC_largeRwd,'FaceColor',[.65 .65 .65], 'BarWidth',.5/3)
    bar(3.5+.5/3, mem.perf_CC_BC_largeRwd,'FaceColor',[.65 .75 .65], 'BarWidth',.5/3)
    bar(4, mem.perf_BC_largeRwd,'FaceColor',[.30 .45 .30], 'BarWidth',.5)
    xticks([1.5 3.5])
    xticklabels({'Small Rwd', 'Large Rwd'})
    legend({'DC','CC (DC)','CC', 'CC (BC)', 'BC'}, 'fontsize', 6 , 'Location', 'northeast','NumColumns',2)
    ylabel('Performance','fontsize', 10)
    title(['Performance Plots for Pilot n°',num2str(ID)],'fontsize', 10)
    axis([0 5 40 100])
    grid minor
    box on
    hold off
    
    % Title of the whole plot 
    sgtitle(['Performance Plots for Pilot n°',num2str(ID)])
    
    %% RTs Plots
    % RTs par conditions
    figure('Name', 'RTs Plots');
    subplot(2,2,1)
    hold on;
    bar([mem.rt_DC 0 0],'FaceColor',[.55 .25 .35]);
    bar([0 mem.rt_CC 0],'FaceColor',[.75 .75 .75]);
    bar([0 0 mem.rt_BC],'FaceColor',[.40 .55 .40]);
    xticks([1 2 3 4])
    xticklabels({'DC','CC', 'BC'})
    ylabel('RTs','fontsize', 10)
    title('RTs according to conditions','fontsize', 10)
    axis([0 4 -1 1])
    grid minor
    box on
    hold off
    
    % RTs par rewards
    subplot(2,2,2)
    hold on;
    bar([mem.rt_smallRwd 0],'FaceColor',[.45, .75, .80]);
    bar([0 mem.rt_largeRwd],'FaceColor',[.00, .45, .55]);
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
    bar([mem.rt_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
    bar([0 mem.rt_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
    bar([0 0 mem.rt_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
    bar([0 0 0 mem.rt_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
    bar([0 0 0 0 mem.rt_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
    bar([0 0 0 0 0 mem.rt_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
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
    p = plot(1:(length(mem.LC)), mem.LC,'linew',1.5);
    p.Color = [0 0 0];
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (Mean)','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:(length(mem.LC)))
    xticklabels(unique(block))
    title('Learning Curve Experiment','fontsize', 10)
    axis([0 (length(mem.LC)+1) 40 105])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p1 = plot(mem.smallRwdBlock, mem.LC_smallRwd,'-x','linew',1.5);
    p1.Color = [0.75, 0.85, 0.90];
    p2 = plot(mem.largeRwdBlock, mem.LC_largeRwd,'-o','linew',1.5);
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
    p1 = plot(mem.DC_block, mem.LC_DC,'-x','linew',1.5);
    p1.Color = [.75 .45 .55];
    p2 = plot(unique(block), mem.LC_CC,'-+','linew',1.5);
    p2.Color = [.5 .5 .5];
    p3 = plot(mem.BC_block, mem.LC_BC,'-o','linew',1.5);
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
    
    %% Gender Plots
    
    % Performance par gender
%     figure('Name', 'Gender Plots');
%     
%     gender_fem = {mem.perf_fem, mem.rt_fem};
%     gender_hom = {mem.perf_hom, mem.rt_hom};
%     gender_labels ={'Performance','RTs'};
%     gender_titles ={'Performance according to gender', 'RTs according to gender'};
%     gender_axis = {[0 3 40 100], [0 3 0 2]};
%     
%     for i = 1:2
%         subplot(2,2,i)
%         hold on;
%         bar([gender_fem{i} 0],'FaceColor',[0.85 0.55 0.65]);
%         bar([0 gender_hom{i}],'FaceColor',[0.45, 0.60, 0.70]);
%         xticks([1 2])
%         xticklabels({'Female','Male'})
%         ylabel(gender_labels{i},'fontsize', 10)
%         title(gender_titles{i},'fontsize', 10)
%         axis(gender_axis{i})
%         grid minor
%         box on
%         hold off
%     end
%     
%     % Performance par genre & conditions
%     subplot(2,1,2)
%     hold on;
%     bar([mem.DC_fem_rate 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
%     bar([0 mem.DC_hom_rate 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
%     bar([0 0 mem.CC_fem_rate 0 0 0],'FaceColor',[0.85 0.85 0.85]);
%     bar([0 0 0 mem.CC_hom_rate 0 0],'FaceColor',[0.65 0.65 0.65]);
%     bar([0 0 0 0 mem.BC_fem_rate 0],'FaceColor',[0.50 0.65 0.50]);
%     bar([0 0 0 0 0 mem.BC_hom_rate],'FaceColor',[0.30 0.45 0.30]);
%     xticks([1 2 3 4 5 6])
%     xticklabels({'DC Fem','DC Hom','CC Fem','CC Hom','BC Fem','BC Hom'})
%     ylabel('Performance','fontsize', 10)
%     title('Performance according to gender & conditions','fontsize', 10)
%     axis([0 7 40 100])
%     grid minor
%     box on
%     hold off
end


end

