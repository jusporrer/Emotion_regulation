% JS initial script analysis for the effect of inentives on emotion regulation
% February 2020

%function [] = Individual_Analysis_RSVP(ID)
clearvars;

ID = 35923; % 10016;

%% Load the data (on an individual level)
resp_folder = '../results';

resp_rsvp = [num2str(ID),'_rsvp.mat'];

resp_file_rsvp = fullfile(resp_folder,resp_rsvp);

load(resp_file_rsvp,'data_rsvp');

if ID == 35923
    data_rsvp(1) = [];
    data_rsvp(13) = [];
end 

if ~isfile(resp_file_rsvp)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% Initialise 

cfg_training = data_rsvp(1).cfg;

nTrain = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain; 

cfg_exp = data_rsvp(nTrain+1).cfg;

%(0 = training, 1 = Small reward, 2 = Large reward)
reward = [data_rsvp(nTrain+1:end).reward];

%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition = [data_rsvp(nTrain+1:end).condition];

block = [data_rsvp(nTrain+1:end).block];
trial = [data_rsvp(nTrain+1:end).trial];

rt = [data_rsvp(nTrain+1:end).RTs];

% (1 = femquest, 2 = homquest) 
instr = [data_rsvp(nTrain+1:end).instr];

% (1 = [o] / oui; 2 = [n] / non)
response = [data_rsvp(nTrain+1:end).response];

posCritDist = [data_rsvp(nTrain+1:end).posCritDist];
posTarget = [data_rsvp(nTrain+1:end).posTarget];

% 1 = fearFem, 2 = fearMale, 3 = neutralFem, 4 = neutralMale) 
distractor = [data_rsvp(nTrain+1:end).distractor];
target = [data_rsvp(nTrain+1:end).target];

%% Basic information 

nTrial = 1:length(trial); % allows the indexing 

if length(trial) == cfg_exp.nTrialsExp * cfg_exp.nBlocksExp
    disp(['No data loss : There were ',num2str(length(trial)), ' trials.']);
else 
    disp(['Problem : There were only ',num2str(length(trial)), ' trials. Out of the normal ', ...
        num2str(cfg_exp.nTrialsExp * cfg_exp.nBlocksExp), 'trial expected.']);
end
 
%% Reaction Time 

rtExp     = rt(nTrial);  
mean_RtExp = mean(rtExp) ;
std_RtExp  = std(rtExp)*3 ;

% Recalculate nTrial with only non-outlier RT trials:
low_RtExp = mean_RtExp-std_RtExp ;
up_RtExp = mean_RtExp+std_RtExp ;

kept_RtExp = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp)); 
excl_RtExp = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

nTrial = nTrial(kept_RtExp); 

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% Performance (struct prf) 

% Correctly identify fem when fem was target 
correct_Fem = (response(nTrial) == 1 & instr(nTrial) == 1 ...               % all fem targets
    & (target(nTrial) == 1 | target(nTrial) == 3));
correct_FearFem = (response(nTrial) == 1 & instr(nTrial) == 1 ...           % fearful fem targets 
    & target(nTrial) == 1);
correct_NeutralFem = (response(nTrial) == 1 & instr(nTrial) == 1 ...        % neutral fem targets 
    & target(nTrial) == 3);

% Correctly identify hom when hom was target 
correct_Hom = (response(nTrial) == 1 & instr(nTrial) == 2 ...               % all hom targets 
    & (target(nTrial) == 2 | target(nTrial) == 4));
correct_FearHom = (response(nTrial) == 1 & instr(nTrial) == 2 ...           % fearful hom targets 
    & target(nTrial) == 2);
correct_NeutralHom = (response(nTrial) == 1 & instr(nTrial) == 2 ...        % neutral hom taregts 
    & target(nTrial) == 4);

% Correctly reject fem when hom was target 
correct_NotFem = (response(nTrial) == 2 & instr(nTrial) == 1 ...
    & (target(nTrial) == 2 | target(nTrial) == 4));
correct_NotFem_FearHom = (response(nTrial) == 2 & instr(nTrial) == 1 ...
    & target(nTrial) == 2);
correct_NotFem_NeutralHom = (response(nTrial) == 2 & instr(nTrial) == 1 ...
    & target(nTrial) == 4);

% Correctly reject hom when fem was target 
correct_NotHom = (response(nTrial) == 2 & instr(nTrial) == 2 ...
    & (target(nTrial) == 1 | target(nTrial) == 3));
correct_NotHom_FearFem = (response(nTrial) == 2 & instr(nTrial) == 2 ...
    & target(nTrial) == 1);
correct_NotHom_NeutralFem = (response(nTrial) == 2 & instr(nTrial) == 2 ...
    & target(nTrial) == 3);

% Sum of all the correct trials 
correct         = (correct_Fem) + (correct_Hom) + (correct_NotFem) + (correct_NotHom);
nCorrect        = sum(correct);

% SDT: correct hit 
hit_correct     = (correct_Fem) + (correct_Hom); 
hit_rate        = (sum(hit_correct)/nCorrect)*100; 

% SDT: correct rejection
reject_correct  = (correct_NotFem) + (correct_NotHom); 
reject_rate     = (sum(reject_correct)/nCorrect)*100; 

% Performance 
performance     = nCorrect/length(nTrial)*100;
disp(['Performance : ',num2str(ceil(performance)), ...
        ' % correct trials with ',num2str(ceil(hit_rate)), '% hits and ', ...
        num2str(ceil(reject_rate)), '% rejections. ' ]);


%% Effect of reward on performance 

smallRwd        = reward == 1; 
correct_smallRwd = correct(1:length(nTrial)) == 1 & smallRwd(1:length(nTrial)) == 1; 
smallRwd_rate   = sum(correct_smallRwd)/sum(smallRwd)*100; 

largeRwd        = reward == 2;
correct_largeRwd = correct(1:length(nTrial)) == 1 & largeRwd(1:length(nTrial)) == 1;
largeRwd_rate   = sum(correct_largeRwd)/sum(largeRwd)*100; 

disp(['Performance : ',num2str(ceil(smallRwd_rate)), '% were correct for small rwd and ', ...
        num2str(ceil(largeRwd_rate)), '% were correct for large rwd. ' ]);

    
%% Size of the elapse (lap 2 = 200 ms, lap 4 = 400 ms) 

lap             = posTarget-posCritDist; 

lap2            = lap(nTrial) == 2; 
nLap2           = sum(lap2);
correct_lap2    = correct(1:length(nTrial)) == 1 & lap2(1:length(nTrial)) == 1; 
lap2_rate       = sum(correct_lap2)/nCorrect*100; 

lap4            = lap(nTrial) == 4; 
nLap4           = sum(lap4);
correct_lap4    = correct(1:length(nTrial)) == 1 & lap4(1:length(nTrial)) == 1; 
lap4_rate       = sum(correct_lap4)/nCorrect*100; 

disp(['In the correct trials, ',num2str(ceil(lap2_rate)), '% were correct after a lag 2 and ', ...
        num2str(ceil(lap4_rate)), '% were correct after a lag 4. ' ]);

    
    
    
    
    
%end 


