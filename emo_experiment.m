
try
    %% Initialise screen
    Screen('Preference', 'SkipSyncTests', 1) % Need to be put to 0 when testing
    Screen('Preference', 'SuppressAllWarnings', 1) % supress warning screen
    Screen('Preference','VisualDebugLevel', 0);  % supress start screen
    
    HideCursor;
    
    %Initialise the workspace
    sca;
    close all;
    clearvars;
    
    %default settings for setting up Psychtoolbox
    PsychDefaultSetup(2);
    
    % Get the screen numbers.
    screens = Screen('Screens');
    screenNumber = max(screens);
    
    % Define black and white
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);
    grey = white / 2;
    colors = [white, black, grey];
    
    % Open screen window using PsychImaging and color it white.
    [window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);
    
    % Get the size and centre of the window in pixels
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    screenPixels = [screenXpixels, screenYpixels];
    [xCenter, yCenter] = RectCenter(windowRect);
    coorCenter = [xCenter, yCenter];
    
    % Enable alpha blending for anti-aliasing (important for face presentation)
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    % Query the maximum priority level
    topPriorityLevel = MaxPriority(window);
    
    %% Keyboard
    
    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');
    
    % Response Keys
    leftKey = KbName('leftarrow');
    rightKey = KbName('rightarrow');
    
    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey, leftKey, rightKey];
    RestrictKeysForKbCheck(KbCheckList);
    
    %% Different Settings
    settings_memory;
    settings_rsvp;
    
    %% Slides with instructions
    instFolderName = 'instructions/instructionsDiapo/';
    instFolder = dir(instFolderName);
    
    inst = cell(1,(length(instFolder)-2));
    stimuli.instTexture = cell(1,(length(instFolder)-2));
    
    for i = 3:length(instFolder)
        inst{i-2} = imread([instFolderName, 'Diapositive', num2str(i-2), '.JPG']);
        stimuli.instTexture{i-2} = Screen('MakeTexture', window, inst{i-2});
    end
    
    stimuli.instPos = [(screenXpixels-size(inst{1},2))/2 (screenYpixels-size(inst{1},1))/2 ...
        (screenXpixels+size(inst{1},2))/2 (screenYpixels+size(inst{1},1))/2];
    
    %% Download reward
    
    smallRwdImg =imread('instructions\cent.jpg');
    largeRwdImg = imread('instructions\euro.jpg');
    stimuli.smallRwd = Screen('MakeTexture', window, smallRwdImg);
    stimuli.largeRwd = Screen('MakeTexture', window, largeRwdImg);
    
    stimuli.posRwd = [(screenXpixels/10*9.5 - size(smallRwdImg,2)/2.5) (screenYpixels/10 - size(smallRwdImg,1)/2.5) ...
        (screenXpixels/10*9.5 + size(smallRwdImg,2)/2.5) (screenYpixels/10 + size(smallRwdImg,1)/2.5)];
    
    %% Download instruction img 
    
    instBCImg =imread('instructions\instBC.jpg');
    instDCImg = imread('instructions\instDC.jpg');
    stimuli.instBC = Screen('MakeTexture', window, instBCImg);
    stimuli.instDC = Screen('MakeTexture', window, instDCImg);
    
    stimuli.posInst = [(screenXpixels/10*8.5 - size(instBCImg,2)/2.5) (screenYpixels/10 - size(instBCImg,1)/2.5) ...
        (screenXpixels/10*8.5 + size(instBCImg,2)/2.5) (screenYpixels/10 + size(instBCImg,1)/2.5)];
    
    
    %% Download images for RSVP
    
    load('exp_images/WMN_img_rsvp.mat','WMN_img_rsvp');
    load('exp_images/WMF_img_rsvp.mat','WMF_img_rsvp');
    load('exp_images/WFN_img_rsvp.mat','WFN_img_rsvp');
    load('exp_images/WFF_img_rsvp.mat','WFF_img_rsvp');
    
    load('exp_images/WMN_img_scramble.mat','WMN_img_scramble');
    load('exp_images/WMF_img_scramble.mat','WMF_img_scramble');
    load('exp_images/WFN_img_scramble.mat','WFN_img_scramble');
    load('exp_images/WFF_img_scramble.mat','WFF_img_scramble');
    
    [stimuli.fearFemRSVP,stimuli.fearMaleRSVP, stimuli.neutralFemRSVP, stimuli.neutralMaleRSVP ...
        ] = createImageTexture(WMN_img_rsvp, WMF_img_rsvp, WFN_img_rsvp, WFF_img_rsvp,window);
    
    [stimuli.fearFemScramble,stimuli.fearMaleScramble, stimuli.neutralFemScramble, stimuli.neutralMaleScramble, ...
        stimuli.sizeImgRSVP] = createImageTexture(WMN_img_scramble, WMF_img_scramble, WFN_img_scramble, WFF_img_scramble,window);
    
    stimuli.posRSVP = [(screenXpixels - stimuli.sizeImgRSVP(2))/2 (screenYpixels - stimuli.sizeImgRSVP(1))/2 ...
        (screenXpixels + stimuli.sizeImgRSVP(2))/2 (screenYpixels + stimuli.sizeImgRSVP(1))/2];
    
    %% Download Images for Memory task
    
    load('exp_images/WMN_img_vs.mat');
    load('exp_images/WMF_img_vs.mat');
    load('exp_images/WFN_img_vs.mat');
    load('exp_images/WFF_img_vs.mat');
    
    [stimuli.fearFemMemory,stimuli.fearMaleMemory, stimuli.neutralFemMemory, stimuli.neutralMaleMemory, ...
        stimuli.sizeImgMemory] = createImageTexture(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs,window);
    
    %% Set Participant ID
    
    ID = ceil(100000*rand);
    %ID = 2;
    
    %% Start of the experiment
    
    for i = 1:2
        Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
    end
    
    %% If last digit ID even -> memory first (odd -> RSVP first)
    
    if rem(ID,2)==0
        % Training Period
        [respMat_training_memory] = memory_task(ID, window, colors, screenPixels, true, stimuli);
        
        % Experiment without Training
        [respMat_memory] = memory_task(ID, window, colors, screenPixels, false, stimuli);
        
    else
        %Training Period
        [respMat_training_rsvp] = rsvp_task(ID, window, colors, screenPixels, true, stimuli);
        
        %Experiment without Training
        [respMat_rsvp] = rsvp_task(ID, window, colors, screenPixels, false, stimuli);
        
    end
    
    %% If last digit ID even -> RSVP second (odd -> Memory second)
    
    if rem(ID,2)==1
        % Training Period
        [respMat_training_memory] = memory_task(ID, window, colors, screenPixels, true, stimuli);
        
        % Experiment without Training
        [respMat_memory] = memory_task(ID, window, colors, screenPixels, false, stimuli);
        
    else
        
        %Training Period
        [respMat_training_rsvp] = rsvp_task(ID, window, colors, screenPixels, true, stimuli);
        
        %Experiment without Training
        [respMat_rsvp] = rsvp_task(ID, window, colors, screenPixels, false, stimuli);
        
    end
    
    %% End of the experiment (Save results)
    Screen('DrawTexture', window, stimuli.instTexture{22},[],stimuli.instPos,0);
    Screen('Flip', window);
    KbStrokeWait;
    
    if ~isfolder('results')
        mkdir results
    end
    
    fileNameMemory = [ 'results/',num2str(ID), '_memory.mat'];
    data_memory = [respMat_training_memory, respMat_memory];
    save(fileNameMemory, 'data_memory');
    
    fileNameRSVP = ['results/',num2str(ID),'_rsvp.mat'];
    data_rsvp = [respMat_training_rsvp, respMat_rsvp];
    save(fileNameRSVP, 'data_rsvp');
    
    sca;
    
    % Check if file was saved -> if problem, save matrices manually
    
    if  isfile(fileNameMemory) && isfile(fileNameRSVP) 
        warningMessage = sprintf([' End experiment: all data was saved correctly.                     \n ID : ', ...
            num2str(ID), '\n Date : ',datestr(datetime('now'))]);
        msg = msgbox(warningMessage);
        amsg = get( msg, 'CurrentAxes' );
        chmsg = get( amsg, 'Children' );
        set( chmsg, 'FontSize', 11);
        uiwait(msg);
    else
        warningMessage = sprintf([' Warning: data was not saved correctly.                  \n ID : ', ...
            num2str(ID), '\n Date : ',datestr(datetime('now'))]);
        msg = msgbox(warningMessage, 'Error','warn');
        amsg = get( msg, 'CurrentAxes' );
        chmsg = get( amsg, 'Children' );
        set( chmsg, 'FontSize', 11);
        uiwait(msg);
    end
    
    
catch
    sca;
    fprintf('This was the last error : \n');
    psychrethrow(psychlasterror);
    
end