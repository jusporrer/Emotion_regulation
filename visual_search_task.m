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
    
    %% Timing Information
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    %% Defines the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 30);
    
    text_experiment;
    
    %% Download the images
    
    load('exp_images/WMN_img_vs.mat','WMN_img_vs');
    load('exp_images/WMF_img_vs.mat','WMF_img_vs');
    load('exp_images/WFN_img_vs.mat','WFN_img_vs');
    load('exp_images/WFF_img_vs.mat','WFF_img_vs');
    
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, ...
        sizeImg] = createImageTexture(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs,window);
    
    sizeImg = size(WMN_img_vs{1});
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % vs.nTrialsExp, vs.nTrialsTrain, vs.setSize, targSetSize, distSetSize, ...
    % vs.nBlocksExp, vs.nBlocksTrain, breakAfterTrials, ...
    % vs.trialTimeout, vs.timeBetwTrial
    
    settings_visual_search;
    respMatVS.cfg = vs;
    
    %% Create Condition Matrix
    % Condition (1 = DC, 3 = CC, 5 = BC)
    
    % created in the training part
    
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
    
    %% Training or not
    
    if training
        nBlocks = vs.nBlocksTrain;
        nTrials = vs.nTrialsTrain;
        condition = ones(1,6); % the only condition for training
        
        DrawFormattedText(window, instVS1, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, instVS2, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, trainVS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
        nBlocks = vs.nBlocksExp;
        nTrials = vs.nTrialsExp;
        
        % Complete shuffle
        % condition = Shuffle(repmat([1:6],1,2));
        % Semi shuffle for LR and HR
        condition = [Shuffle(1:2:6), Shuffle(1:2:6)];
        
        DrawFormattedText(window, trainingFiniVS, 'center', 'center', black);
        DrawFormattedText(window, question, 'center', screenYpixels*0.7, black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, VS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
    end
      
    %% Actual Experiment
    a = 0;
    
    for block = 1:nBlocks
        
        
        if condition(block) == 1
            text = DC_VS;
        elseif condition(block) == 3
            text = CC_fem_VS;
        elseif condition(block) == 4 %% Need to add between subjects if loop 
            text = CC_male_VS;
        elseif condition(block) == 5
            text = BC_VS;
        end
        Screen('TextSize', window, 50);
        DrawFormattedText(window, text , 'center', 'center', black);
        Screen('TextSize', window, 30);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        for trial = 1:nTrials
            
            % Set the position of the mouse in the center every trial
            SetMouse(xCenter, yCenter, window);
            
            % Initialise response
            a = a + 1;
            rt = 0;
            response = [];
            respFF = 0; respNF = 0;
            respFM = 0; respNM = 0;
            
            % Draw fixation cross
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            tFixation = Screen('Flip', window);
            Screen('Flip', window, tFixation + vs.fixationDuration - ifi, 0);
            
            %Create position and orientation for search display (change every trial)
            [posFF, posNF, posFM, posNM, ...
                orientFF, orientNF, orientFM, orientNM ] = ...
                createPositions(positionMatrix, vs.setSize, sizeImg);
            
            % Save pos for eye-tracking 
            respMatVS(a).posFF = posFF;
            respMatVS(a).posNF = posNF;
            respMatVS(a).posFM = posFM;
            respMatVS(a).posNM = posNM;
            
%             img = createSearchDisplay(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs, vs.setSize,...
%                 posFF,posNF, posFM, posNM, screenXpixels,screenYpixels);
%             
%             % Calculate image position (center of the screen)
%             displaySize = size(img);
%              posCenter = [(screenXpixels-displaySize(2))/2 (screenYpixels-displaySize(1))/2 (screenXpixels+displaySize(2))/2 (screenYpixels+displaySize(1))/2];
%             imageDisplay = Screen('MakeTexture', window, img);
%             Screen('DrawTexture', window, imageDisplay, [], posCenter);
%             Screen('Flip', window);
%             KbStrokeWait;
            
            % Initialise
            fearFem = zeros(1,vs.imgSetSize); neutralFem = zeros(1,vs.imgSetSize);
            fearMale = zeros(1,vs.imgSetSize); neutralMale = zeros(1,vs.imgSetSize);
            
            % Select vs.setSize/4 new faces
            for nb_img = 1: vs.imgSetSize
                fearFem(nb_img) = fearFemTexture{randi([1 size(fearFemTexture,2)])};
                neutralFem(nb_img) = neutralFemTexture{randi([1 size(neutralFemTexture,2)])};
                fearMale(nb_img) = fearMaleTexture{randi([1 size(fearMaleTexture,2)])};
                neutralMale(nb_img) = neutralMaleTexture{randi([1 size(neutralMaleTexture,2)])};
            end
            
            % Start Time
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
                        posFF(i,:) = [];
                        orientFF(i) = [];
                        fearFem(i) = [];
                        offsetSet = 1;
                        break
                    end
                end
                
                for j = 1: size(posNF,1)
                    Screen('DrawTexture', window, neutralFem(j), [], posNF(j,:),orientNF(j));
                    insideNF = IsInRect(mx, my, posNF(j,:));
                    if insideNF == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNF = respNF + 1;
                        response = [response 2];
                        posNF(j,:) = [];
                        orientNF(j) = [];
                        neutralFem(j) = [];
                        offsetSet = 1;
                        break
                    end
                end
                
                for y = 1: size(posFM,1)
                    Screen('DrawTexture', window, fearMale(y), [], posFM(y,:),orientFM(y));
                    insideFM = IsInRect(mx, my, posFM(y,:));
                    if insideFM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respFM = respFM + 1;
                        response = [response 3];
                        posFM(y,:) = [];
                        orientFM(y) = [];
                        fearMale(y) = [];
                        offsetSet = 1;
                        break
                    end
                end
                
                for z = 1: size(posNM,1)
                    Screen('DrawTexture', window, neutralMale(z), [], posNM(z,:),orientNM(z));
                    insideNM = IsInRect(mx, my, posNM(z,:));
                    if insideNM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNM = respNM + 1;
                        response = [response 4];
                        posNM(z,:) = [];
                        orientNM(z) = [];
                        neutralMale(z) = [];
                        offsetSet = 1;
                        break
                    end
                end
                
                % if the participant clicks the right number it stops
                if length(response) == vs.setSize/2
                    rt = respTime - startTime;
                    break
                end
                
                % Flip to the screen
                Screen('DrawDots', window, [mx my], 15, [1 0 0], [], 1);
                Screen('Flip', window);
                
                % Release the button
                if sum(buttons) <= 0
                    offsetSet = 0;
                end
                
            end
            
            % Save data 
            respMatVS(a).ID = ID;
            respMatVS(a).training = training;
            %respMatVS(a).reward = reward; %(0 = Small reward, 1 = Large reward)
            respMatVS(a).condition = condition(block); %(0 = DC, 1 = CC, 2 = BC)
            respMatVS(a).block = block;
            respMatVS(a).trial = trial;
            respMatVS(a).RTs = rt;
            respMatVS(a).order = response;
            respMatVS(a).respFF = respFF;
            respMatVS(a).respNF = respNF;
            respMatVS(a).respFM = respFM;
            respMatVS(a).respNM = respNM;
            
            % Screen after trial
            Screen('FillRect', window, white);
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