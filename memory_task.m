function [respMatMemory] = memory_task(ID, window, colors, screenPixels, training, stimuli)

try
    %% Initialise screen
    
    % Colors according to the screen
    white = colors(1);
    black = colors(2);
    
    % Get the size and centre of the window in pixels
    screenXpixels = screenPixels(1);
    screenYpixels = screenPixels(2);
    xCenter = screenXpixels/2;
    yCenter = screenYpixels/2;
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    %% Mouse position and keys
    HideCursor;
    
    % Define the available keys to press
    escapeKey = KbName('ESCAPE');
    spaceKey = KbName('space');
    
    % Response Keys
    femKey = KbName('f');
    hommeKey = KbName('h');
    
    % The only keys that will work to continue
    KbCheckList = [escapeKey, spaceKey, femKey, hommeKey];
    RestrictKeysForKbCheck(KbCheckList);
    
    %% Timing Information
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
                
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    
    settings_memory;
    
    %% Create Positions for the Faces
    % Use meshgrid to create equally spaced coordinates in the X and Y
    
    nx = 5; % number of images in the x-axis
    ny = 4; % number of images on the y-axis
    dx = (0.8/nx);
    dy = (0.8/ny);
    [x, y] = meshgrid(0.1:dx:(0.9-dx), (0.1:dy:(0.9-dy)));
    
    % Scale the grid so that it is in pixel coordinates
    pixelScaleX = screenXpixels / (dx*2.5)-100;
    pixelScaleY = screenYpixels / (dy*2); % change this to 2 if 4 img of y
    x = x .* pixelScaleX;
    y = y .* pixelScaleY;
    
    numPosition = numel(x);
    
    % The matrix of positions for the dots.
    positionMatrix = [reshape(ceil(x), 1, numPosition); reshape(ceil(y), 1, numPosition)];
    
    %% Training or not
    
    if training
        nBlocks = memory.nBlocksTrain;
        nTrials = memory.nTrialsTrain;
        
        % Randomised order of trials from mixed conditions 
        % condition = [Shuffle(1:6), Shuffle(1:6)];
        
        % Randomised order of condition blocks  
        condition = zeros(nBlocks,nTrials);
        for i = 1:nBlocks
            condition(i,:) = cell2mat(Shuffle({ones(1,nTrials/6), repmat(2,1,nTrials/6), repmat(3,1,nTrials/6), ...
                repmat(4,1,nTrials/6), repmat(5,1,nTrials/6), repmat(6,1,nTrials/6)}));
        end 
        
        for i = 14:15
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
    else
        nBlocks = memory.nBlocksExp;
        nTrials = memory.nTrialsExp;
        
%         % Randomised order of trials from mixed conditions 
%         condition = zeros(nBlocks,nTrials*6);
%         for i = 1:nBlocks
%             condition(i,:) = Shuffle(repmat((1:6),1,nTrials));
%         end
        
        % Randomised order of condition blocks  
        condition = zeros(nBlocks,nTrials);
        for i = 1:nBlocks
            condition(i,:) = cell2mat(Shuffle({ones(1,nTrials/6), repmat(2,1,nTrials/6), repmat(3,1,nTrials/6), ...
                repmat(4,1,nTrials/6), repmat(5,1,nTrials/6), repmat(6,1,nTrials/6)}));
        end 
        
        for i = 17
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
    end
      
    %% Actual Experiemen
    a = 0;
    
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
                        
            % Initialise response
            a = a + 1;
            rt = 0;
            response = [];
            
            % Draw fixation cross
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            flipTime = Screen('Flip', window);
            Screen('Flip', window, flipTime + memory.fixationDuration - ifi, 0);
            
            if condition(block,trial) == 1 % DC_male
                probaFF = 1 - memory.fearfulDC;
                probaNF = 1 - memory.neutralDC;
                probaFM = memory.fearfulDC;
                probaNM = memory.neutralDC;
                
            elseif condition(block,trial) == 2 % DC_fem
                probaFF = memory.fearfulDC;
                probaNF = memory.neutralDC;
                probaFM = 1 - memory.fearfulDC;
                probaNM = 1 - memory.neutralDC;
                
            elseif condition(block,trial) == 3 % CC_male
                probaFF = 1 - memory.fearfulCC;
                probaNF = 1 - memory.neutralCC;
                probaFM = memory.fearfulCC;
                probaNM = memory.neutralCC;
                
            elseif condition(block,trial) == 4 % CC_female
                probaFF = memory.fearfulCC;
                probaNF = memory.neutralCC;
                probaFM = 1 - memory.fearfulCC;
                probaNM = 1 - memory.neutralCC;
                
            elseif condition(block,trial) == 5 % BC_male
                probaFF = 1 - memory.fearfulBC;
                probaNF = 1 - memory.neutralBC;
                probaFM = memory.fearfulBC;
                probaNM = memory.neutralBC;
                
            elseif condition(block,trial) == 6 % BC_fem
                probaFF = memory.fearfulBC;
                probaNF = memory.neutralBC;
                probaFM = 1 - memory.fearfulBC;
                probaNM = 1 - memory.neutralBC;
            end
            
            setSizeFF = ceil(memory.setSize/2 * probaFF);
            setSizeNF = ceil(memory.setSize/2 * probaNF);
            setSizeFM = ceil(memory.setSize/2 * probaFM);
            setSizeNM = ceil(memory.setSize/2 * probaNM);
            
            %Create position and orientation for search display (change every trial)
            [posFF, posNF, posFM, posNM ] = createPositionsMemory(positionMatrix, ...
                memory.setSize,setSizeFF, setSizeNF, setSizeFM, setSizeNM, stimuli.sizeImgMemory);
            
            % Save pos for eye-tracking (is it really useful ?) 
            respMatMemory(a).posFF = posFF;
            respMatMemory(a).posNF = posNF;
            respMatMemory(a).posFM = posFM;
            respMatMemory(a).posNM = posNM;
            
            % Select new faces
            fearFem = [stimuli.fearFemMemory{randi([1 size(stimuli.fearFemMemory,2)],1,setSizeFF)}];
            neutralFem = [stimuli.neutralFemMemory{randi([1 size(stimuli.neutralFemMemory,2)],1,setSizeNF)}];
            fearMale= [stimuli.fearMaleMemory{randi([1 size(stimuli.fearMaleMemory,2)],1,setSizeFM)}];
            neutralMale = [stimuli.neutralMaleMemory{randi([1 size(stimuli.neutralMaleMemory,2)],1,setSizeNM)}];
            
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
            
            faces = {fearFem, neutralFem, fearMale, neutralMale};
            faces_pos = {posFF, posNF, posFM, posNM};
            
            for nb_faces = 1:length(faces)
                for nb_img = 1: size(faces_pos{nb_faces},1)
                    Screen('DrawTexture', window, faces{nb_faces}(nb_img), [], faces_pos{nb_faces}(nb_img,:));
                end
            end
              
            Screen('Flip', window);
            %Screenshot(window,'exp_images/memory_shot.jpg','jpg');
            Screen('Flip', window, flipTime + memory.imageDuration - ifi,0);
            
            Screen(window, 'FillRect', white);
            Screen('DrawTexture', window, imgRwd, [], posRwd);
            startTime = Screen('Flip', window, flipTime + memory.imageDuration - ifi,0);
            
            while GetSecs - startTime < memory.trialTimeout
                [~,~,keyCode] = KbCheck;
                respTime = GetSecs;
                
                Screen('DrawTexture', window, stimuli.instTexture{18},[],stimuli.instPos,0);
                Screen('DrawTexture', window, imgRwd, [], posRwd);
                Screen('Flip', window);
                
                % Check for response keys (ESC key quits)
                if keyCode(escapeKey) == 1
                    sca
                    return;
                elseif keyCode(femKey) == 1
                    response = 1;
                    rt = respTime - startTime;
                elseif keyCode(hommeKey) == 1
                    response = 2;
                    rt = respTime - startTime;
                end
                
                %Exit loop once a response is recorded
                if rt > 0
                    break;
                end
                
            end
            
            % Save data
            respMatMemory(a).cfg = memory;
            respMatMemory(a).ID = ID;
            respMatMemory(a).training = training;  %(1 = training, 0 = no training)
            respMatMemory(a).reward = rwd; %(0 = training, 1 = Small reward, 2 = Large reward)
            respMatMemory(a).condition = condition(block,trial); % (1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
            respMatMemory(a).block = block;
            respMatMemory(a).trial = trial;
            respMatMemory(a).RTs = rt;
            respMatMemory(a).response = response; % (1 = femKey/f; 2=hommeKey/h)
            respMatMemory(a).setSizeFF = setSizeFF;
            respMatMemory(a).setSizeNF = setSizeNF ;
            respMatMemory(a).setSizeFM = setSizeFM ;
            respMatMemory(a).setSizeNM = setSizeNM; 
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('Flip', window);
            WaitSecs(memory.timeBetweenTrials);
            
        end
    end
    
    if training
                
        Screen('DrawTexture', window, stimuli.instTexture{16},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
                
        Screen('DrawTexture', window, stimuli.instTexture{19},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    end
    
catch
    sca;
    fprintf('The last error in the visual search was : \n');
    psychrethrow(psychlasterror);
    
end
end