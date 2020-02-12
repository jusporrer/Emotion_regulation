%% Settings for the Emotional Rapid Serial Visual Presentation Task

% Size of the images
size_img_rsvp = 600;

% Scrambled matrix of input image, [nSection+1 by nSection+1]
nSection = 4;

% Number of trials per set size
nTrialsTrain = 1;
nTrialsExp = 1;

% Number of blocks
nBlocksTrain = 1;
nBlocksExp = 1;

% Number of trialsbefore a break
breakAfterTrials = 100;

% Number of images around the target
setSize = 15;

% How long each image in the RSVP sequence is on screen(normally 100 ms so 0.1 s)
imageDuration = 0.1;

% How long to wait (in seconds) for subject response before the trial times out
trialTimeout = 2;

% How long to pause in between trials
timeBetweenTrials = 2;

%% Create Response Matrix

% This is a X column matrix:
% 1st column: ID
% 2nd column: Training
% 3rd column: Reward (0 = Small reward, Large reward)
% 4th column: Condition (1 = DC_male, 2 = DC_female, 3 = CC_male, 4 =
% CC_female, 5 = BC_male , 6 = BC_female)
% 5th column: Nb Trial
% 6th column: Nb Block
% 7th column: RTs
% 8th column: Response
% 9th column: posCritDist (critical distractor position between 4 & 8)
% 10th column: posTarget (target either 2 or 4 position after posCritDist)
% 11th column: distractor;
% 12th column: target;

respMatColumnsRSVP = ["ID", "Training","Reward","Condition", "Nb Trial", "Nb Block", ...
    "RTs", "Response", "posCritDist", "posTarget","distractor","target"];
