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
    Screen('TextSize', window, 60);
    
    text_experiment;
    
    %% Download the images
    
    load('exp_images/WMN_img_vs.mat','WMN_img_vs');
    load('exp_images/WMF_img_vs.mat','WMF_img_vs');
    load('exp_images/WFN_img_vs.mat','WFN_img_vs');
    load('exp_images/WFF_img_vs.mat','WFF_img_vs');
    
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, ...
        sizeImg] = createImageTexture(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs,window);
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % nTrialsExp, nTrialsTrain, setSize, targSetSize, distSetSize, ...
    % nBlocksExp, nBlocksTrain, breakAfterTrials, ...
    % trialTimeout, timeBetweenTrials
    
    settings_visual_search;
    
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
        nBlocks = nBlocksTrain;
        nTrials = nTrialsTrain;
        condition = ones(1,6); % the only condition for traning
        
        DrawFormattedText(window, trainVS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, instVS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
        nBlocks = nBlocksExp;
        nTrials = nTrialsExp;
        
        % Complete shuffle
        % condition = Shuffle(repmat([1:6],1,2));
        % Semi shuffle for LR and HR
        condition = [Shuffle(1:2:6), Shuffle(1:2:6)];
        
        DrawFormattedText(window, trainingFiniVS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
        
        DrawFormattedText(window, VS, 'center', 'center', black);
        DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
        Screen('Flip', window);
        KbStrokeWait;
    end
    
    respMatVS = nan(nTrials*nBlocks, length(respMatColumnsVS)); % but nan not recommened for VBA ?
    
    %% Actual Experiment
    line_save = 0;
    
    for block = 1:nBlocks
        
        if condition(block) == 1
            DrawFormattedText(window, DC_VS, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
            
        elseif condition(block) == 3
            DrawFormattedText(window, CC_fem_VS, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
            
        elseif condition(block) == 4
            DrawFormattedText(window, CC_male_VS, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
            
        elseif condition(block) == 5
            DrawFormattedText(window, BC_VS, 'center', 'center', black);
            DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , black);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
        for trial = 1:nTrials
            
            % Set the position of the mouse in the center every trial
            SetMouse(xCenter, yCenter, window);
            
            % Initialise response
            rt = 0;
            click = 0;
            responseFF = 0;
            responseNF = 0;
            responseFM = 0;
            responseNM = 0;
            
            % Draw fixation cross
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            tFixation = Screen('Flip', window);
            Screen('Flip', window, tFixation + fixationDuration - ifi, 0);
            
            %Create position and orientation for search display (change every trial)
            [fearFemPosition, neutralFemPosition, fearMalePosition, neutralMalePosition, ...
                fearFemOrient, neutralFemOrient, fearMaleOrient, neutralMaleOrient ] = ...
                createPositions(positionMatrix, setSize, sizeImg, screenXpixels, screenYpixels);
            
            % Initialise
            fearFemTrial = zeros(1,setSize/4); neutralFemTrial = zeros(1,setSize/4);
            fearMaleTrial = zeros(1,setSize/4); neutralMaleTrial = zeros(1,setSize/4);
            
            % Select setSize/4 new faces
            for nb_img = 1: setSize/4
                fearFemTrial(nb_img) = fearFemTexture{randi([1 size(fearFemTexture,2)])};
                neutralFemTrial(nb_img) = neutralFemTexture{randi([1 size(neutralFemTexture,2)])};
                fearMaleTrial(nb_img) = fearMaleTexture{randi([1 size(fearMaleTexture,2)])};
                neutralMaleTrial(nb_img) = neutralMaleTexture{randi([1 size(neutralMaleTexture,2)])};
            end
            
            % Start Time
            startTime = Screen('Flip', window);
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            while GetSecs - startTime < trialTimeout
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
                
                for i = 1: size(fearFemPosition,1)
                    Screen('DrawTexture', window, fearFemTrial(i), [], fearFemPosition(i,:), fearFemOrient(i));
                    fearFemInside = IsInRect(mx, my, fearFemPosition(i,:));
                    if fearFemInside == 1 && sum(buttons) == 1
                        responseFF = responseFF + 1;
                        click = click + 1;
                        fearFemPosition(i,:) = [];
                        fearFemOrient(i) = [];
                        fearFemTrial(i) = [];
                        break
                    end
                end
                
                for j = 1: size(neutralFemPosition,1)
                    Screen('DrawTexture', window, neutralFemTrial(j), [], neutralFemPosition(j,:),neutralFemOrient(j));
                    neutralFemInside = IsInRect(mx, my, neutralFemPosition(j,:));
                    if neutralFemInside == 1 && sum(buttons) == 1
                        responseNF = responseNF + 1;
                        click = click + 1;
                        neutralFemPosition(j,:) = [];
                        neutralFemOrient(j) = [];
                        neutralFemTrial(j) = [];
                        break
                    end
                end
                
                for y = 1: size(fearMalePosition,1)
                    Screen('DrawTexture', window, fearMaleTrial(y), [], fearMalePosition(y,:),fearMaleOrient(y));
                    fearMaleInside = IsInRect(mx, my, fearMalePosition(y,:));
                    if fearMaleInside == 1 && sum(buttons) == 1
                        responseFM = responseFM + 1;
                        click = click + 1;
                        fearMalePosition(y,:) = [];
                        fearMaleOrient(y) = [];
                        fearMaleTrial(y) = [];
                        break
                    end
                end
                
                for z = 1: size(neutralMalePosition,1)
                    Screen('DrawTexture', window, neutralMaleTrial(z), [], neutralMalePosition(z,:),neutralMaleOrient(z));
                    neutralMaleInside = IsInRect(mx, my, neutralMalePosition(z,:));
                    if neutralMaleInside == 1 && sum(buttons) == 1
                        responseNM = responseNM + 1;
                        click = click + 1;
                        neutralMalePosition(z,:) = [];
                        neutralMaleOrient(z) = [];
                        neutralMaleTrial(z) = [];
                        break
                    end
                end
                
                % if the participant clicks the right number it stops
                if click == setSize/2
                    rt = respTime - startTime;
                    break
                end
                
                % Flip to the screen
                Screen('DrawDots', window, [mx my], 15, [1 0 0], [], 1);
                Screen('Flip', window);
                
            end
            
            % Record the trial data into the data matrix
            line_save = line_save + 1;
            
            respMatVS(line_save,1) = ID;
            respMatVS(line_save,2) = training;
            %respMatVS(trial,3) = reward; % to implement
            respMatVS(trial,4) = condition(block);
            respMatVS(line_save,5) = trial;
            respMatVS(line_save,6) = block;
            respMatVS(line_save,7) = rt;
            respMatVS(line_save,8) = responseFF;
            respMatVS(line_save,9) = responseNF;
            respMatVS(line_save,10) = responseFM;
            respMatVS(line_save,11) = responseNM;
            %respMatVS(line_save,12) = fearFemPosition;
            %respMatVS(line_save,13) = neutralFemPosition;
            %respMatVS(line_save,14) = fearMalePosition;
            %respMatVS(line_save,15) = neutralMalePosition;
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('Flip', window);
            WaitSecs(timeBetweenTrials);
            
        end
    end
    
catch
    sca;
    fprintf('The last error in the visual search was : \n');
    psychrethrow(psychlasterror);
    
end
end