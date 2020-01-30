function [respMatRSVP] = rsvp_task(ID, window, colors, screenPixels, coorCenter, training)

try
    %% Initialise screen
    
    % Colors according to the screen
    white = colors(1);
    black = colors(2);
    grey = colors(3);
    
    % Get the size and centre of the window in pixels
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    xCenter = coorCenter(1);
    yCenter = coorCenter(2);
    
    %% Keyboard (to develop) 

    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');

    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey];
    RestrictKeysForKbCheck(KbCheckList);
    [keyIsDown,secs, keyCode] = KbCheck;
    
    %% Timing Information
    
    %Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    %Interstimulus interval time in seconds and frames
    isiTimeSecs = 1;
    isiTimeFrames = round(isiTimeSecs / ifi);
    
    %Numer of frames to wait before re-drawing
    waitframes = 1;
    
    %% Defines the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 60);
    
    %% Download the images
    
    % Get the image files for the experiment
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, sizeImg] = createImageTexture(window); 
    
    posCenter = [(screenXpixels-sizeImg(2))/2 (screenYpixels-sizeImg(1))/2 (screenXpixels+sizeImg(2))/2 (screenYpixels+sizeImg(1))/2];   
    
    condition = 1; 
    if condition == 1 
        for nbImage = 1: setSize
            p = round(rand);
            if rem(nbImage,2) == 0
                imageDisplay(nbImage) = imTargTexture;
            else
                imageDisplay(nbImage) = imDistTexture;
            end
        end
    elseif condition == 0 
        
    elseif condition == 2 %(-1 or 2) 
        
    end 
        
    % need to create a random order of the 
        
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % nTrialsExp, nTrialsTrain, nBlocksExp, nBlocksTrain,  ...
    % trialTimeout, timeBetweenTrials 
    
    settings_rsvp;
    
    %% Create Response Matrix
    
    % This is a X column matrix:
        % 1st column: ID
        % 2nd column: Condition (1 = BC, 0 = CC,-1 = DC)
        % 3rd column: Nb Block
        % 4th column: Nb Trial
        % 5th column: RTs
        % 6th column: Response
    
    respMatColumns = ["ID", "Condition", "Nb Block","Nb Trial","RTs","Response"];
    
    respMatRSVP = nan(nTrialsExp*nBlocksExp, length(respMatColumns)); % but nan not recommened for VBA ? 
    
    %% Training or not
    
    if training == 1
        nBlocks = nBlocksTrain;
        nTrials = nTrialsTrain;
    elseif training == 0
        nBlocks = nBlocksExp;
        nTrials = nTrialsExp;
    end
    
    %% Actual Experiment
    
    for block = 1:nBlocks
        
        for trial = 1:nTrials
            
            % Initialise RTs and response 
            rt = 0; 
            response = 0;
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            % Draw the fixation cross in white
            Screen('DrawLines', window, CoordsFix, lineWidthFix, white, [xCenter yCenter], 2);
            vbl = Screen('Flip', window);
            
            for frame = 1:isiTimeFrames - 1
                Screen('DrawLines', window, CoordsFix, lineWidthFix, white, [xCenter yCenter], 2)
                vbl = Screen('Flip', window, vbl + (waitframes -0.5) * ifi);
            end
            
            flipTime = Screen('Flip', window);
            for nbImage = 1: setSize
                Screen(window, 'FillRect', grey);
                Screen('DrawTexture', window, imageDisplay(nbImage), [],posCenter,0);
                flipTime = Screen('Flip', window, flipTime + imageDuration - ifi,0);
            end
            Screen(window, 'FillRect', grey);
            startTime = Screen('Flip', window, flipTime + imageDuration - ifi,0);
            
            
            % Record the trial data into the data matrix
            respMatRSVP(trial,1) = ID;
            %respMat(trial,2) = condition; % to implement
            respMatRSVP(trial,3) = trial;
            respMatRSVP(trial,4) = block;
            respMatRSVP(trial,5) = rt;
            respMatRSVP(trial,6) = response;
            
            % Screen after trial
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            WaitSecs(timeBetweenTrials);
        end
    end
    
catch
    sca;
    fprintf('The last error in the RSVP was : \n');
    psychrethrow(psychlasterror);
end

end