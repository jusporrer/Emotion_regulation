function [respMatMemory] = memory_task(ID, window, colors, screenPixels, training, stimuli)

try
    %% Initialise screen
    
    % Colors according to the screen
    white           = colors(1);
    black           = colors(2);
    
    % Get the size and centre of the window in pixels
    screenXpixels   = screenPixels(1);
    screenYpixels   = screenPixels(2);
    xCenter         = screenXpixels/2;
    yCenter         = screenYpixels/2;
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    %% Mouse position and keys
    HideCursor;
    
    % Define the available keys to press
    escapeKey       = KbName('ESCAPE');
    spaceKey        = KbName('space');
    
    % Response Keys
    femKey          = KbName('f');
    hommeKey        = KbName('h');
    
    % The only keys that will work to continue
    KbCheckList     = [escapeKey, spaceKey, femKey, hommeKey];
    RestrictKeysForKbCheck(KbCheckList);
    
    %% Timing Information
    
    % Query the frame duration
    ifi             = Screen('GetFlipInterval', window);
    
    %Interstimulus interval time in seconds and frames
    isiTimeSecs     = 1;
    isiTimeFrames   = round(isiTimeSecs / ifi);
    
    %Number of frames to wait before re-drawing
    waitframes      = 1;
    
    %% Fixation cross
    
    [CoordsFix, lineWidthFix] = create_fix_cross();
    
    %% Settings
    
    settings_memory;
    
    %% Create Positions for the Faces
    % Use meshgrid to create equally spaced coordinates in the X and Y
    
    nx              = 5; % number of images in the x-axis
    ny              = 4; % number of images on the y-axis
    dx              = (0.8/nx);
    dy              = (0.8/ny);
    [x, y]          = meshgrid(0.1:dx:(0.9-dx), (0.1:dy:(0.9-dy)));
    
    % Scale the grid so that it is in pixel coordinates
    pixelScaleX     = screenXpixels / (dx*2.5)-100;
    pixelScaleY     = screenYpixels / (dy*2); % change this to 2 if 4 img of y
    x               = x .* pixelScaleX;
    y               = y .* pixelScaleY;
    
    numPosition     = numel(x);
    
    % The matrix of positions for the dots.
    positionMatrix  = [reshape(ceil(x), 1, numPosition); reshape(ceil(y), 1, numPosition)];
    
    %% Training or not
    
    if training
        nBlocks     = memCfg.nBlocksTrain;
        nTrials     = memCfg.nTrialsTrain;
          
        for i = [16, 17, 3]
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
    else
        nBlocks     = memCfg.nBlocksExp;
        nTrials     = memCfg.nTrialsExp;
                                
        for i = 19
            Screen('DrawTexture', window, stimuli.instTexture{i},[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
    end
    
    %% Creation of condition matrix 
    
    condition   = zeros(nBlocks,nTrials);
    % 1,1 SR DCinst; 1,2 SR BCinst; 2,1 LR DCinst; 2,2 LR BCinst 
    condiRwd    = Shuffle([repmat({[1,1]},1,nBlocks/4), repmat({[1,2]},1,nBlocks/4), ...
        repmat({[2,1]},1,nBlocks/4), repmat({[2,2]},1,nBlocks/4)]);
    
    for i = 1:nBlocks
        condiCC    = repmat((3:4),1,nTrials/3);
        condiDC    = Shuffle([repmat((1:2),1,nTrials/3), condiCC(1:nTrials/3)]);
        condiBC    = Shuffle([(repmat((5:6),1,nTrials/3)), condiCC(nTrials/3+1:end)]);
        if condiRwd{i}(1) == 1
            condition(i,:) = condiDC;
        elseif condiRwd{i}(1) == 2
            condition(i,:) = condiBC;
        end
    end
    
    condition
    celldisp(condiRwd)
    
    %% Actual Experiemen
    a = 0;
    
    for block = 1:nBlocks
        
        if training
            imgRwd      = stimuli.smallRwd;
            imgInst     = stimuli.instDC; 
        else
            if condiRwd{block}(2)           == 1 % Small Rwd 
                if condiRwd{block}(1)       == 1 % DC condition
                    instRwd     = stimuli.instTexture{4};
                    imgInst     = stimuli.instDC; 
                elseif condiRwd{block}(1)   == 2 % BC condition 
                    instRwd     = stimuli.instTexture{5};
                    imgInst     = stimuli.instBC; 
                end
                imgRwd          = stimuli.smallRwd;
                
            elseif condiRwd{block}(2)       == 2 % large rwd 
                if condiRwd{block}(1)       == 1 % DC condition
                    instRwd     = stimuli.instTexture{6};
                    imgInst     = stimuli.instDC; 
                elseif condiRwd{block}(1)   == 2 % BC condition 
                    instRwd     = stimuli.instTexture{7};
                    imgInst     = stimuli.instBC; 
                end
                imgRwd          = stimuli.largeRwd;
            end
            
            Screen('DrawTexture', window, instRwd,[],stimuli.instPos,0);
            Screen('Flip', window);
            KbStrokeWait;
        end
        
        
        for trial = 1:nTrials
            
            % Initialise response
            a = a + 1;
            rt = 0;
            response = [];
            
            % Draw the fixation cross in black
            Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2);
            Screen('DrawTexture', window, imgInst, [], stimuli.posInst);
            Screen('DrawTexture', window, imgRwd, [], stimuli.posRwd);
            flipTime = Screen('Flip', window);
            
            for frame = 1:isiTimeFrames - 1
                Screen('DrawLines', window, CoordsFix, lineWidthFix, black, [xCenter yCenter], 2)
                Screen('DrawTexture', window, imgInst, [], stimuli.posInst);
                Screen('DrawTexture', window, imgRwd, [], stimuli.posRwd);
                flipTime = Screen('Flip', window, flipTime + (waitframes -0.5) * ifi);
            end
            
            if condition(block,trial)       == 1 % DC_male
                probaFF = 1 - memCfg.fearfulDC;
                probaNF = 1 - memCfg.neutralDC;
                probaFM = memCfg.fearfulDC;
                probaNM = memCfg.neutralDC;
                
            elseif condition(block,trial)   == 2 % DC_fem
                probaFF = memCfg.fearfulDC;
                probaNF = memCfg.neutralDC;
                probaFM = 1 - memCfg.fearfulDC;
                probaNM = 1 - memCfg.neutralDC;
                
            elseif condition(block,trial)   == 3 % CC_male
                probaFF = 1 - memCfg.fearfulCC;
                probaNF = 1 - memCfg.neutralCC;
                probaFM = memCfg.fearfulCC;
                probaNM = memCfg.neutralCC;
                
            elseif condition(block,trial)   == 4 % CC_female
                probaFF = memCfg.fearfulCC;
                probaNF = memCfg.neutralCC;
                probaFM = 1 - memCfg.fearfulCC;
                probaNM = 1 - memCfg.neutralCC;
                
            elseif condition(block,trial)   == 5 % BC_male
                probaFF = 1 - memCfg.fearfulBC;
                probaNF = 1 - memCfg.neutralBC;
                probaFM = memCfg.fearfulBC;
                probaNM = memCfg.neutralBC;
                
            elseif condition(block,trial)   == 6 % BC_fem
                probaFF = memCfg.fearfulBC;
                probaNF = memCfg.neutralBC;
                probaFM = 1 - memCfg.fearfulBC;
                probaNM = 1 - memCfg.neutralBC;
            end
            
            setSizeFF   = ceil(memCfg.setSize/2 * probaFF);
            setSizeNF   = ceil(memCfg.setSize/2 * probaNF);
            setSizeFM   = ceil(memCfg.setSize/2 * probaFM);
            setSizeNM   = ceil(memCfg.setSize/2 * probaNM);
            
            % Select new faces
            faces = createFaceArray(stimuli, setSizeFF, setSizeNF, setSizeFM, setSizeNM);
            
            %Create position and orientation for search display (change every trial)
            faces_pos = createPositionsMemory(positionMatrix, ...
                memCfg.setSize,setSizeFF, setSizeNF, setSizeFM, setSizeNM, stimuli.sizeImgMemory);
            
            % Save pos for eye-tracking (is it really useful ?)
            respMatMemory(a).posFF = faces_pos{1};
            respMatMemory(a).posNF = faces_pos{2};
            respMatMemory(a).posFM = faces_pos{3};
            respMatMemory(a).posNM = faces_pos{4};
                        
            % Screen priority
            Priority(MaxPriority(window));
            Priority(2);
                      
            for nb_faces = 1:length(faces)
                for nb_img = 1: size(faces_pos{nb_faces},1)
                    Screen('DrawTexture', window, faces{nb_faces}(nb_img), [], faces_pos{nb_faces}(nb_img,:));
                end
            end
            
            imageDuration = memCfg.imageDuration(randi(2)); 
            Screen('Flip', window);
            %Screenshot(window,'exp_images/memory_shot.jpg','jpg');
            Screen('Flip', window, flipTime + imageDuration - ifi,0);
            
            Screen(window, 'FillRect', white);
            Screen('DrawTexture', window, imgRwd, [], stimuli.posRwd);
            Screen('DrawTexture', window, imgInst, [], stimuli.posInst);
            startTime = Screen('Flip', window, flipTime + imageDuration - ifi,0);
            
            while GetSecs - startTime < memCfg.trialTimeout
                [~,~,keyCode] = KbCheck;
                respTime = GetSecs;
                
                Screen('DrawTexture', window, stimuli.instTexture{20},[],stimuli.instPos,0);
                Screen('DrawTexture', window, imgInst, [], stimuli.posInst);
                Screen('DrawTexture', window, imgRwd, [], stimuli.posRwd);
                Screen('Flip', window);
                
                % Check for response keys (ESC key quits)
                if keyCode(escapeKey) == 1
                    sca
                    return;
                elseif keyCode(femKey) == 1
                    response    = 1;
                    rt          = respTime - startTime;
                elseif keyCode(hommeKey) == 1
                    response    = 2;
                    rt          = respTime - startTime;
                end
                
                %Exit loop once a response is recorded
                if rt > 0
                    break;
                end
                
            end
            
            % Save data
            respMatMemory(a).cfg        = memCfg;
            respMatMemory(a).imgDur     = imageDuration;  
            respMatMemory(a).ID         = ID;
            respMatMemory(a).training   = training;  %(1 = training, 0 = no training)
            respMatMemory(a).reward     = condiRwd{block}(2); %(0 = training, 1 = Small reward, 2 = Large reward)
            respMatMemory(a).condition  = condition(block,trial); % (1 = DC_male, 2 = DC_female, 3 = CC_male, 4 = CC_female, 5 = BC_male , 6 = BC_female)
            respMatMemory(a).instCondit = condiRwd{block}(1); % (1 = DC inst, 2 = BC inst) 
            respMatMemory(a).block      = block;
            respMatMemory(a).trial      = trial;
            respMatMemory(a).RTs        = rt;
            respMatMemory(a).response   = response; % (1 = femKey/f; 2=hommeKey/h)
            respMatMemory(a).setSizeFF  = setSizeFF;
            respMatMemory(a).setSizeNF  = setSizeNF ;
            respMatMemory(a).setSizeFM  = setSizeFM ;
            respMatMemory(a).setSizeNM  = setSizeNM;
            
            % Screen after trial
            Screen('FillRect', window, white);
            Screen('DrawTexture', window, imgInst, [], stimuli.posInst);
            Screen('DrawTexture', window, imgRwd, [], stimuli.posRwd);
            Screen('Flip', window);
            WaitSecs(memCfg.timeBetweenTrials);
            
        end
    end
    
    if training
        
        Screen('DrawTexture', window, stimuli.instTexture{18},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    else
        
        Screen('DrawTexture', window, stimuli.instTexture{21},[],stimuli.instPos,0);
        Screen('Flip', window);
        KbStrokeWait;
        
    end
    
catch
    sca;
    fprintf('The last error in the memory task was : \n');
    psychrethrow(psychlasterror);
    
end
end