try
    %% Initialise screen
    Screen('Preference', 'SkipSyncTests', 1)
    Screen('Preference', 'SuppressAllWarnings', 1)

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

    % Open screen window using PsychImaging and color it grey.
    [window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

    % Get the size and centre of the window in pixels
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    screenPixels = [screenXpixels, screenYpixels]; 
    [xCenter, yCenter] = RectCenter(windowRect);
    coorCenter = [xCenter, yCenter]; 

    % Enable alpha blending for anti-aliasing (important for face presentation)
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    % Query the maximum priority level
    topPriorityLevel = MaxPriority(window);

    %% Mouse position and keys
    %Set the position of the mouse
    SetMouse(xCenter, yCenter, window);

    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');

    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey];
    RestrictKeysForKbCheck(KbCheckList);
    [keyIsDown,secs, keyCode] = KbCheck;

    %% Define the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 60);
    
    text_experiment; 
    
    %% Set Participant ID  
    
    ID = ceil(1000000*rand); 
    
    %% First experiment (according to the odd/even ID) with training first 
%     DrawFormattedText(window, trainVS, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
%     DrawFormattedText(window, instVS, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
%     training = 1; 
%     [respMat_visual_search] = visual_search_task(ID, window, colors, screenPixels, coorCenter, training);
%     Screen('Flip', window);
%     DrawFormattedText(window, trainingFiniVS, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
%     DrawFormattedText(window, VS, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
%     training = 0; 
%     [respMat_visual_search] = visual_search_task(ID, window, colors, screenPixels, coorCenter, training); 
%     DrawFormattedText(window, finiVS, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
    
    %% Second experiment 
    
%     DrawFormattedText(window, trainRSVP, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
%     DrawFormattedText(window, instRSVP, 'center', 'center', white);
%     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
%     Screen('Flip', window);
%     KbStrokeWait;
%     
    training = 1;
    [respMat_rsvp] = rsvp_task(ID, window, colors, screenPixels, coorCenter, training);
    

    
    %% End of the experiment 
    % Screen CloseAll
    sca;
    
catch 
    sca;
    fprintf('This was the last error : \n');
    psychrethrow(psychlasterror);
    
end 