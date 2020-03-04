% JS initial script analysis for the effect of inentives on emotion regulation
% February 2020

%function [] = Individual_Analysis_RSVP(ID)
clearvars;

ID = 10016; % 35923; 

%% Load the data (on an individual level)
resp_folder = '../results';

resp_rsvp = [num2str(ID),'_rsvp.mat'];

resp_file_rsvp = fullfile(resp_folder,resp_rsvp);

load(resp_file_rsvp,'data_rsvp');

if ~isfile(resp_file_rsvp)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% Initialise 

cfg_training = data_rsvp(2).cfg; % data_rsvp(1).cfg; for new 

nTrain = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain; 

training = [data_rsvp.training];

%(0 = training, 1 = Small reward, 2 = Large reward)
reward = [data_rsvp(nTrain+1:end).reward];

%(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
condition = [data_rsvp(nTrain+1:end).condition];

block = [data_rsvp(nTrain+1:end).block];
trial = [data_rsvp(nTrain+1:end).trial];

RTs = [data_rsvp(nTrain+1:end).RTs];

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

if length(trial) == cfg_training.nTrialsExp * cfg_training.nBlocksExp
    disp(['No data loss: There were ',num2str(length(trial)), ' trials']);
else 
    disp(['Problem: There were only ',num2str(length(trial)), ' trials. Out of the normal ', ...
        num2str(cfg_training.nTrialsExp * cfg_training.nBlocksExp), 'trial expected']);
end
 







%end 


