function [respMatRSVP] = rsvp_task(ID, window, colors, screenPixels, training, stimuli)

try
    %% Initialise screen
    HideCursor;
    
    % Colors according to the screen
    white = colors(1);
    black = colors(2);
    
    % Get the size and centre of the window in pixels
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    xCenter = screenXpixels/2;
    yCenter = screenYpixels/2;
    
    %% Keyboard
    
    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');
    
    % Response Keys
    ouiKey = KbName('o');
    nonKey = KbName('n');
    
    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey, ouiKey, nonKey];
    RestrictKeysForKbCheck(KbCheckList);
    
    %% Timing Information
    
    %Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    %Interstimulus interval time in seconds and frames
    isiTimeSecs = 1;
    isiTimeFrames = round(isiTimeSecs / ifi);
    
    %Numer of frames to wait before re-drawing
    waitframes = 1;
       
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    
    settings_rsvp;
           
    %% Training or not
    
    if training
        nBlocks = rsvp.nBlocksTrain;
        nTrials = rsvp.nTrialsTrain;
        condition = [Shuffle(1:6), Shuffle(1:6)];
        
        for i = 6:8
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
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
        
        for i = 10
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
    end
    
    %% Actual Experiment
    a = 0; instr = 0;
    
    for block = 1:nBlocks
        
        if training
            instRwd = stimuli.instTexture{3};
            imgRwd = stimuli.smallRwd;
            posRwd = stimuli.posSmallRwd;
            rwd = 0;
        else
            if rem(block,2) == 1
                instRwd = stimuli.instTexture{4};
                imgRwd = stimuli.smallRwd;
                posRwd = stimuli.posSmallRwd;
                rwd = 1; %(1 = Small reward, 2 = Large reward)
            elseif rem(block,2) == 0
                instRwd = stimuli.instTexture{5};
                imgRwd = stimuli.largeRwd;
                posRwd = stimuli.posLargeRwd;
                rwd = 2; %(1 = Small reward, 2 = Large reward)
            end
        end
        
        Screen('DrawTexture', window, instRwd,[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
        for trial = 1:nTrials
            
            % Initialise RTs and response
            a = a + 1;
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
            img = [stimuli.fearFemRSVP{randi([1 size(stimuli.fearFemRSVP,2)],1,2)};... % 1
                stimuli.fearMaleRSVP{randi([1 size(stimuli.fearMaleRSVP,2)],1,2)}; ... % 2
                stimuli.neutralFemRSVP{randi([1 size(stimuli.neutralFemRSVP,2)],1,2)}; ... % 3
                stimuli.neutralMaleRSVP{randi([1 size(stimuli.neutralMaleRSVP,2)],1,2)}]; % 4
            
            img_scramble = [stimuli.fearFemScramble{randi([1 size(stimuli.fearFemScramble,2)],1,rsvp.setSize)};... % 1
                stimuli.fearMaleScramble{randi([1 size(stimuli.fearMaleScramble,2)],1,rsvp.setSize)}; ... % 2
                stimuli.neutralFemScramble{randi([1 size(stimuli.neutralFemScramble,2)],1,rsvp.setSize)}; ... %3
                stimuli.neutralMaleScramble{randi([1 size(stimuli.neutralMaleScramble,2)],1,rsvp.setSize)}]; %4
            
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
                Screen('DrawTexture', window, imageDisplay(nbImage), [],stimuli.posRSVP,0);
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
                    Screen('DrawTexture', window, stimuli.instTexture{11},[],stimuli.instPos,0);
                    Screen('DrawTexture', window, imgRwd, [], posRwd);
                    Screen('Flip', window);
                    
                elseif condition(block,trial) == 2 || condition(block,trial) == 4 || condition(block,trial) == 6
                    instr = 2;
                    Screen('DrawTexture', window, stimuli.instTexture{12},[],stimuli.instPos,0);
                    Screen('DrawTexture', window, imgRwd, [], posRwd);
                    Screen('Flip', window);
                end
                
                % Check for response keys (ESC key quits)
                if keyCode(escapeKey) == 1
                    sca
                    return;
                elseif keyCode(ouiKey) == 1
                    response = 1;
                    rt = respTime - startTime;
                elseif keyCode(nonKey) == 1
                    response = 2;
                    rt = respTime - startTime;
                end
                
                %Exit loop once a response is recorded
                if rt > 0
                    break;
                end
                
            end
            
            % Record the trial data into the data matrix
            respMatRSVP(a).cfg = rsvp;
            respMatRSVP(a).ID = ID;
            respMatRSVP(a).training = training; %(1 = training, 0 = no training)
            respMatRSVP(a).reward = rwd; %(0 = training, 1 = Small reward, 2 = Large reward)
            respMatRSVP(a).condition = condition(block,trial); % (1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
            respMatRSVP(a).block = block;
            respMatRSVP(a).trial = trial;
            respMatRSVP(a).RTs = rt;
            respMatRSVP(a).instr = instr; % (1 = femquest, 2 = homquest) 
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
    
    %% End of Experiment 
    
    if training
                
        Screen('DrawTexture', window, stimuli.instTexture{9},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
                
        Screen('DrawTexture', window, stimuli.instTexture{13},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    end
    
catch
    sca;
    fprintf('The last error in the RSVP was : \n');
    psychrethrow(psychlasterror);
end

end