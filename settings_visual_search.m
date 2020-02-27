
%% Settings for the Emotional Visual Search Task

% Length of fixation in seconds
vs.fixationDuration = 0.5;

% Number of trials
vs.nTrialsTrain = 5;
vs.nTrialsExp = 2;

% Number of blocks
vs.nBlocksTrain = 1;
vs.nBlocksExp = 6;

% Number of stimuli ( needs to be < 12 and multiple of 4)
vs.setSize = 8;
vs.imgSetSize = vs.setSize/4;

% Number of trials before a break
vs.breakAfterTrials = 100;

% How long to wait (in seconds) for subject response before the trial times out
vs.trialTimeout = 20;

% How long to pause in between trials
vs.timeBetwTrial = 2;

%% Create Response Matrix

respMatVS.ID = 0; 
respMatVS.training = 0;
respMatVS.reward = 0; %(1 = Small reward, 2 = Large reward)
respMatVS.condition = 0; %(0 = DC, 1 = CC, 2 = BC)
respMatVS.block = 0; 
respMatVS.trial = 0; 
respMatVS.RTs = 0; 
respMatVS.order = []; 
respMatVS.respFF = 0; 
respMatVS.respNF = 0; 
respMatVS.respFM = 0; 
respMatVS.respNM = 0; 
respMatVS.posFF = [];
respMatVS.posNF = [];
respMatVS.posFM = [];
respMatVS.posNM = [];
