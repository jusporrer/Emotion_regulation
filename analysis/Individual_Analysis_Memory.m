% JS initial script analysis for the effect of incentives on emotion regulation 
% in a memory Task
% Creation : Mars 2020

%function []    = Individual_Analysis_Memory(ID, fig)
clearvars;

ID              = 5034 ; %10016;
fig             = 1;

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

cfg_training    = data_memory(1).cfg;
nTrain          = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp         = data_memory(nTrain+1).cfg;
%(0 = training, 1 = Small reward, 2 = Large reward)
reward          = [data_memory(nTrain+1:end).reward];
%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition       = [data_memory(nTrain+1:end).condition];
block           = [data_memory(nTrain+1:end).block];
trial           = [data_memory(nTrain+1:end).trial];
rt              = [data_memory(nTrain+1:end).RTs];
% (1 = femKey/f; 2=hommeKey/h)
response        = [data_memory(nTrain+1:end).response];
setSizeFF       = [data_memory(nTrain+1:end).setSizeFF];
setSizeNF       = [data_memory(nTrain+1:end).setSizeNF];
% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale)
setSizeFM       = [data_memory(nTrain+1:end).setSizeFM];
setSizeNM       = [data_memory(nTrain+1:end).setSizeNM];

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

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Correct Trials     ===================

% Correctly detect fem when fem was main 
correct_fem     = (response(nTrial) == 1 & (condition(nTrial) == 2 | ...                  
    condition(nTrial) == 4 | condition(nTrial) == 6));

correct_hom     = (response(nTrial) == 2 & (condition(nTrial) == 1 | ...                  
    condition(nTrial) == 3 | condition(nTrial) == 5));

% Sum of all the correct trials
correct         = (correct_fem) + (correct_hom); 
nCorrect        = sum(correct);

% General performance
performance     = nCorrect/length(nTrial)*100;

disp(['Performance : ',num2str(ceil(performance)),'%']);


% end % end of fuction
