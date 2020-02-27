%function [respMat] = visual_search_task(ID, window, colors, screenPixels, coorCenter, training)

try
    %% Initialise screen
    Screen('Preference', 'SkipSyncTests', 1) % Need to be put to 0 when testing
    Screen('Preference', 'SuppressAllWarnings', 1)
    Screen('Preference','VisualDebugLevel', 0);  % supress start screen
    
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
    
    bienvenue = 'ESSAI Experience 1';
    continuer = 'Appuyez sur [espace] pour continuer';
    instructions = 'Vous devez ...';
    fini = 'Experience 1 est fini!';
    
    %% Download the images
    
    load('exp_images/WMN_img_vs.mat');
    load('exp_images/WMF_img_vs.mat');
    load('exp_images/WFN_img_vs.mat');
    load('exp_images/WFF_img_vs.mat');
    
    [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, ...
        sizeImg] = createImageTexture(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs,window);
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    % nTrialsExp, nTrialsTrain, setSize, targSetSize, distSetSize, ...
    % nBlocksExp, nBlocksTrain, vs.breakAfterTrials, ...
    % trialTimeout, timeBetweenTrials
    
    settings_visual_search;
    
    %% Create Condition Matrix
    % Condition (0 = DC, 1 = CC, 2 = BC)
    
    % condiMat =
    
    %% Create Positions for the Faces
    % Use meshgrid to create equally spaced coordinates in the X and Y
    
    nx = 4; % number of images in the x-axis
    ny = 4; % number of images on the y-axis
    dx = (0.8/nx);
    dy = (0.8/ny);
    [x, y] = meshgrid(0.1:dx:(0.9-dx), (0.1:dy:(0.9-dy)));
    
    % Scale the grid so that it is in pixel coordinates
    pixelScaleX = screenXpixels / (dx*2);
    pixelScaleY = screenYpixels / (dy*2); % change this to 2 if 4 img of y
    x = x .* pixelScaleX;
    y = y .* pixelScaleY;
    
    numPosition = numel(x);
    
    % The matrix of positions for the dots.
    positionMatrix = [reshape(ceil(x), 1, numPosition); reshape(ceil(y), 1, numPosition)];
    
    %% Training or not
    
    nBlocks = vs.nBlocksExp;
    nTrials = vs.nTrialsExp;
    
    %respMatVS = nan(nTrials*nBlocks, length(respMatColumnsVS)); % but nan not recommened for VBA ?
    
    a = 0;
    
    for block = 1:nBlocks
        
               
        for trial = 1:nTrials
            
            % Set the position of the mouse in the center every trial
            SetMouse(xCenter, yCenter, window);
            
            % Initialise response
            a = a + 1;
            rt = 0;
            posRect = []; orientRect = [];
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
%             posCenter = [(screenXpixels-displaySize(2))/2 (screenYpixels-displaySize(1))/2 (screenXpixels+displaySize(2))/2 (screenYpixels+displaySize(1))/2];
%             imageDisplay = Screen('MakeTexture', window, img);
%             Screen(window, 'FillRect', white);
%             Screen('DrawTexture', window, imageDisplay, [], posCenter);
%             Screen('Flip', window);
%             KbStrokeWait;
            
            % Initialise
            fearFemEXP = zeros(1,vs.setSize/4); neutralFemEXP = zeros(1,vs.setSize/4);
            fearMaleEXP = zeros(1,vs.setSize/4); neutralMaleEXP = zeros(1,vs.setSize/4);
            
            % Select vs.setSize/4 new faces
            for nb_img = 1: vs.setSize/4
                fearFemEXP(nb_img) = fearFemTexture{randi([1 size(fearFemTexture,2)])};
                neutralFemEXP(nb_img) = neutralFemTexture{randi([1 size(neutralFemTexture,2)])};
                fearMaleEXP(nb_img) = fearMaleTexture{randi([1 size(fearMaleTexture,2)])};
                neutralMaleEXP(nb_img) = neutralMaleTexture{randi([1 size(neutralMaleTexture,2)])};
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
                    Screen('DrawTexture', window, fearFemEXP(i), [], posFF(i,:), orientFF(i));
                    insideFF = IsInRect(mx, my, posFF(i,:));
                    if insideFF == 1 && sum(buttons) == 1 && offsetSet == 0
                        respFF = respFF + 1;
                        response = [response 1];
                        posRect = [posRect ; [posFF(i,1)-15, posFF(i,2)-15,posFF(i,3)+15,posFF(i,4)+15]];
                        orientRect = [orientRect ; orientFF(i)];
                        offsetSet = 1;
                        continue
                    end
                end
                
                for j = 1: size(posNF,1)
                    Screen('DrawTexture', window, neutralFemEXP(j), [], posNF(j,:),orientNF(j));
                    insideNF = IsInRect(mx, my, posNF(j,:));
                    if insideNF == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNF = respNF + 1;
                        response = [response 2];
                        posRect = [posRect ; [posNF(j,1)-15, posNF(j,2)-15,posNF(j,3)+15,posNF(j,4)+15]];
                        orientRect = [orientRect ; orientNF(j)];
                        offsetSet = 1;
                        continue
                    end
                end
                
                for y = 1: size(posFM,1)
                    Screen('DrawTexture', window, fearMaleEXP(y), [], posFM(y,:),orientFM(y));
                    insideFM = IsInRect(mx, my, posFM(y,:));
                    if insideFM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respFM = respFM + 1;
                        response = [response 3];
                        posRect = [posRect ; [posFM(y,1)-15, posFM(y,2)-15,posFM(y,3)+15,posFM(y,4)+15]];
                        orientRect = [orientRect ; orientFM(y)];
                        offsetSet = 1;
                        continue
                    end
                end
                
                for z = 1: size(posNM,1)
                    Screen('DrawTexture', window, neutralMaleEXP(z), [], posNM(z,:),orientNM(z));
                    insideNM = IsInRect(mx, my, posNM(z,:));
                    if insideNM == 1 && sum(buttons) == 1 && offsetSet == 0
                        respNM = respNM + 1;
                        response = [response 4];
                        posRect = [posRect ; [posNM(z,1)-15, posNM(z,2)-15,posNM(z,3)+15,posNM(z,4)+15]];
                        orientRect = [orientRect ; orientNM(z)];
                        offsetSet = 1;
                        continue
                    end
                end
                
                if posRect
                    Screen('FillRect', window, white , posRect');
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
            %respMatVS(a).ID = ID;
            %respMatVS(a).training = training;
            %respMatVS(a).reward = reward; %(0 = Small reward, 1 = Large reward)
            %respMatVS(a).condition = condition(block); %(0 = DC, 1 = CC, 2 = BC)
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