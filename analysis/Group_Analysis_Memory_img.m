% JS group analysis script for the effect of lag on performance in RSVP

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 12346, 90255, 81477, 33222, 90255, 48680]; 

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    memGRP(subj_idx) = Individual_Analysis_mem_img(subject_ID(subj_idx), false);
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

nS              = length(subject_ID);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf_short                   = [memGRP.performance_short];
perf_short_mean              = mean([memGRP.performance_short]);
perf_short_min               = min([memGRP.performance_short]);
perf_short_max               = max([memGRP.performance_short]);
perf_short_sem               = std([memGRP.performance_short])/sqrt(nS);
[h_short, p_short, stats_short ] = adtest(perf_short);

perf_long                   = [memGRP.performance_long];
perf_long_mean              = mean([memGRP.performance_long]);
perf_long_min               = min([memGRP.performance_long]);
perf_long_max               = max([memGRP.performance_long]);
perf_long_sem               = std([memGRP.performance_long])/sqrt(nS);
[h_long, p_long, stats_long ] = adtest(perf_long);

disp(['General Performance : ', ...
    num2str(round(mean(perf_short))), '% for Short & ', ...
    num2str(round(mean(perf_long))), '% for Long ']) ;

[h ,p , ci] = ttest2(perf_short, perf_long);


%% =================== Performance - Rewards            ===================
smallRwd_rate_short           = [memGRP.smallRwd_rate_short];
smallRwd_rate_short_sem       = std([memGRP.smallRwd_rate_short])/sqrt(nS);

largeRwd_rate_short           = [memGRP.largeRwd_rate_short];
largeRwd_rate_short_sem       = std([memGRP.largeRwd_rate_short])/sqrt(nS);

disp(['Reward Short : ',num2str(round(mean(smallRwd_rate_short))), '% for small rwd & ', ...
    num2str(round(mean(largeRwd_rate_short))), '% for large rwd' ]);

smallRwd_rate_long           = [memGRP.smallRwd_rate_long];
smallRwd_rate_long_sem       = std([memGRP.smallRwd_rate_long])/sqrt(nS);

largeRwd_rate_long           = [memGRP.largeRwd_rate_long];
largeRwd_rate_long_sem       = std([memGRP.largeRwd_rate_long])/sqrt(nS);

disp(['Reward Long : ',num2str(round(mean(smallRwd_rate_long))), '% for small rwd & ', ...
    num2str(round(mean(largeRwd_rate_long))), '% for large rwd' ]);

%% =================== Performance - Conditions (Short) ===================

perf_DC_short                 = [memGRP.perf_DC_short];
perf_DC_short_sem             = std([memGRP.perf_DC_short])/sqrt(nS);

% Control Condition
perf_CC_short                 = ([memGRP.perf_CC_short]);
perf_CC_short_sem             = std([memGRP.perf_CC_short])/sqrt(nS);

% Beneficial Condition
perf_BC_short                 = ([memGRP.perf_BC_short]);
perf_BC_short_sem             = std([memGRP.perf_BC_short])/sqrt(nS);

disp(['Emotion Short: ',num2str(round(mean(perf_DC_short))), '% for DC, ', ...
    num2str(round(mean(perf_CC_short))), '% for CC & ',...
    num2str(round(mean(perf_BC_short))), '% for BC']);

perf_DC_smallRwd_short        = ([memGRP.perf_DC_smallRwd_short]);
perf_DC_smallRwd_short_sem    = std([memGRP.perf_DC_smallRwd_short])/sqrt(nS);

perf_DC_largeRwd_short        = ([memGRP.perf_DC_largeRwd_short]);
perf_DC_largeRwd_short_sem    = std([memGRP.perf_DC_largeRwd_short])/sqrt(nS);

perf_CC_smallRwd_short        = ([memGRP.perf_CC_smallRwd_short]);
perf_CC_smallRwd_short_sem    = std([memGRP.perf_CC_smallRwd_short])/sqrt(nS);

perf_CC_largeRwd_short        = ([memGRP.perf_CC_largeRwd_short]);
perf_CC_largeRwd_short_sem    = std([memGRP.perf_CC_largeRwd_short])/sqrt(nS);

perf_BC_smallRwd_short        = ([memGRP.perf_BC_smallRwd_short]);
perf_BC_smallRwd_short_sem    = std([memGRP.perf_BC_smallRwd_short])/sqrt(nS);

perf_BC_largeRwd_short        = ([memGRP.perf_BC_largeRwd_short]);
perf_BC_largeRwd_short_sem    = std([memGRP.perf_BC_largeRwd_short])/sqrt(nS);

%% =================== Performance - Conditions (Long) ===================

perf_DC_long                 = [memGRP.perf_DC_long];
perf_DC_long_sem             = std([memGRP.perf_DC_long])/sqrt(nS);

% Control Condition
perf_CC_long                 = ([memGRP.perf_CC_long]);
perf_CC_long_sem             = std([memGRP.perf_CC_long])/sqrt(nS);

% Beneficial Condition
perf_BC_long                 = ([memGRP.perf_BC_long]);
perf_BC_long_sem             = std([memGRP.perf_BC_long])/sqrt(nS);

disp(['Emotion Long: ',num2str(round(mean(perf_DC_long))), '% for DC, ', ...
    num2str(round(mean(perf_CC_long))), '% for CC & ',...
    num2str(round(mean(perf_BC_long))), '% for BC']);

perf_DC_smallRwd_long        = ([memGRP.perf_DC_smallRwd_long]);
perf_DC_smallRwd_long_sem    = std([memGRP.perf_DC_smallRwd_long])/sqrt(nS);

perf_DC_largeRwd_long        = ([memGRP.perf_DC_largeRwd_long]);
perf_DC_largeRwd_long_sem    = std([memGRP.perf_DC_largeRwd_long])/sqrt(nS);

perf_CC_smallRwd_long        = ([memGRP.perf_CC_smallRwd_long]);
perf_CC_smallRwd_long_sem    = std([memGRP.perf_CC_smallRwd_long])/sqrt(nS);

perf_CC_largeRwd_long        = ([memGRP.perf_CC_largeRwd_long]);
perf_CC_largeRwd_long_sem    = std([memGRP.perf_CC_largeRwd_long])/sqrt(nS);

perf_BC_smallRwd_long        = ([memGRP.perf_BC_smallRwd_long]);
perf_BC_smallRwd_long_sem    = std([memGRP.perf_BC_smallRwd_long])/sqrt(nS);

perf_BC_largeRwd_long        = ([memGRP.perf_BC_largeRwd_long]);
perf_BC_largeRwd_long_sem    = std([memGRP.perf_BC_largeRwd_long])/sqrt(nS);

%% =================== Learning Curves                  ===================

LC_short                      = zeros(subj_idx,12);
LC_smallRwd_short             = zeros(subj_idx,6);
LC_largeRwd_short             = zeros(subj_idx,6);
LC_DC_short                   = zeros(subj_idx,6);
LC_BC_short                   = zeros(subj_idx,6);
LC_CC_short                   = zeros(subj_idx,6);

LC_long                      = zeros(subj_idx,12);
LC_smallRwd_long             = zeros(subj_idx,6);
LC_largeRwd_long             = zeros(subj_idx,6);
LC_DC_long                   = zeros(subj_idx,6);
LC_BC_long                   = zeros(subj_idx,6);
LC_CC_long                   = zeros(subj_idx,6);

% RTsC_short                    = zeros(subj_idx,12);
% RTsC_smallRwd_short           = zeros(subj_idx,6);
% RTsC_largeRwd_short           = zeros(subj_idx,6);
% RTsC_DC_short                 = zeros(subj_idx,6);
% RTsC_BC_short                 = zeros(subj_idx,6);
% RTsC_CC_short                 = zeros(subj_idx,6);

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC_short(subj_idx,block)                = memGRP(subj_idx).LC_short(block);
        LC_long(subj_idx,block)                = memGRP(subj_idx).LC_long(block);
        %         RTsC_short(subj_idx,block)              = memGRP(subj_idx).RTsC_short(block);
    end
    
    for blockCondi = 1:6
        LC_smallRwd_short(subj_idx,blockCondi)  = memGRP(subj_idx).LC_smallRwd_short(blockCondi);
        LC_largeRwd_short(subj_idx,blockCondi)  = memGRP(subj_idx).LC_largeRwd_short(blockCondi);
        LC_DC_short(subj_idx,blockCondi)        = memGRP(subj_idx).LC_DC_short(blockCondi);
        LC_BC_short(subj_idx,blockCondi)        = memGRP(subj_idx).LC_BC_short(blockCondi);
        LC_CC_short(subj_idx,blockCondi)        = (memGRP(subj_idx).LC_CC_short(blockCondi) + memGRP(subj_idx).LC_CC_short(blockCondi + 6))/2;
        
        LC_smallRwd_long(subj_idx,blockCondi)  = memGRP(subj_idx).LC_smallRwd_long(blockCondi);
        LC_largeRwd_long(subj_idx,blockCondi)  = memGRP(subj_idx).LC_largeRwd_long(blockCondi);
        LC_DC_long(subj_idx,blockCondi)        = memGRP(subj_idx).LC_DC_long(blockCondi);
        LC_BC_long(subj_idx,blockCondi)        = memGRP(subj_idx).LC_BC_long(blockCondi);
        LC_CC_long(subj_idx,blockCondi)        = (memGRP(subj_idx).LC_CC_long(blockCondi) + memGRP(subj_idx).LC_CC_long(blockCondi + 6))/2;
        
        %         RTsC_smallRwd_short(subj_idx,blockCondi)= memGRP(subj_idx).RTsC_smallRwd_short(blockCondi);
        %         RTsC_largeRwd_short(subj_idx,blockCondi)= memGRP(subj_idx).RTsC_largeRwd_short(blockCondi);
        %         RTsC_DC_short(subj_idx,blockCondi)      = memGRP(subj_idx).RTsC_DC_short(blockCondi);
        %         RTsC_BC_short(subj_idx,blockCondi)      = memGRP(subj_idx).RTsC_BC_short(blockCondi);
        %         RTsC_CC_short(subj_idx,blockCondi)      = (memGRP(subj_idx).RTsC_CC_short(blockCondi) + memGRP(subj_idx).RTsC_CC_short(blockCondi + 6))/2;
        
    end
end

%% =================== PLOT PART                        ===================
[h_DC, p_DC, ci_DC, stats_DC] = ttest2(perf_DC_short, perf_DC_long);
[h_BC, p_BC, ci_BC, stats_BC] = ttest2(perf_BC_short, perf_BC_long);
[h_CC, p_CC, ci_CC, stats_CC] = ttest2(perf_CC_short, perf_CC_long);

[h_DC_short, p_DC_short, ci_DC_short, stats_DC_short] = ttest2(perf_DC_smallRwd_short, perf_DC_largeRwd_short);
[h_BC_short, p_BC_short, ci_BC_short, stats_BC_short] = ttest2(perf_BC_smallRwd_short, perf_BC_largeRwd_short);
[h_CC_short, p_CC_short, ci_CC_short, stats_CC_short] = ttest2(perf_CC_smallRwd_short, perf_CC_largeRwd_short);

[h_DC_CC_smallRwd_short, p_DC_CC_smallRwd_short] = ttest2(perf_DC_smallRwd_short, perf_CC_smallRwd_short);
[h_DC_BC_smallRwd_short, p_DC_BC_smallRwd_short] = ttest2(perf_BC_smallRwd_short, perf_DC_smallRwd_short);
[h_BC_CC_smallRwd_short, p_BC_CC_smallRwd_short] = ttest2(perf_BC_smallRwd_short, perf_CC_smallRwd_short);

[h_DC_CC_largeRwd_short, p_DC_CC_largeRwd_short] = ttest2(perf_DC_largeRwd_short, perf_CC_largeRwd_short);
[h_DC_BC_largeRwd_short, p_DC_BC_largeRwd_short] = ttest2(perf_BC_largeRwd_short, perf_DC_largeRwd_short);
[h_BC_CC_largeRwd_short, p_BC_CC_largeRwd_short] = ttest2(perf_BC_largeRwd_short, perf_CC_largeRwd_short);

[h_DC_long, p_DC_long, ci_DC_long, stats_DC_long] = ttest2(perf_DC_smallRwd_long, perf_DC_largeRwd_long);
[h_BC_long, p_BC_long, ci_BC_long, stats_BC_long] = ttest2(perf_BC_smallRwd_long, perf_BC_largeRwd_long);
[h_CC_long, p_CC_long, ci_CC_long, stats_CC_long] = ttest2(perf_CC_smallRwd_long, perf_CC_largeRwd_long);

[h_DC_CC_smallRwd_long, p_DC_CC_smallRwd_long] = ttest2(perf_DC_smallRwd_long, perf_CC_smallRwd_long);
[h_DC_BC_smallRwd_long, p_DC_BC_smallRwd_long] = ttest2(perf_BC_smallRwd_long, perf_DC_smallRwd_long);
[h_BC_CC_smallRwd_long, p_BC_CC_smallRwd_long] = ttest2(perf_BC_smallRwd_long, perf_CC_smallRwd_long);

[h_DC_CC_largeRwd_long, p_DC_CC_largeRwd_long] = ttest2(perf_DC_largeRwd_long, perf_CC_largeRwd_long);
[h_DC_BC_largeRwd_long, p_DC_BC_largeRwd_long] = ttest2(perf_BC_largeRwd_long, perf_DC_largeRwd_long);
[h_BC_CC_largeRwd_long, p_BC_CC_largeRwd_long] = ttest2(perf_BC_largeRwd_long, perf_CC_largeRwd_long);


%% Performance Plots
% Performance par conditions
figure('Name', 'RSVP Performance Plots');
subplot(2,3,1)
hold on;
bar(1, mean(perf_DC_short),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
bar(1.5, mean(perf_CC_short),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
bar(2, mean(perf_BC_short),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
errorbar(1, mean(perf_DC_short), perf_DC_short_sem, 'k.','LineWidth',1);
errorbar(1.5, mean(perf_CC_short), perf_CC_short_sem, 'k.','LineWidth',1);
errorbar(2, mean(perf_BC_short), perf_BC_short_sem, 'k.','LineWidth',1);

bar(3, mean(perf_DC_long),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
bar(3.5, mean(perf_CC_long),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
bar(4, mean(perf_BC_long),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
errorbar(3, mean(perf_DC_long), perf_DC_long_sem, 'k.','LineWidth',1);
errorbar(3.5, mean(perf_CC_long), perf_CC_long_sem, 'k.','LineWidth',1);
errorbar(4, mean(perf_BC_long), perf_BC_long_sem, 'k.','LineWidth',1);

sigstar({[1,3], [1.5, 3.5], [2,4]}, [p_DC, p_BC, p_CC],0,100) 
xticks([1.5 3.5])
xticklabels({'Short', 'Long'})
legend('DC','CC','BC','fontsize', 6 , 'Location', 'northeast')
ylabel('Performance','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 5 50 100])
grid minor
box on
hold off

subplot(2,3,2)
hold on;
bar(1, mean(perf_DC_smallRwd_short),'FaceColor',[.65 .35 .45], 'BarWidth',.5)
bar(1.5, mean(perf_CC_smallRwd_short),'FaceColor',[.85 .85 .85], 'BarWidth',.5);
bar(2, mean(perf_BC_smallRwd_short),'FaceColor',[.50 .65 .50], 'BarWidth',.5)
errorbar(1, mean(perf_DC_smallRwd_short), perf_DC_smallRwd_short_sem, 'k.','LineWidth',1);
errorbar(1.5, mean(perf_CC_smallRwd_short), perf_CC_smallRwd_short_sem, 'k.','LineWidth',1);
errorbar(2, mean(perf_BC_smallRwd_short), perf_BC_smallRwd_short_sem, 'k.','LineWidth',1);

bar(3, mean(perf_DC_largeRwd_short),'FaceColor',[.45 .15 .25], 'BarWidth',.5)
bar(3.5, mean(perf_CC_largeRwd_short),'FaceColor',[.65 .65 .65], 'BarWidth',.5);
bar(4, mean(perf_BC_largeRwd_short),'FaceColor',[.30 .45 .30], 'BarWidth',.5)
errorbar(3, mean(perf_DC_largeRwd_short), perf_DC_largeRwd_short_sem, 'k.','LineWidth',1);
errorbar(3.5, mean(perf_CC_largeRwd_short), perf_CC_largeRwd_short_sem, 'k.','LineWidth',1);
errorbar(4, mean(perf_BC_largeRwd_short), perf_BC_largeRwd_short_sem, 'k.','LineWidth',1);

sigstar({[1,1.5], [1, 2], [1.5, 2]}, [p_DC_CC_smallRwd_short, p_DC_BC_smallRwd_short, p_BC_CC_smallRwd_short],0,100) 
sigstar({[3,3.5], [3, 4], [3.5, 4]}, [p_DC_CC_largeRwd_short, p_DC_BC_largeRwd_short, p_BC_CC_largeRwd_short],0,100) 

xticks([1.5 3.5])
xticklabels({'Small Reward', 'Large Reward'})
legend('DC','CC','BC','fontsize', 6 , 'Location', 'northeast')
ylabel('Performance','fontsize', 10)
title('Short Perf in Fct of Conditions & Rwd','fontsize', 10)
axis([0 5 50 100])
grid minor
box on
hold off

subplot(2,3,3)
hold on;
bar(1, mean(perf_DC_smallRwd_long),'FaceColor',[.65 .35 .45], 'BarWidth',.5)
bar(1.5, mean(perf_CC_smallRwd_long),'FaceColor',[.85 .85 .85], 'BarWidth',.5);
bar(2, mean(perf_BC_smallRwd_long),'FaceColor',[.50 .65 .50], 'BarWidth',.5)
errorbar(1, mean(perf_DC_smallRwd_long), perf_DC_smallRwd_long_sem, 'k.','LineWidth',1);
errorbar(1.5, mean(perf_CC_smallRwd_long), perf_CC_smallRwd_long_sem, 'k.','LineWidth',1);
errorbar(2, mean(perf_BC_smallRwd_long), perf_BC_smallRwd_long_sem, 'k.','LineWidth',1);

bar(3, mean(perf_DC_largeRwd_long),'FaceColor',[.45 .15 .25], 'BarWidth',.5)
bar(3.5, mean(perf_CC_largeRwd_long),'FaceColor',[.65 .65 .65], 'BarWidth',.5);
bar(4, mean(perf_BC_largeRwd_long),'FaceColor',[.30 .45 .30], 'BarWidth',.5)
errorbar(3, mean(perf_DC_largeRwd_long), perf_DC_largeRwd_long_sem, 'k.','LineWidth',1);
errorbar(3.5, mean(perf_CC_largeRwd_long), perf_CC_largeRwd_long_sem, 'k.','LineWidth',1);
errorbar(4, mean(perf_BC_largeRwd_long), perf_BC_largeRwd_long_sem, 'k.','LineWidth',1);

sigstar({[1,1.5], [1, 2], [1.5, 2]}, [p_DC_CC_smallRwd_long, p_DC_BC_smallRwd_long, p_BC_CC_smallRwd_long],0,100) 
sigstar({[3,3.5], [3, 4], [3.5, 4]}, [p_DC_CC_largeRwd_long, p_DC_BC_largeRwd_long, p_BC_CC_largeRwd_long],0,100) 

xticks([1.5 3.5])
xticklabels({'Small Reward', 'Large Reward'})
legend('DC','CC','BC','fontsize', 6 , 'Location', 'northeast')
ylabel('Performance','fontsize', 10)
title('Long Perf in Fct of Conditions & Rwd','fontsize', 10)
axis([0 5 50 100])
grid minor
box on
hold off

% Performance par rewards
subplot(2,3,4)
hold on;
rwd_plotY = [smallRwd_rate_short.', largeRwd_rate_short.',smallRwd_rate_long.', largeRwd_rate_long.'];
rwd_plotX = [1, 2, 3, 4];
rwd_plot_color = {[.00, .45, .55], [.45, .75, .80], [.00, .45, .55], [.45, .75, .80]};
B = boxplot(rwd_plotY, rwd_plotX,'Widths',.7);
get (B, 'tag'); 
set(B(1,:), 'color', 'k'); set(B(2,:), 'color', 'k');
set(B(6,:), 'color', 'k', 'linewidth', 2);
scatter(rwd_plotX,mean(rwd_plotY),'k','filled','d')
h = findobj(gca,'Tag','Box');
 for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),rwd_plot_color{j},'FaceAlpha',.7);
 end
xticks([2 4])
legend({'Mean', 'Small Rwd', 'Large Rwd'},'fontsize', 6 , 'Location', 'northeast')
xticklabels({'Short','Long'})
ylabel('Performance','fontsize', 10)
title('Performance According to Reward Size','fontsize', 10)
axis([0 5 50 100])
grid minor
box on
hold off

perf_DC_largeRwd = {mean(perf_DC_largeRwd_short) ,mean(perf_DC_largeRwd_long) };
perf_CC_largeRwd = {mean(perf_CC_largeRwd_short) ,mean(perf_CC_largeRwd_long) };
perf_BC_largeRwd = {mean(perf_BC_largeRwd_short) ,mean(perf_BC_largeRwd_long) };
perf_DC_smallRwd = {mean(perf_DC_smallRwd_short) ,mean(perf_DC_smallRwd_long) };
perf_CC_smallRwd = {mean(perf_CC_smallRwd_short) ,mean(perf_CC_smallRwd_long) };
perf_BC_smallRwd = {mean(perf_BC_smallRwd_short) ,mean(perf_BC_smallRwd_long) };

perf_DC_largeRwd_sem = {perf_DC_largeRwd_short_sem ,perf_DC_largeRwd_long_sem };
perf_CC_largeRwd_sem = {perf_CC_largeRwd_short_sem ,perf_CC_largeRwd_long_sem };
perf_BC_largeRwd_sem = {perf_BC_largeRwd_short_sem ,perf_BC_largeRwd_long_sem };
perf_DC_smallRwd_sem = {perf_DC_smallRwd_short_sem ,perf_DC_smallRwd_long_sem };
perf_CC_smallRwd_sem = {perf_CC_smallRwd_short_sem ,perf_CC_smallRwd_long_sem };
perf_BC_smallRwd_sem = {perf_BC_smallRwd_short_sem ,perf_BC_smallRwd_long_sem };
p_values             = {[p_DC_short, p_BC_short, p_CC_short], [p_DC_long, p_BC_long, p_CC_long]}; 

rwd_title = {'Short Perf in Fct of Conditions & Rwd', 'Long Perf in Fct of Conditions & Rwd'}; 
for i = 1:2
    subplot(2,3,i + 4)
    hold on;
    p2 = plot(1:3,[perf_DC_largeRwd{i}, perf_CC_largeRwd{i},perf_BC_largeRwd{i}], 'linewidth',2.3);
    p2.Color = [.00, .45, .55];
    p1 = plot(1:3,[perf_DC_smallRwd{i}, perf_CC_smallRwd{i},perf_BC_smallRwd{i}], 'linewidth',2.3);
    p1.Color = [.45, .75, .80];
    shadedErrorBar(1:3, [perf_DC_largeRwd{i}, perf_CC_largeRwd{i}, perf_BC_largeRwd{i}], ...
        [perf_DC_largeRwd_sem{i}, perf_CC_largeRwd_sem{i}, perf_BC_largeRwd_sem{i}],'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.2);
    e2 = errorbar(1:3,[perf_DC_largeRwd{i}, perf_CC_largeRwd{i},perf_BC_largeRwd{i}], ...
        [perf_DC_largeRwd_sem{i}, perf_CC_largeRwd_sem{i}, perf_BC_largeRwd_sem{i}], 'k.','LineWidth',.9);
    e2.Color = [.00, .45, .55];
    shadedErrorBar(1:3,[perf_DC_smallRwd{i}, perf_CC_smallRwd{i},perf_BC_smallRwd{i}], ...
        [perf_DC_smallRwd_sem{i}, perf_CC_smallRwd_sem{i},perf_BC_smallRwd_sem{i}],'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.2);
    e1 = errorbar(1:3,[perf_DC_smallRwd{i}, perf_CC_smallRwd{i}, perf_BC_smallRwd{i}], ...
        [perf_DC_smallRwd_sem{i}, perf_CC_smallRwd_sem{i},perf_BC_smallRwd_sem{i}], 'k.','LineWidth',.9);
    sigstar({[.8,1.2], [1.8, 2.2], [2.8,3.2]}, p_values{i} ,0,1) 
    e1.Color = [.45, .75, .80];
    line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
    xticks([1 2 3])
    legend({'Large Rwd','Small Rwd'},'fontsize', 6, 'Location', 'northeast')
    xticklabels({'DC','CC','BC '})
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    title(rwd_title{i},'fontsize', 10)
    axis([0 4 50 100])
    grid minor
    box on
    hold off
end

%% Learning Curves Plots
figure('Name', 'Lag RSVP Learning Curve Plots');

LC = {LC_short, LC_long};
LC_title = {'Learning Curve Short', 'Learning Curve Long '};
for i = 1:2
    subplot(2,2,i)
    p = plot(1:length(LC{i}), mean(LC{i}),'linew',1.5);
    p.Color = [0 0 0];
    shadedErrorBar(1:length(LC{i}),mean(LC{i}),(std(LC{i})/sqrt(nS)),'lineprops',{'Color',[0 0 0]},'patchSaturation',.3);
    %line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:(length(LC{i})))
    xticklabels(1:12)
    title(LC_title{i},'fontsize', 10)
    axis([0 (length(LC{i})+1) 50 100])
    grid minor
    box on
end

LC_largeRwd = {LC_largeRwd_short, LC_largeRwd_long};
LC_smallRwd = {LC_smallRwd_short, LC_smallRwd_long};
LC_R_pos = [5,7];
for i = 1:2
    subplot(2,4,LC_R_pos(i))
    hold on
    p2 = plot(1:6, mean(LC_largeRwd{i}),'-o','linew',1.5);
    p2.Color = [.00, .45, .55];
    p1 = plot(1:6, mean(LC_smallRwd{i}),'-x','linew',1.5);
    p1.Color = [.45, .75, .80];
    shadedErrorBar(1:6,mean(LC_largeRwd{i}),(std(LC_largeRwd{i})/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(LC_smallRwd{i}),(std(LC_smallRwd{i})/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.3);
    legend('Large Rwd','Small Rwd', 'Location', 'northeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title(LC_title{i},'fontsize', 10)
    axis([0 7 50 100])
    hold off
    grid minor
    box on
end

LC_DC = {LC_DC_short, LC_DC_long};
LC_CC = {LC_CC_short, LC_CC_long};
LC_BC = {LC_BC_short, LC_BC_long};
LC_C_pos = [6,8]; 
for i = 1:2
    subplot(2,4, LC_C_pos(i))
    hold on
    p1 = plot(1:6, mean(LC_DC{i}),'-x','linew',1.5);
    p1.Color = [.75 .45 .55];
    %p2 = plot(1:6, mean(LC_CC{i}),'-+','linew',1.5); %1:.5:6.5
    %p2.Color = [.50 .50 .50];
    p3 = plot(1:6, mean(LC_BC{i}),'-o','linew',1.5);
    p3.Color = [.40 .55 .40];
    shadedErrorBar(1:6,mean(LC_DC{i}),(std(LC_DC{i})/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.3);
    %shadedErrorBar(1:6,mean(LC_CC{i}),(std(LC_CC{i})/sqrt(nS)),'lineprops',{'Color',[.50 .50 .50]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(LC_BC{i}),(std(LC_BC{i})/sqrt(nS)),'lineprops',{'Color',[.40 .55 .40]},'patchSaturation',.3);
    %line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    legend({'DC','BC'}, 'Location', 'northeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title(LC_title{i},'fontsize', 10)
    axis([0 7 50 100])
    hold off
    grid minor
    box on
end