function [respMatVS] = visual_search_task(ID, window, colors, screenPixels, coorCenter, training)

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
    
    %% Timing Information
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    % Interstimulus interval time in seconds and frames
    isiTimeSecs = 1;
    isiTimeFrames = round(isiTimeSecs / ifi);
    
    % Numer of frames to wait before re-drawing
    waitframes = 1;
    
    %% Defines the text
    Screen('TextFont',window, 'Calibri');
    Screen('TextSize', window, 60);
    
    %% Download the images
    
    % Get the image files for the experiment
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, sizeImg] = createImageTexture(window); 
      
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % nTrialsExp, nTrialsTrain, setSize, targSetSize, distSetSize, ...
    % nBlocksExp, nBlocksTrain, breakAfterTrials, ...
    % trialTimeout, timeBetweenTrials
    
    settings_visual_search;
    
    %% Create Response Matrix
    
    % This is a X column matrix:
    % 1st column: ID
    % 2nd column: Condition (1 = BC, 0 = CC,-1 = DC)
    % 3rd column: Nb Block
    % 4th column: Nb Trial
    % 5th column: RTs
    % 6th column: Response
    
    respMatColumns = ["ID", "Condition", "Nb Block","Nb Trial", "RTs", "Response"];
    
    respMatVS = nan(nTrialsExp*nBlocksExp, length(respMatColumns)); % but nan not recommened for VBA ?
    
    %% Create Positions for the Faces
    % Use meshgrid to create equally spaced coordinates in the X and Y
    dim = 0.01;
    [x, y] = meshgrid((-dim-3):1:(dim+3), (-dim-1.5):1:(dim+1.5));
    
    % Scale the grid so that it is in pixel coordinates. We just scale it by the screen size so that it will fit.
    pixelScale = screenYpixels / (dim * 2 + 2);
    x = x .* pixelScale;
    y = y .* pixelScale;
    
    numPosition = numel(x);
    
    % The matrix of positions for the dots.
    positionMatrix = [reshape(ceil(x), 1, numPosition); reshape(ceil(y), 1, numPosition)];
    
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
            
            % Set the position of the mouse in the center every trial
            SetMouse(xCenter, yCenter, window);
            
            % Initialise response
            rt = 0;
            response = 0;
            
            % Draw the fixation cross in white
            Screen('DrawLines', window, CoordsFix, lineWidthFix, white, [xCenter yCenter], 2);
            tFixation = Screen('Flip', window);
            Screen('Flip', window, tFixation + fixationDuration - ifi, 0);
            
            %Create the position for search display (changed every trial)
            [fearFemPosition, neutralFemPosition, fearMalePosition, neutralMalePosition, imgPositionsRand]= createPositions(positionMatrix, setSize, sizeImg, screenXpixels, screenYpixels);
          
            startTime = Screen('Flip', window);
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            while GetSecs - startTime < trialTimeout
                [keyIsDown,secs,keyCode] = KbCheck;
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
                    Screen('DrawTexture', window, fearFemTexture, [], fearFemPosition(i,:));
                    fearFemInside = IsInRect(mx, my, fearFemPosition(i,:));
                    if fearFemInside == 1 && sum(buttons) == 1
                        response = response + 1;
                        fearFemPosition(i,:) = [];
                        break
                    end
                end
                
                for j = 1: size(neutralFemPosition,1)
                    Screen('DrawTexture', window, neutralFemTexture, [], neutralFemPosition(j,:));
                    neutralFemInside = IsInRect(mx, my, neutralFemPosition(j,:));
                    if neutralFemInside == 1 && sum(buttons) == 1
                        response = response + 1;
                        neutralFemPosition(j,:) = [];
                        break
                    end
                end
                
                for y = 1: size(fearMalePosition,1)
                    Screen('DrawTexture', window, fearMaleTexture, [], fearMalePosition(y,:)); % imagPositionsRand(ceil(4*rand))
                    fearMaleInside = IsInRect(mx, my, fearMalePosition(y,:));
                    if fearMaleInside == 1 && sum(buttons) == 1
                        response = response - 1;
                        display(response)
                        fearMalePosition(y,:) = [];
                        break
                    end
                end
                for z = 1: size(neutralMalePosition,1)
                    Screen('DrawTexture', window, neutralMaleTexture, [], neutralMalePosition(z,:)); % imagPositionsRand(ceil(4*rand))
                    neutralMaleInside = IsInRect(mx, my, neutralMalePosition(z,:));
                    if neutralMaleInside == 1 && sum(buttons) == 1
                        response = response - 1;
                        display(response)
                        neutralMalePosition(z,:) = [];
                        break
                    end
                end
                
                % Flip to the screen
                Screen('DrawDots', window, [mx my], 15, [1 0 0], [], 1);
                Screen('Flip', window);
                
            end
            
            % Record the trial data into the data matrix
            respMatVS(trial,1) = ID;
            %respMat(trial,2) = condition; % to implement
            respMatVS(trial,3) = trial;
            respMatVS(trial,4) = block;
            respMatVS(trial,5) = rt;
            respMatVS(trial,6) = response;
            
            % Screen after trial
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            WaitSecs(timeBetweenTrials);
            
        end
    end
    
    %% End of experiment
    %     DrawFormattedText(window, fini, 'center', 'center', white);
    %
    %     DrawFormattedText(window, continuer, 'center', screenYpixels*0.9 , white);
    %     Screen('Flip', window);
    %     KbStrokeWait;
    
    %save('response.mat','respMat')
    
    % Screen CloseAll
    % sca;
    
catch
    sca;
    fprintf('The last error in the visual search was : \n');
    psychrethrow(psychlasterror);
    
end
end