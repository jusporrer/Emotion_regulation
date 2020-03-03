function [respMatVS] = visual_search_task(ID, window, colors, screenPixels, coorCenter, training)

try
    %% Initialise screen
    
    % Colors according to the screen
    white = colors(1);
    black = colors(2);
    
    % Get the size and centre of the window in pixels
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    xCenter = coorCenter(1);
    yCenter = coorCenter(2);
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    %% Timing Information
    
    ifi = Screen('GetFlipInterval', window);
    
    %% Defines the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 30);
    
    text_experiment_vs;
    
    %% Download the images
    
    % Faces 
    load('../exp_images/WMN_img_vs.mat','WMN_img_vs');
    load('../exp_images/WMF_img_vs.mat','WMF_img_vs');
    load('../exp_images/WFN_img_vs.mat','WFN_img_vs');
    load('../exp_images/WFF_img_vs.mat','WFF_img_vs');
    
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, ...
        ] = createImageTexture(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs,window);
    
    sizeImg = size(WMN_img_vs{1});
    
    % Rewards 
    smallRwdImg =imread('../exp_images/cent.jpg');
    largeRwdImg = imread('../exp_images/euro.jpg');
    smallRwd = Screen('MakeTexture', window, smallRwdImg); 
    largeRwd = Screen('MakeTexture', window, largeRwdImg); 
    
    % Position in the top left corner
    posSmallRwd = [(screenXpixels/10*9.5 - size(smallRwdImg,2)/2) (screenYpixels/10 - size(smallRwdImg,1)/2) ...
        (screenXpixels/10*9.5 + size(smallRwdImg,2)/2) (screenYpixels/10 + size(smallRwdImg,1)/2)];
    
    posLargeRwd = [(screenXpixels/10*9.5 - size(largeRwdImg,2)/2) (screenYpixels/10 - size(largeRwdImg,1)/2) ...
        (screenXpixels/10*9.5 + size(largeRwdImg,2)/2) (screenYpixels/10 + size(largeRwdImg,1)/2)];
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings

    settings_visual_search;
    
    %% Create Positions for the Faces
    
    % Nb img on x-axis
    nx = 4;
    dx = (0.8/nx);
    
    % Nb img on y-axis
    ny = 4;
    dy = (0.8/ny);
    
    % Use meshgrid to create equally spaced coordinates in the X and Y
    [x, y] = meshgrid(0.1:dx:(0.9-dx), (0.1:dy:(0.9-dy)));
    
    % Scale the grid so that it is in pixel coordinates
    pixelScaleX = screenXpixels / (dx*2);
    pixelScaleY = screenYpixels / (dy*2); % (1.5 for 3 img, 2 for 4 img)
    x = x .* pixelScaleX;
    y = y .* pixelScaleY;
    
    % Nb of positions
    nbPosition = numel(x);
    
    % Matrix of positions
    positionMatrix = [reshape(ceil(x), 1, nbPosition); reshape(ceil(y), 1, nbPosition)];
    
    % Leave place for the coin on top left corner
    positionMatrix(:,13) = [];
    
    %% Training or Exp (with Condition Matrix Creation)
    
    if training
        nBlocks = vs.nBlocksTrain;
        nTrials = vs.nTrialsTrain;
                
        instruction = {instVS1, instVS2, trainVS};
        for i = 1:length(instruction)
            DrawFormattedText(window, instruction{i}, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
        % Condition matrix (1 = DC, 3 = CC, 5 = BC)
        condition = zeros(nBlocks,nTrials);
        for i = 1:nBlocks
            condition(i,:) = cell2mat(Shuffle({ones(1,nTrials/3), repmat(3,1,nTrials/3), repmat(5,1,nTrials/3)}));
        end 
        
    else
        nBlocks = vs.nBlocksExp;
        nTrials = vs.nTrialsExp;
        
        experiment = {trainingFiniVS, VS};
        for i = 1:length(experiment)
            DrawFormattedText(window, experiment{1}, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
        % Condition matrix (1 = DC, 3 = CC, 5 = BC)
        condition = zeros(nBlocks,nTrials);
        for i = 1:nBlocks
            condition(i,:) = cell2mat(Shuffle({ones(1,nTrials/3), repmat(3,1,nTrials/3), repmat(5,1,nTrials/3)}));
        end 
        
    end
      
    %% Actual Experiment
    a = 0;
    
    for block = 1:nBlocks
        
        if training
            textRwd = trainReward;
            imgRwd = largeRwd;
            posRwd = posLargeRwd;
            rwd = 0;
            sizeText = 30;
        else
            if rem(block,2) == 1
                textRwd = smallReward;
                imgRwd = smallRwd;
                posRwd = posSmallRwd;
                rwd = 1; 
                sizeText = 50;
            elseif rem(block,2) == 0
                textRwd = largeReward;
                imgRwd = largeRwd;
                posRwd = posLargeRwd;
                rwd = 2; 
                sizeText = 50;
            end
        end
        
        Screen('TextSize', window, sizeText);
        DrawFormattedText(window, textRwd , 'center', screenYpixels*0.35 , black);
        Screen('TextSize', window, 30);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        
        Screen('DrawTexture', window, imgRwd);
        Screen('Flip', window);
        KbStrokeWait;

        for trial = 1:nTrials
            
            if trial == 1 || trial ==  nTrials/3+1 || trial ==  nTrials/3*2+1
                if condition(block,trial) == 1
                    text = DC_VS;
                elseif condition(block,trial) == 3
                    CC = {CC_fem_VS, CC_male_VS};
                    text = CC{randi(2)};
                elseif condition(block,trial) == 5
                    text = BC_VS;
                end
                Screen('TextSize', window, 50);
                DrawFormattedText(window, text , 'center', 'center', black);
                Screen('TextSize', window, 30);
                DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
                Screen('DrawTexture', window, imgRwd, [], posRwd);
                Screen('Flip', window);
                KbStrokeWait;
            end
            
            % Set the position of the mouse in the center every trial
            SetMouse(xCenter, yCenter, window);
            
            % Initialise response
            a = a + 1;
            rt = 0;
            response = [];
            posRect = [];
            respFF = 0; respNF = 0;
            respFM = 0; respNM = 0;
            
            % Draw fixation cross
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            tFixation = Screen('Flip', window);
            Screen('Flip', window, tFixation + vs.fixationDuration - ifi, 0);
            
            %Create position and orientation for search display
            [posFF, posNF, posFM, posNM, ...
                orientFF, orientNF, orientFM, orientNM ] = ...
                createPositions(positionMatrix, vs.setSize, sizeImg);
            
            % Select vs.setSize/4 new faces
            fearFem = zeros(1,vs.imgSetSize); neutralFem = zeros(1,vs.imgSetSize);
            fearMale = zeros(1,vs.imgSetSize); neutralMale = zeros(1,vs.imgSetSize);
            
            for nb_img = 1: vs.imgSetSize
                fearFem(nb_img) = fearFemTexture{randi([1 size(fearFemTexture,2)])};
                neutralFem(nb_img) = neutralFemTexture{randi([1 size(neutralFemTexture,2)])};
                fearMale(nb_img) = fearMaleTexture{randi([1 size(fearMaleTexture,2)])};
                neutralMale(nb_img) = neutralMaleTexture{randi([1 size(neutralMaleTexture,2)])};
            end
            
            % Start Time
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            startTime = Screen('Flip', window);
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
  
            while GetSecs - startTime < vs.trialTimeout
                [~,~,keyCode] = KbCheck;
                respTime = GetSecs;
                
                % ESC key quits the experiment
                if keyCode(KbName('ESCAPE')) == 1
                    close all
                    sca
                    return;
                end
                
                % Get the current position of the mouse
                [mx, my, buttons] = GetMouse(window);
                
                for i = 1: size(posFF,1)
                    Screen('DrawTexture', window, fearFem(i), [], posFF(i,:), orientFF(i));
                    insideFF = IsInRect(mx, my, posFF(i,:));
                    if insideFF == 1 && sum(buttons) == 1 && offsetSet == 0
                        respFF = respFF + 1;
                        response = [response 1];
                        posRect = [posRect ; [posFF(i,1)-35, posFF(i,2)-35,posFF(i,3)+35,posFF(i,4)+35]];
                        offsetSet = 1;
                        continue  
                    end
                end
                
                for j = 1: size(posNF,1)
                    Screen('DrawTexture', window, neutralFem(j), [], posNF(j,:),orientNF(j));
                    insideNF = IsInRect(mx, my, posNF(j,:));
                    if insideNF == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNF = respNF + 1;
                        response = [response 2];
                        posRect = [posRect ; [posNF(j,1)-35, posNF(j,2)-35,posNF(j,3)+35,posNF(j,4)+35]];
                        offsetSet = 1;
                        continue
                    end
                end
                
                for y = 1: size(posFM,1)
                    Screen('DrawTexture', window, fearMale(y), [], posFM(y,:),orientFM(y));
                    insideFM = IsInRect(mx, my, posFM(y,:));
                    if insideFM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respFM = respFM + 1;
                        response = [response 3];
                        posRect = [posRect ; [posFM(y,1)-35, posFM(y,2)-35,posFM(y,3)+35,posFM(y,4)+35]];
                        offsetSet = 1;
                        continue
                    end
                end
                
                for z = 1: size(posNM,1)
                    Screen('DrawTexture', window, neutralMale(z), [], posNM(z,:),orientNM(z));
                    insideNM = IsInRect(mx, my, posNM(z,:));
                    if insideNM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNM = respNM + 1;
                        response = [response 4];
                        posRect = [posRect ; [posNM(z,1)-35, posNM(z,2)-35,posNM(z,3)+35,posNM(z,4)+35]];
                        offsetSet = 1;
                        continue
                    end
                end
                
                %Screenshot(window,'exp_images/visual_search_shot.jpg','jpg');
                % Make the selected images disapear (white square over them) 
                if posRect                
                    Screen('FillRect', window, white , posRect');
                end
                
                % Stops when participants click on the nb of targets 
                if length(response) == vs.setSize/2
                    rt = respTime - startTime;
                    break
                end
                
                % Flips screen
                Screen('DrawTexture', window, imgRwd, [], posRwd);
                Screen('DrawDots', window, [mx my], 15, [1 0 0], [], 1);
                Screen('Flip', window);
                
                % Release the button
                if sum(buttons) <= 0
                    offsetSet = 0;
                end
                
            end
            
            % Save data 
            respMatVS(a).cfg = vs;
            respMatVS(a).ID = ID;
            respMatVS(a).training = training;
            respMatVS(a).reward = rwd; %(1 = Small reward, 2 = Large reward)
            respMatVS(a).condition = condition(block);  %(1 = DC, 3 = CC, 5 = BC)
            respMatVS(a).block = block;
            respMatVS(a).trial = trial;
            respMatVS(a).RTs = rt;
            respMatVS(a).instr = text;
            respMatVS(a).order = response;
            respMatVS(a).respFF = respFF;
            respMatVS(a).respNF = respNF;
            respMatVS(a).respFM = respFM;
            respMatVS(a).respNM = respNM;
            respMatVS(a).posFF = posFF;
            respMatVS(a).posNF = posNF;
            respMatVS(a).posFM = posFM;
            respMatVS(a).posNM = posNM;
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            Screen('Flip', window);
            WaitSecs(vs.timeBetwTrial);
            
        end
    end
    
catch
    sca;
    fprintf('The last error in the visual search was : \n');
    psychrethrow(psychlasterror);
    
end
end