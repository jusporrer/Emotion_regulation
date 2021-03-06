
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
    
    %% Different Settings
    settings_visual_search;
    
    %% Define the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 30);
    
    text_experiment_vs;
    
    %% Set Participant ID
    
    ID = ceil(100000*rand);
    
    %% Start of the experiment 
    
    DrawFormattedText(window, bonjour, 'center', 'center', black);
    DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
    Screen('Flip', window);
    KbStrokeWait;
    
    DrawFormattedText(window, reward, 'center', 'center', black);
    DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
    Screen('Flip', window);
    KbStrokeWait;
    
    %% Experiment
    
    % Training Period
    [respMat_training_visual_search] = visual_search_task(ID, window, colors, screenPixels, coorCenter, true);
    
    % Experiment without Training
    [respMat_visual_search] = visual_search_task(ID, window, colors, screenPixels, coorCenter, false);
    
    DrawFormattedText(window, finiVS, 'center', 'center', black);
    DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
    Screen('Flip', window);
    KbStrokeWait;
             
    %% End of the experiment (Save results)
    Screen('TextSize', window, 30);
    DrawFormattedText(window, fini, 'center', 'center', black);
    Screen('Flip', window);
    KbStrokeWait;
    
    if ~isfolder('results')
        mkdir results
    end
    
    fileNameVS = [ 'results/',num2str(ID), '_visual_search.mat'];
    data_visual_search = [respMat_training_visual_search, respMat_visual_search];
    save(fileNameVS, 'data_visual_search');
    
    sca;
    
    % Check if file was saved -> if problem, save matrices manually
    
    if isfile(fileNameVS)
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