function [mem]    = Individual_Analysis_mem_img(ID, fig)

%ID                              =  90255;
%fig                             = true; 

%% =================== Load the data                    ===================
resp_folder     = '../results';

resp_memory       = [num2str(ID),'_memory.mat'];

resp_file_memory  = fullfile(resp_folder,resp_memory);

load(resp_file_memory,'data_memory');

if ~isfile(resp_file_memory)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% =================== Initialise                       ===================

cfg_training                    = data_memory(1).cfg;
nTrain                          = cfg_training.nTrialsTrain * cfg_training.nBlocksTrain;
cfg_exp                         = data_memory(nTrain+1).cfg;
imageDuration                   = [data_memory(nTrain+1:end).imgDur];
reward                          = [data_memory(nTrain+1:end).reward];
condition                       = [data_memory(nTrain+1:end).condition];
instCondit                      = [data_memory(nTrain+1:end).instCondit];
block                           = [data_memory(nTrain+1:end).block];
trial                           = [data_memory(nTrain+1:end).trial];
rt                              = [data_memory(nTrain+1:end).RTs];
response                        = [data_memory(nTrain+1:end).response];
setSizeFF                       = [data_memory(nTrain+1:end).setSizeFF];
setSizeNF                       = [data_memory(nTrain+1:end).setSizeNF];
setSizeFM                       = [data_memory(nTrain+1:end).setSizeFM];
setSizeNM                       = [data_memory(nTrain+1:end).setSizeNM];

%% =================== Basic Information                ===================

nTrial                          = 1:length(trial); % allows the indexing

disp(['There were ',num2str(length(trial)), ' trials']);

%% =================== Exclude 3 STD RTs                ===================

rt                              = (rt(nTrial));
mean_RtExp                      = mean(rt) ;
std_RtExp                       = std(rt)*3 ;

% Recalculate nTrial with only non-outlier RT trials
low_RtExp                       = mean_RtExp-std_RtExp ;
up_RtExp                        = mean_RtExp+std_RtExp ;

kept_RtExp                      = intersect(find(rt(nTrial) > low_RtExp), find(rt(nTrial) < up_RtExp));
excl_RtExp                      = [find(rt(nTrial) < low_RtExp) find(rt(nTrial) > up_RtExp)];

mem.nExcTrial                  = length(excl_RtExp);

if ID == 81477
    kept_RtExp(31) = [];
end

nTrial                          = nTrial(kept_RtExp);
mem.rt                         = log(rt(nTrial));
rt                              = log(rt(nTrial));
block                           = block(nTrial);

if length(nTrial) < length(trial)
    disp(['RTs warning : ',num2str(length(excl_RtExp)), ...
        ' trial(s) had to be excluded because the RTs were over or under 3 STD']);
end

%% =================== Performance - Duration           ===================

imgShort                        = (imageDuration(nTrial) == 1.5);
mem.nimgShort                   = sum(imgShort);

imgLong                         = (imageDuration(nTrial) == 2);
mem.nimgLong                    = sum(imgLong);

disp(['Distribution : ',num2str(mem.nimgShort), ' short trials & ', ...
    num2str(mem.nimgLong), ' long trials' ]);

%% =================== Performance - Correct Short      ===================

correct_Fem_short               = imgShort & (response(nTrial) == 1 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));
incorrect_Fem_short             = imgShort & (response(nTrial) == 2 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));

correct_Hom_short               = imgShort & (response(nTrial) == 2 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));
incorrect_Hom_short             = imgShort & (response(nTrial) == 1 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));

% Sum of all the trials
correct_short                   = (correct_Fem_short + correct_Hom_short);
incorrect_short                 = (incorrect_Fem_short + incorrect_Hom_short);

nCorrect_short                  = sum(correct_short);
nIncorrect_short                = sum(incorrect_short);

% General performance
mem.performance_short           = nCorrect_short /(mem.nimgShort)*100;
mem.perf_incorrect_short        = (nIncorrect_short/mem.nimgShort)*100;

disp(['Performance short : ',num2str(round(mem.performance_short)),' % correct trials & ', ...
    num2str(round(mem.perf_incorrect_short)), '% incorrect trials' ]); 

%% =================== Performance - Correct Long      ===================

correct_Fem_long                = imgLong & (response(nTrial) == 1 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));
incorrect_Fem_long              = imgLong & (response(nTrial) == 2 & ((setSizeFF(nTrial) + setSizeNF(nTrial)) > (setSizeFM(nTrial) + setSizeNM(nTrial))));

correct_Hom_long                = imgLong & (response(nTrial) == 2 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));
incorrect_Hom_long              = imgLong & (response(nTrial) == 1 & ((setSizeFM(nTrial) + setSizeNM(nTrial)) > (setSizeFF(nTrial) + setSizeNF(nTrial))));

% Sum of all the correct trials
correct_long                    = (correct_Fem_long + correct_Hom_long);
incorrect_long                  = (incorrect_Fem_long + incorrect_Hom_long);

nCorrect_long                   = sum(correct_long);
nIncorrect_long                 = sum(incorrect_long);

% General performance
mem.performance_long            = nCorrect_long /(mem.nimgLong)*100;
mem.perf_incorrect_long         = (nIncorrect_long/mem.nimgLong)*100;

disp(['Performance long : ',num2str(round(mem.performance_long)),' % correct trials & ', ...
    num2str(round(mem.perf_incorrect_long)), '% incorrect trials' ]);

%% =================== Performance - Rewards            ===================

smallRwd                        = (reward(nTrial) == 1);
mem.smallRwdBlock               = unique(block(smallRwd == 1));

largeRwd                        = (reward(nTrial) == 2);
mem.largeRwdBlock               = unique(block(largeRwd == 1));

smallRwd_short                  = imgShort & smallRwd;
smallRwd_correct_short          = correct_short & smallRwd;
smallRwd_incorrect_short        = incorrect_short & smallRwd;
mem.smallRwd_rate_short         = sum(smallRwd_correct_short)/sum(smallRwd_short)*100;

largeRwd_short                  = imgShort & largeRwd;
largeRwd_correct_short          = correct_short & largeRwd;
largeRwd_incorrect_short        = incorrect_short & largeRwd;
mem.largeRwd_rate_short         = sum(largeRwd_correct_short)/sum(largeRwd_short)*100;

disp(['Reward Short : ',num2str(round(mem.smallRwd_rate_short)), '% were correct for small rwd & ', ...
    num2str(round(mem.largeRwd_rate_short)), '% were correct for large rwd' ]);

smallRwd_long                   = imgLong & smallRwd;
smallRwd_correct_long           = correct_long & smallRwd;
smallRwd_incorrect_long         = incorrect_long & smallRwd;
mem.smallRwd_rate_long          = sum(smallRwd_correct_long)/sum(smallRwd_long)*100;

largeRwd_long                   = imgLong & largeRwd;
largeRwd_correct_long           = correct_long & largeRwd;
largeRwd_incorrect_long         = incorrect_long & largeRwd;
mem.largeRwd_rate_long          = sum(largeRwd_correct_long)/sum(largeRwd_long)*100;

disp(['Reward Long : ',num2str(round(mem.smallRwd_rate_long)), '% were correct for small rwd & ', ...
    num2str(round(mem.largeRwd_rate_long)), '% were correct for large rwd' ]);

%% =================== Performance - Conditions (imgShort)  ===================

% Detrimental condition
DC_condition_short              = imgShort & (condition(nTrial) == 1 | condition(nTrial) == 2);
DC_correct_short                = correct_short & DC_condition_short;
DC_incorrect_short              = incorrect_short & DC_condition_short;
mem.DC_block_short              = unique(block(DC_condition_short));

% Control Condition
CC_condition_short              = imgShort & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_correct_short                = correct_short & CC_condition_short;
CC_incorrect_short              = incorrect_short & CC_condition_short;

% Beneficial Conditions
BC_condition_short              = imgShort & (condition(nTrial) == 5 | condition(nTrial) == 6);
BC_correct_short                = correct_short & BC_condition_short;
BC_incorrect_short              = incorrect_short & BC_condition_short;
mem.BC_block_short              = unique(block(BC_condition_short));

% Condition Emotions
mem.perf_DC_short               = sum(DC_correct_short)/sum(DC_condition_short)*100;
mem.perf_CC_short               = sum(CC_correct_short)/sum(CC_condition_short)*100;
mem.perf_BC_short               = sum(BC_correct_short)/sum(BC_condition_short)*100;

disp(['Performance Emotion Short : ',num2str(round(mem.perf_DC_short)), '% for DC, ', ...
    num2str(round(mem.perf_CC_short)), '% for CC & ',num2str(round(mem.perf_BC_short)), '% for BC']);

%% =================== Performance - Conditions (Lag 4) ===================

% Detrimental condition
DC_condition_long               = imgLong & (condition(nTrial) == 1 | condition(nTrial) == 2);
DC_correct_long                 = correct_long & DC_condition_long;
DC_incorrect_long               = incorrect_long & DC_condition_long;
mem.DC_block_long               = unique(block(DC_condition_long));

% Control Condition
CC_condition_long               = imgLong & (condition(nTrial) == 3 | condition(nTrial) == 4);
CC_correct_long                 = correct_long & CC_condition_long;
CC_incorrect_long               = incorrect_long & CC_condition_long;

% Beneficial Conditions
BC_condition_long               = imgLong & (condition(nTrial) == 5 | condition(nTrial) == 6);
BC_correct_long                 = correct_long & BC_condition_long;
BC_incorrect_long               = incorrect_long & BC_condition_long;
mem.BC_block_long               = unique(block(BC_condition_long));

% Condition Emotions
mem.perf_DC_long                = sum(DC_correct_long)/sum(DC_condition_long)*100;
mem.perf_BC_long                = sum(BC_correct_long)/sum(BC_condition_long)*100;
mem.perf_CC_long                = sum(CC_correct_long)/sum(CC_condition_long)*100;

disp(['Performance Emotion Long : ',num2str(round(mem.perf_DC_long)), '% for DC, ', ...
    num2str(round(mem.perf_CC_long)), '% for CC & ',num2str(round(mem.perf_BC_long)), '% for BC']);

%% =================== Performance - Conditions & Rewards =================
% Short Presentation 
mem.perf_DC_smallRwd_short      = sum(DC_correct_short(smallRwd == 1)) / sum(DC_condition_short(smallRwd == 1)) * 100 ;
mem.perf_DC_largeRwd_short      = sum(DC_correct_short(largeRwd == 1)) / sum(DC_condition_short(largeRwd == 1)) * 100 ;

mem.perf_CC_smallRwd_short      = sum(CC_correct_short(smallRwd == 1)) / sum(CC_condition_short(smallRwd == 1)) * 100 ;
mem.perf_CC_largeRwd_short      = sum(CC_correct_short(largeRwd == 1)) / sum(CC_condition_short(largeRwd == 1)) * 100 ;

mem.perf_BC_smallRwd_short      = sum(BC_correct_short(smallRwd == 1)) / sum(BC_condition_short(smallRwd == 1)) * 100;
mem.perf_BC_largeRwd_short      = sum(BC_correct_short(largeRwd == 1)) / sum(BC_condition_short(largeRwd == 1)) * 100 ;

% Long Presentation 
mem.perf_DC_smallRwd_long       = sum(DC_correct_long(smallRwd == 1)) / sum(DC_condition_long(smallRwd == 1)) * 100 ;
mem.perf_DC_largeRwd_long       = sum(DC_correct_long(largeRwd == 1)) / sum(DC_condition_long(largeRwd == 1)) * 100 ;

mem.perf_CC_smallRwd_long       = sum(CC_correct_long(smallRwd == 1)) / sum(CC_condition_long(smallRwd == 1)) * 100 ;
mem.perf_CC_largeRwd_long       = sum(CC_correct_long(largeRwd == 1)) / sum(CC_condition_long(largeRwd == 1)) * 100 ;

mem.perf_BC_smallRwd_long       = sum(BC_correct_long(smallRwd == 1)) / sum(BC_condition_long(smallRwd == 1)) * 100;
mem.perf_BC_largeRwd_long       = sum(BC_correct_long(largeRwd == 1)) / sum(BC_condition_long(largeRwd == 1)) * 100 ;

%% =================== Learning Curves - Short          ===================

mem.LC_short              = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC_short)
    mem.LC_short(i)       = (sum(correct_short(block == i)))/(sum(imgShort(block == i)))*100;
end

mem.LC_smallRwd_short     = zeros(1,length(mem.smallRwdBlock));
mem.LC_largeRwd_short     = zeros(1,length(mem.largeRwdBlock));
for i = 1:length(mem.smallRwdBlock)
    mem.LC_smallRwd_short(i) = (sum(correct_short(block == mem.smallRwdBlock(i))))/...
        (sum(imgShort(block == mem.smallRwdBlock(i))))*100;
    mem.LC_largeRwd_short(i) = (sum(correct_short(block == mem.largeRwdBlock(i))))/...
        (sum(imgShort(block == mem.largeRwdBlock(i))))*100;
end

mem.LC_DC_short     = zeros(1,length(mem.DC_block_short));
mem.LC_BC_short     = zeros(1,length(mem.BC_block_short));

for i = 1:length(mem.DC_block_short)
    mem.LC_DC_short(i) = (sum(DC_correct_short(block == mem.DC_block_short(i))))/ ...
        sum(DC_condition_short(block == mem.DC_block_short(i)))*100;
    mem.LC_BC_short(i) = (sum(BC_correct_short(block == mem.BC_block_short(i))))/ ...
        sum(BC_condition_short(block == mem.BC_block_short(i)))*100;
    
end

mem.LC_CC_short     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC_CC_short)
    mem.LC_CC_short(i) = (sum(CC_correct_short(block == i)))/ ...
        sum(CC_condition_short(block == i))*100;
end

%% =================== Learning Curves - Long          ===================

mem.LC_long              = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC_long)
    mem.LC_long(i)       = (sum(correct_long(block == i)))/(sum(imgLong(block == i)))*100;
end

mem.LC_smallRwd_long     = zeros(1,length(mem.smallRwdBlock));
mem.LC_largeRwd_long     = zeros(1,length(mem.largeRwdBlock));
for i = 1:length(mem.smallRwdBlock)
    mem.LC_smallRwd_long(i) = (sum(correct_long(block == mem.smallRwdBlock(i))))/...
        (sum(imgLong(block == mem.smallRwdBlock(i))))*100;
    mem.LC_largeRwd_long(i) = (sum(correct_long(block == mem.largeRwdBlock(i))))/...
        (sum(imgLong(block == mem.largeRwdBlock(i))))*100;
end

mem.LC_DC_long     = zeros(1,length(mem.DC_block_long));
mem.LC_BC_long     = zeros(1,length(mem.BC_block_long));

for i = 1:length(mem.DC_block_long)
    mem.LC_DC_long(i) = (sum(DC_correct_long(block == mem.DC_block_long(i))))/ ...
        sum(DC_condition_long(block == mem.DC_block_long(i)))*100;
    mem.LC_BC_long(i) = (sum(BC_correct_long(block == mem.BC_block_long(i))))/ ...
        sum(BC_condition_long(block == mem.BC_block_long(i)))*100;
    
end

mem.LC_CC_long     = zeros(1,cfg_exp.nBlocksExp);
for i = 1:length(mem.LC_CC_long)
    mem.LC_CC_long(i) = (sum(CC_correct_long(block == i)))/ ...
        sum(CC_condition_long(block == i))*100;
end


%% =================== PLOT PART                        ===================
if fig
    %% Performance Plots
    % Performance par conditions
    figure('Name', ['RSVP Performance Plots ',num2str(ID)]);
    subplot(2,3,1)
    hold on;
    bar(1, (mem.perf_DC_short),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
    bar(1.5, (mem.perf_CC_short),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
    bar(2, (mem.perf_BC_short),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
    
    bar(3, (mem.perf_DC_long),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
    bar(3.5, (mem.perf_CC_long),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
    bar(4, (mem.perf_BC_long),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
    
    xticks([1.5 3.5])
    xticklabels({'Short (1.5s)', 'Long (2s)'})
    legend('DC','CC','BC','fontsize', 6 , 'Location', 'southeast')
    ylabel('Performance','fontsize', 10)
    title('Performance According to Conditions','fontsize', 10)
    axis([0 5 50 105])
    grid minor
    box on
    hold off
    
    % Performance par rewards
    subplot(2,3,3)
    hold on;
    bar(1, mem.smallRwd_rate_short,'FaceColor',[0.75, 0.85, 0.90], 'BarWidth',.5)
    bar(1.5, mem.largeRwd_rate_short,'FaceColor',[0.35, 0.50, 0.60], 'BarWidth',.5)
    bar(2.5, mem.smallRwd_rate_long,'FaceColor',[0.75, 0.85, 0.90], 'BarWidth',.5)
    bar(3, mem.largeRwd_rate_long,'FaceColor',[0.35, 0.50, 0.60], 'BarWidth',.5)
    xticks([1 2.5])
    xticklabels({'Lag 2','Lag 4'})
    ylabel('Performance','fontsize', 10)
    title('Performance according to reward','fontsize', 10)
    axis([0 4 50 105])
    grid minor 
    box on 
    hold off
    
    
    perf_DC_largeRwd = {mem.perf_DC_largeRwd_short ,mem.perf_DC_largeRwd_long };
    perf_CC_largeRwd = {mem.perf_CC_largeRwd_short ,mem.perf_CC_largeRwd_long };
    perf_BC_largeRwd = {mem.perf_BC_largeRwd_short ,mem.perf_BC_largeRwd_long };
    perf_DC_smallRwd = {mem.perf_DC_smallRwd_short ,mem.perf_DC_smallRwd_long };
    perf_CC_smallRwd = {mem.perf_CC_smallRwd_short ,mem.perf_CC_smallRwd_long };
    perf_BC_smallRwd = {mem.perf_BC_smallRwd_short ,mem.perf_BC_smallRwd_long };
        
    rwd_title = {'Lag 2', 'Lag 4'};
    for i = 1:2
        subplot(2,2,i + 2)
        hold on;
        p2 = plot(1:3,[perf_DC_largeRwd{i}, perf_CC_largeRwd{i},perf_BC_largeRwd{i}],'-x', 'linewidth',2.3);
        p2.Color = [.00, .45, .55];
        p1 = plot(1:3,[perf_DC_smallRwd{i}, perf_CC_smallRwd{i},perf_BC_smallRwd{i}],'-+', 'linewidth',2.3);
        p1.Color = [.45, .75, .80];
        line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
        xticks([1 2 3])
        legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
        xticklabels({'DC','CC','BC '})
        ylabel('Performance (mean +/- SEM)','fontsize', 10)
        title(rwd_title{i},'fontsize', 10)
        axis([0 4 50 105])
        grid minor
        box on
        hold off
    end
    
    %% Learning Curves Plots
    figure('Name', ['Lag RSVP Learning Curve Plots ',num2str(ID)]);
    
    LC = {mem.LC_short, mem.LC_long};
    LC_title = {'Learning Curve LAG 2', 'Learning Curve LAG 4 '};
    for i = 1:2
        subplot(2,2,i)
        p = plot(1:length(LC{i}), (LC{i}),'linew',1.5);
        p.Color = [0 0 0];
        ylabel('Performance (mean +/- SEM)','fontsize', 10)
        xlabel('Number of Blocks','fontsize', 10)
        xticks(1:(length(LC{i})))
        xticklabels(1:12)
        title(LC_title{i},'fontsize', 10)
        axis([0 (length(LC{i})+1) 70 100])
        grid minor
        box on
    end
    
    LC_largeRwd = {mem.LC_largeRwd_short, mem.LC_largeRwd_long};
    LC_smallRwd = {mem.LC_smallRwd_short, mem.LC_smallRwd_long};
    for i = 1:2
        subplot(2,4,i + 4)
        hold on
        p2 = plot(1:length(LC_largeRwd{i}), (LC_largeRwd{i}),'-o','linew',1.5);
        p2.Color = [.00, .45, .55];
        p1 = plot(1:length(LC_smallRwd{i}), (LC_smallRwd{i}),'-x','linew',1.5);
        p1.Color = [.45, .75, .80];
        legend('Large Rwd','Small Rwd', 'Location', 'southeast')
        ylabel('Performance (mean +/- SEM)','fontsize', 10)
        xlabel('Number of Blocks','fontsize', 10)
        xticks(1:length(LC_largeRwd{i})); xticklabels(1:6)
        title(LC_title{i},'fontsize', 10)
        axis([0 7 50 105])
        hold off
        grid minor
        box on
    end
    
    LC_DC = {mem.LC_DC_short, mem.LC_DC_long};
    LC_CC = {mem.LC_CC_short, mem.LC_CC_long};
    LC_BC = {mem.LC_BC_short, mem.LC_BC_long};
    for i = 1:2
        subplot(2,4, i + 6)
        hold on
        p1 = plot(1:length(LC_DC{i}), LC_DC{i},'-x','linew',1.5);
        p1.Color = [.75 .45 .55];
        %p2 = plot(1:6, mean(LC_CC{i}),'-+','linew',1.5); %1:.5:6.5
        %p2.Color = [.50 .50 .50];
        p3 = plot(1:length(LC_BC{i}), LC_BC{i},'-o','linew',1.5);
        p3.Color = [.40 .55 .40];
        legend({'DC','BC'}, 'Location', 'southeast')
        ylabel('Performance (mean +/- SEM)','fontsize', 10)
        xlabel('Number of Blocks','fontsize', 10)
        xticks(1:6); xticklabels(1:6)
        title(LC_title{i},'fontsize', 10)
        axis([0 7 50 105])
        hold off
        grid minor
        box on
    end
    
    
    
end



end