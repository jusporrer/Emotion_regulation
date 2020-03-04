%% Settings for the Emotional Rapid Serial Visual Presentation Task

% Number of trials per set size
rsvp.nTrialsTrain = 6; % expected : 12 -> 2/condi mixed
rsvp.nTrialsExp = 6; % expected : 24 -> 4/condi mixed 

% Number of blocks
rsvp.nBlocksTrain = 1; % expected : 1 
rsvp.nBlocksExp = 1; % expected : 8 

% Number of trialsbefore a break
rsvp.breakAfterTrials = 100;

% Number of images around the target
rsvp.setSize = 15;

% How long each image in the RSVP sequence is on screen(normally 100 ms so 0.1 s)
rsvp.imageDuration = 0.1;

% How long to wait (in seconds) for subject response before the trial times out
rsvp.trialTimeout = 20;

% How long to pause in between trials
rsvp.timeBetweenTrials = 2;

%% Create Response Matrix

respMatRSVP.cfg = [];
respMatRSVP.ID = 0; 
respMatRSVP.training = 0;
respMatRSVP.reward = 0; %(1 = Small reward, 2 = Large reward)
respMatRSVP.condition = 0; %(1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
respMatRSVP.block = 0; 
respMatRSVP.trial = 0; 
respMatRSVP.RTs = 0; 
respMatRSVP.response = 0; %(1 = left key / oui; 2 = right key / non)
respMatRSVP.posCritDist = 0; 
respMatRSVP.posTarget = 0; 
respMatRSVP.distractor = 0; 
respMatRSVP.target = 0; 
