function [respMatRSVP] = rsvp_task(ID, window, colors, screenPixels, coorCenter, training)

try
    %% Initialise screen
    HideCursor;
    
    % Colors according to the screen
    white = colors(1);
    black = colors(2);
    
    % Get the size and centre of the window in pixels
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    xCenter = coorCenter(1);
    yCenter = coorCenter(2);
    
    %% Keyboard
    
    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');
    
    % Response Keys
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    
    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey, leftKey, rightKey];
    RestrictKeysForKbCheck(KbCheckList);
    
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
    
    text_experiment;
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % nTrialsExp, nTrialsTrain, nBlocksExp, nBlocksTrain,  ...
    % trialTimeout, timeBetweenTrials
    
    settings_rsvp;
    
    %% Download the images
    
    load('exp_images/WMN_img_rsvp.mat','WMN_img_rsvp');
    load('exp_images/WMF_img_rsvp.mat','WMF_img_rsvp');
    load('exp_images/WFN_img_rsvp.mat','WFN_img_rsvp');
    load('exp_images/WFF_img_rsvp.mat','WFF_img_rsvp');
    
    load('exp_images/WMN_img_scramble.mat','WMN_img_scramble');
    load('exp_images/WMF_img_scramble.mat','WMF_img_scramble');
    load('exp_images/WFN_img_scramble.mat','WFN_img_scramble');
    load('exp_images/WFF_img_scramble.mat','WFF_img_scramble');
    
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture ...
        ] = createImageTexture(WMN_img_rsvp, WMF_img_rsvp, WFN_img_rsvp, WFF_img_rsvp,window);
    
    [fearFemScramble,fearMaleScramble, neutralFemScramble, neutralMaleScramble, ...
        sizeImg] = createImageTexture(WMN_img_scramble, WMF_img_scramble, WFN_img_scramble, WFF_img_scramble,window);
    
    posCenter = [(screenXpixels-sizeImg(2))/2 (screenYpixels-sizeImg(1))/2 (screenXpixels+sizeImg(2))/2 (screenYpixels+sizeImg(1))/2];
    
    %% Create Condition Matrix
    % (1 = DC_male, 2 = DC_female, 3 = CC_male,
    % 4 = CC_female, 5 = BC_male , 6 = BC_female)
    
    % the condition is created inside the training or not
    
    %% Training or not
    
    if training
        nBlocks = nBlocksTrain;
        nTrials = nTrialsTrain;
        condition = ones(1,6); % the only condition for traning
        
        DrawFormattedText(window, trainRSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, instRSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
        nBlocks = nBlocksExp;
        nTrials = nTrialsExp;
        
        % Complete shuffle
        % condition = Shuffle(repmat([1:6],1,2));
        % Semi shuffle for LR and HR
        condition = [Shuffle(1:6), Shuffle(1:6)];
        
        DrawFormattedText(window, trainingFiniRSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, RSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
    end
    
    respMatRSVP = nan(nTrials*nBlocks, length(respMatColumnsRSVP)); % but NaN not recommened for VBA ?
    
    %% Actual Experiment
    line_save = 0;
    
    for block = 1:nBlocks
        
        for trial = 1:nTrials
            
            % Initialise RTs and response
            rt = 0;
            response = 0;
            imageDisplay = zeros(1,setSize);
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            % Draw the fixation cross in black
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            vbl = Screen('Flip', window);
            
            for frame = 1:isiTimeFrames - 1
                Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2)
                vbl = Screen('Flip', window, vbl + (waitframes -0.5) * ifi);
            end
            
            % Select new images every trial
            img = [fearFemTexture{randi([1 size(fearFemTexture,2)])},... % 1
                fearMaleTexture{randi([1 size(fearMaleTexture,2)])}, ... % 2
                neutralFemTexture{randi([1 size(neutralFemTexture,2)])}, ... % 3
                neutralMaleTexture{randi([1 size(neutralMaleTexture,2)])}]; % 4
            
            img_scramble = [fearFemScramble{randi([1 size(fearFemScramble,2)],1,setSize)};... % 1
                fearMaleScramble{randi([1 size(fearMaleScramble,2)],1,setSize)}; ... % 2
                neutralFemScramble{randi([1 size(neutralFemScramble,2)],1,setSize)}; ... %3
                neutralMaleScramble{randi([1 size(neutralMaleScramble,2)],1,setSize)}]; %4
            
            % Indexing of img
            fem = [1,3]; male = [2,4]; fear = [1,2]; neutral = [3,4];
            
            % Create new random position of D and T on each trial
            posCritDist = randi([4,8]);
            posTarget = posCritDist + randi(2)*2; % either 200 ms or 400 ms after
            
            % Create the set of stimuli according to condition
            
            if condition(block) == 1 % DC_male: fearful male D, neutral fem & male T
                distractor = fear(2); % 2
                target = neutral(randi(2)); % 3 or 4
                
            elseif condition(block) == 2 % DC_fem: fearful female D, neutral fem & male T
                distractor = fear(1); % 1
                target = neutral(randi(2)); % 3 or 4
                
            elseif condition(block) == 3 % CC_male: neutral or fearful man D, neutral or fearful female T
                distractor = male(randi(2)); % 2 or 4
                if distractor == male(1)
                    target = fear(randi(2)); % 1 or 2
                elseif distractor == male(2)
                    target = neutral(randi(2)); % 3 or 4
                end
                
            elseif condition(block) == 4 % CC_female
                distractor = fem(randi(2));
                if distractor == fem(1)
                    target = fear(randi(2));
                elseif distractor == fem(2)
                    target = neutral(randi(2));
                end
                
            elseif condition(block) == 5 % BC_male: neutral male D, fearful male or female T
                distractor = neutral(2); % 4
                target = fear(randi(2)); % 1 or 2
                
            elseif condition(block) == 6 % BC_fem : neutral female D, fearful male or female T
                distractor = neutral(1); % 3
                target = fear(randi(2)); % 1 or 2
            end
            
            for nbImage = 1: setSize
                if nbImage == posCritDist
                    imageDisplay(nbImage) = img(distractor);
                elseif nbImage == posTarget
                    imageDisplay(nbImage) = img(target);
                else
                    imageDisplay(nbImage) = img_scramble(distractor,nbImage);
                end
            end
            
            flipTime = Screen('Flip', window);
            for nbImage = 1: setSize
                Screen(window, 'FillRect', white);
                Screen('DrawTexture', window, imageDisplay(nbImage), [],posCenter,0);
                flipTime = Screen('Flip', window, flipTime + imageDuration - ifi,0);
            end
            Screen(window, 'FillRect', white);
            startTime = Screen('Flip', window, flipTime + imageDuration - ifi,0);
            
            while GetSecs - startTime < trialTimeout
                [~,~,keyCode] = KbCheck;
                respTime = GetSecs;
                
                if condition(block) == 1 || condition(block) == 3 || condition(block) == 5
                    DrawFormattedText(window, 'Was there a women?', 'center', screenYpixels*0.5, black);
                    DrawFormattedText(window, ' Oui / Non ', 'center', screenYpixels*0.65, black);
                    Screen('Flip', window);
                    
                elseif condition(block) == 2 || condition(block) == 4 || condition(block) == 6
                    DrawFormattedText(window, 'Was there a man?', 'center', screenYpixels*0.5, black);
                    DrawFormattedText(window, ' Oui / Non ', 'center', screenYpixels*0.65, black);
                    Screen('Flip', window);
                end
                
                % Check for response keys (ESC key quits)
                if keyCode(escapeKey) == 1
                    sca
                    return;
                elseif keyCode(leftKey) == 1
                    response = 1;
                    rt = respTime - startTime;
                elseif keyCode(rightKey) == 1
                    response = 2;
                    rt = respTime - startTime;
                end
                
                %Exit loop once a response is recorded
                if rt > 0
                    break;
                end
            end % end while
            
            line_save = line_save + 1;
            
            % Record the trial data into the data matrix
            respMatRSVP(line_save,1) = ID;
            respMatRSVP(line_save,2) = training;
            %respMatRSVP(trial,3) = reward;
            respMatRSVP(line_save,4) = condition(block);
            respMatRSVP(line_save,5) = trial;
            respMatRSVP(line_save,6) = block;
            respMatRSVP(line_save,7) = rt;
            respMatRSVP(line_save,8) = response;
            respMatRSVP(line_save,9) = posCritDist;
            respMatRSVP(line_save,10) = posTarget;
            respMatRSVP(line_save,11) = distractor;
            respMatRSVP(line_save,12) = target;
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('Flip', window);
            WaitSecs(timeBetweenTrials);
            
        end % end trial
    end % end block
    
catch
    sca;
    fprintf('The last error in the RSVP was : \n');
    psychrethrow(psychlasterror);
end

end