%% Settings for the memory Task

% Number of trials per set size
memCfg.nTrialsTrain         = 3; % expected : 3*4 -> 2/condi mixed
memCfg.nTrialsExp           = 15; % expected : 15 -> 5/condi mixed  // min = 3 

% Number of blocks
memCfg.nBlocksTrain         = 4; % expected : 4*3 -> 2/condi mixed
memCfg.nBlocksExp           = 12; % expected : 20/25 // min = 4 (multiple de 4)

% Number of images around the target
memCfg.setSize              = 20;

% Probabilities 
memCfg.fearfulCC            = 0.6; 
memCfg.neutralCC            = 0.6; 

memCfg.fearfulBC            = 0.8; 
memCfg.neutralBC            = 0.4; 

memCfg.fearfulDC            = 0.4; 
memCfg.neutralDC            = 0.8; 

% How long each image in the memory sequence is on screen (normally 2 s)
memCfg.imageDuration        = [1.5, 2];

% Length of fixation in seconds
memCfg.fixationDuration     = 0.5;

% How long to wait (in seconds) for subject response before the trial times out
memCfg.trialTimeout         = 20;

% How long to pause in between trials
memCfg.timeBetweenTrials    = 2;

%% Create Response Matrix

respMatMemory.cfg           = [];
respMatMemory.ID            = 0; 
respMatMemory.training      = 0; %(1 = training, 0 = no training)
respMatMemory.reward        = 0; %(0 = training, 1 = Small reward, 2 = Large reward)
respMatMemory.condition     = 0; %(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
respMatMemory.instCondit    = 0;
respMatMemory.block         = 0; 
respMatMemory.trial         = 0; 
respMatMemory.RTs           = 0; 
respMatMemory.response      = 0; % (1 = femKey/f; 2=hommeKey/h)
respMatMemory.setSizeFF     = 0;
respMatMemory.setSizeNF     = 0;
respMatMemory.setSizeFM     = 0;
respMatMemory.setSizeNM     = 0;
