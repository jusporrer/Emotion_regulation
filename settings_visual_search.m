
%% Settings for the Emotional Visual Search Task

% Length of fixation in seconds
fixationDuration = 0.5;

% Number of trials
nTrialsTrain = 1;
nTrialsExp = 1;

% Number of blocks
nBlocksTrain = 1;
nBlocksExp = 1;

% Number of stimuli ( needs to be < 12 and multiple of 4)
setSize = 8;
imgSetSize = setSize/4;

% Number of trials before a break
breakAfterTrials = 100;

% How long to wait (in seconds) for subject response before the trial times out
trialTimeout = 2;

% How long to pause in between trials
timeBetweenTrials = 2;

%% Create Response Matrix

% This is a X column matrix:
% 1st column: ID
% 2nd column: Training
% 3rd column: Reward (0 = Small reward, 1 = Large reward)
% 4th column: Condition (0 = DC, 1 = CC, 2 = BC)
% 5th column: Nb Block
% 6th column: Nb Trial
% 7th column: RTs
% 8th column: ResponseFF
% 9th column: ResponseNF
% 10th column: ResponseFM
% 11th column: ResponseNM

respMatColumnsVS = ["ID", "Training", "Reward", "Condition", ...
    "Nb Block","Nb Trial", "RTs", "ResponseFF", "ResponseNF", "ResponseFM", "ResponseNM"];

% the matrix is initialised after nTrial and nBlocks allocation in training
