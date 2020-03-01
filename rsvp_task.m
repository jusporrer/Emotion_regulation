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
    Screen('TextSize', window, 30);
    
    text_experiment;
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    
    settings_rsvp;
    
    %% Download the images
    
    % Faces 
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
    
    % Rewards 
    
    smallRwdImg =imread('exp_images\cent.jpg');
    largeRwdImg = imread('exp_images\euro.jpg');
    smallRwd = Screen('MakeTexture', window, smallRwdImg); 
    largeRwd = Screen('MakeTexture', window, largeRwdImg); 
    
    posSmallRwd = [(screenXpixels/10*9.5 - size(smallRwdImg,2)/6) (screenYpixels/10 - size(smallRwdImg,1)/6) ...
        (screenXpixels/10*9.5 + size(smallRwdImg,2)/6) (screenYpixels/10 + size(smallRwdImg,1)/6)];
    
    posLargeRwd = [(screenXpixels/10*9.5 - size(largeRwdImg,2)/6) (screenYpixels/10 - size(largeRwdImg,1)/6) ...
        (screenXpixels/10*9.5 + size(largeRwdImg,2)/6) (screenYpixels/10 + size(largeRwdImg,1)/6)];
    
    %% Training or not
    
    if training
        nBlocks = rsvp.nBlocksTrain;
        nTrials = rsvp.nTrialsTrain;
        condition = [Shuffle(1:6), Shuffle(1:6)];
        
        instruction = {instRSVP1,instRSVP2,trainRSVP};
        
        for i = 1:length(instruction)     
            DrawFormattedText(window, instruction{i}, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
        end 
        
    else
        nBlocks = rsvp.nBlocksExp;
        nTrials = rsvp.nTrialsExp;
        
        condition = zeros(nBlocks,nTrials*6);
        for i = 1:nBlocks
            condition(i,:) = Shuffle(repmat((1:6),1,nTrials));
        end 
        
        DrawFormattedText(window, trainingFiniRSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, RSVP, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
    end
    
    %% Actual Experiment
    a = 1; instr = 0;
    
    for block = 1:nBlocks
        
        if training
            textRwd = trainReward;
            imgRwd = smallRwd;
            posRwd = posSmallRwd;
            rwd = 0;
            sizeText = 30;
        else
            if rem(block,2) == 1
                textRwd = smallReward;
                imgRwd = smallRwd;
                posRwd = posSmallRwd;
                rwd = 1; %(1 = Small reward, 2 = Large reward)
                sizeText = 50;
            elseif rem(block,2) == 0
                textRwd = largeReward;
                imgRwd = largeRwd;
                posRwd = posLargeRwd;
                rwd = 2; %(1 = Small reward, 2 = Large reward)
                sizeText = 50;
            end
        end
        
        Screen('TextSize', window, sizeText);
        DrawFormattedText(window, textRwd , 'center', screenYpixels*0.35 , black);
        Screen('TextSize', window, 30);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        
        Screen('DrawTexture', window, imgRwd );
        Screen('Flip', window);
        KbStrokeWait;
        
        for trial = 1:nTrials
            
            % Initialise RTs and response
            rt = 0;
            response = 0;
            imageDisplay = zeros(1,rsvp.setSize);
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            % Draw the fixation cross in black
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            flipTime = Screen('Flip', window);
            
            for frame = 1:isiTimeFrames - 1
                Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2)
                Screen('DrawTexture', window, imgRwd, [], posRwd);
                flipTime = Screen('Flip', window, flipTime + (waitframes -0.5) * ifi);
            end
            
            % Select new images every trial
            img = [fearFemTexture{randi([1 size(fearFemTexture,2)],1,2)};... % 1
                fearMaleTexture{randi([1 size(fearMaleTexture,2)],1,2)}; ... % 2
                neutralFemTexture{randi([1 size(neutralFemTexture,2)],1,2)}; ... % 3
                neutralMaleTexture{randi([1 size(neutralMaleTexture,2)],1,2)}]; % 4
            
            img_scramble = [fearFemScramble{randi([1 size(fearFemScramble,2)],1,rsvp.setSize)};... % 1
                fearMaleScramble{randi([1 size(fearMaleScramble,2)],1,rsvp.setSize)}; ... % 2
                neutralFemScramble{randi([1 size(neutralFemScramble,2)],1,rsvp.setSize)}; ... %3
                neutralMaleScramble{randi([1 size(neutralMaleScramble,2)],1,rsvp.setSize)}]; %4
            
            % Indexing of img
            fem = [1,3]; male = [2,4]; fear = [1,2]; neutral = [3,4];
            
            % Create new random position of D and T on each trial
            posCritDist = randi([4,8]);
            posTarget = posCritDist + randi(2)*2; % either 200 ms or 400 ms after, position between 6 and 12
            
            % Create the set of stimuli according to condition
            
            if condition(block,trial) == 1 % DC_male: fearful male D, neutral fem & male T
                distractor = fear(2); % 2  
                target = neutral(randi(2)); % 3 or 4
                
            elseif condition(block,trial) == 2 % DC_fem: fearful female D, neutral fem & male T
                distractor = fear(1); % 1
                target = neutral(randi(2)); % 3 or 4
                
            elseif condition(block,trial) == 3 % CC_male: neutral man D, neutral male or female T OR fearful man D, fearful male or female T
                distractor = male(randi(2)); % 2 or 4
                if distractor == male(1) % 2
                    target = fear(randi(2)); % 1 or 2
                elseif distractor == male(2) % 4
                    target = neutral(randi(2)); % 3 or 4
                end
                
            elseif condition(block,trial) == 4 % CC_female: neutral female D, neutral male or female T OR fearful female D, fearful male or female T
                distractor = fem(randi(2)); % 1 or 3
                if distractor == fem(1) % 1
                    target = fear(randi(2)); % 1 or 2
                elseif distractor == fem(2) % 3
                    target = neutral(randi(2)); % 3 or 4 
                end
                
            elseif condition(block,trial) == 5 % BC_male: neutral male D, fearful male or female T
                distractor = neutral(2); % 4
                target = fear(randi(2)); % 1 or 2
                
            elseif condition(block,trial) == 6 % BC_fem : neutral female D, fearful male or female T
                distractor = neutral(1); % 3
                target = fear(randi(2)); % 1 or 2
            end
            
            for nbImage = 1: rsvp.setSize
                if nbImage == posCritDist
                    imageDisplay(nbImage) = img(distractor,1);
                elseif nbImage == posTarget
                    imageDisplay(nbImage) = img(target,2);
                else
                    imageDisplay(nbImage) = img_scramble(distractor,nbImage);
                end
            end
            
            for nbImage = 1: rsvp.setSize
                Screen(window, 'FillRect', white);
                Screen('DrawTexture', window, imageDisplay(nbImage), [],posCenter,0);
                Screen('DrawTexture', window, imgRwd, [], posRwd);
                flipTime = Screen('Flip', window, flipTime + rsvp.imageDuration - ifi,0);
            end
            
            Screen(window, 'FillRect', white);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            startTime = Screen('Flip', window, flipTime + rsvp.imageDuration - ifi,0);
            
            while GetSecs - startTime < rsvp.trialTimeout
                [~,~,keyCode] = KbCheck;
                respTime = GetSecs;
                
                if condition(block,trial) == 1 || condition(block,trial) == 3 || condition(block,trial) == 5
                    instr = 1;
                    Screen('TextSize', window, 50);
                    DrawFormattedText(window, femRSVP, 'center', screenYpixels*0.5, black);
                    DrawFormattedText(window, respRSVP, 'center', screenYpixels*0.65, black);
                    Screen('DrawTexture', window, imgRwd, [], posRwd);
                    Screen('Flip', window);
                    
                elseif condition(block,trial) == 2 || condition(block,trial) == 4 || condition(block,trial) == 6
                    instr = 2;
                    Screen('TextSize', window, 50);
                    DrawFormattedText(window, maleRSVP, 'center', screenYpixels*0.5, black);
                    DrawFormattedText(window, respRSVP, 'center', screenYpixels*0.65, black);
                    Screen('DrawTexture', window, imgRwd, [], posRwd);
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
                
            end
            
            % Record the trial data into the data matrix
            a = a + 1;
            respMatRSVP(a).cfg = rsvp;
            respMatRSVP(a).ID = ID;
            respMatRSVP(a).training = training; %(1 = training, 0 = no training)
            respMatRSVP(a).reward = rwd; %(0 = traning, 1 = Small reward, 2 = Large reward)
            respMatRSVP(a).condition = condition(block,trial); % (1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
            respMatRSVP(a).block = block;
            respMatRSVP(a).trial = trial;
            respMatRSVP(a).RTs = rt;
            respMatRSVP(a).instr = instr;
            respMatRSVP(a).response = response;
            respMatRSVP(a).posCritDist = posCritDist;
            respMatRSVP(a).posTarget = posTarget;
            respMatRSVP(a).distractor = distractor;
            respMatRSVP(a).target = target;
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            Screen('Flip', window);
            WaitSecs(rsvp.timeBetweenTrials);
            
        end
    end
    
catch
    sca;
    fprintf('The last error in the RSVP was : \n');
    psychrethrow(psychlasterror);
end

end