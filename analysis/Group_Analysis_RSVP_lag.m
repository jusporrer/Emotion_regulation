% JS group analysis script for the effect of lag on performance in RSVP

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 12346, 90255, 81477, 33222, 90255, 48680]; 

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP_lag(subject_ID(subj_idx), false);
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

nS              = length(subject_ID);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf_lag2                   = [rsvpGRP.performance_lag2];
perf_lag2_mean              = mean([rsvpGRP.performance_lag2]);
perf_lag2_min               = min([rsvpGRP.performance_lag2]);
perf_lag2_max               = max([rsvpGRP.performance_lag2]);
perf_lag2_sem               = std([rsvpGRP.performance_lag2])/sqrt(nS);
[h_lag2, p_lag2, stats_lag2 ] = adtest(perf_lag2);

perf_lag4                   = [rsvpGRP.performance_lag4];
perf_lag4_mean              = mean([rsvpGRP.performance_lag4]);
perf_lag4_min               = min([rsvpGRP.performance_lag4]);
perf_lag4_max               = max([rsvpGRP.performance_lag4]);
perf_lag4_sem               = std([rsvpGRP.performance_lag4])/sqrt(nS);
[h_lag4, p_lag4, stats_lag4 ] = adtest(perf_lag4);

disp(['General Performance : ', ...
    num2str(round(mean(perf_lag2))), '% for lag 2 & ', ...
    num2str(round(mean(perf_lag4))), '% for lag 4 ']) ;

[h_lag,p_lag, ci_lag] = ttest2(perf_lag2, perf_lag4);
if h_lag == 1
    disp(['The ttest rejects the null hypothesis that the performance between lag 2 and lag 4 has a mean equal to zero at ', ...
        num2str(p_lag), ' of p-value with a CI [', num2str(ci_lag(1)),'-', num2str(ci_lag(2)),']']);
elseif  h_lag == 0
    disp(['The ttest does not reject the null hypothesis that the performance between lag 2 and lag 4 has a mean equal to zero at ', ...
        num2str(p_lag), ' of p-value with a CI [', num2str(ci_lag(1)),'-', num2str(ci_lag(2)),']']);
end

hit_rate_lag2                = mean([rsvpGRP.hit_rate_lag2]);
reject_rate_lag2             = mean([rsvpGRP.reject_rate_lag2]);
miss_rate_lag2               = mean([rsvpGRP.miss_rate_lag2]);
falseAlarm_rate_lag2         = mean([rsvpGRP.falseAlarm_rate_lag2]);

disp(['Sdt Lag 2 : ', ...
    num2str(round(hit_rate_lag2)), '% hit rate, ', ...
    num2str(round(reject_rate_lag2)), '% reject rate, ', ...
    num2str(round(miss_rate_lag2)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate_lag2)), '% false alarm ']) ;

hit_rate_lag4                = mean([rsvpGRP.hit_rate_lag4]);
reject_rate_lag4             = mean([rsvpGRP.reject_rate_lag4]);
miss_rate_lag4               = mean([rsvpGRP.miss_rate_lag4]);
falseAlarm_rate_lag4         = mean([rsvpGRP.falseAlarm_rate_lag4]);

disp(['Sdt Lag 4 : ', ...
    num2str(round(hit_rate_lag4)), '% hit rate, ', ...
    num2str(round(reject_rate_lag4)), '% reject rate, ', ...
    num2str(round(miss_rate_lag4)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate_lag4)), '% false alarm ']) ;

%% =================== Performance - Rewards            ===================
smallRwd_rate_lag2           = [rsvpGRP.smallRwd_rate_lag2];
smallRwd_rate_lag2_sem       = std([rsvpGRP.smallRwd_rate_lag2])/sqrt(nS);

largeRwd_rate_lag2           = [rsvpGRP.largeRwd_rate_lag2];
largeRwd_rate_lag2_sem       = std([rsvpGRP.largeRwd_rate_lag2])/sqrt(nS);

disp(['Reward lag 2 : ',num2str(round(mean(smallRwd_rate_lag2))), '% for small rwd & ', ...
    num2str(round(mean(largeRwd_rate_lag2))), '% for large rwd' ]);

smallRwd_rate_lag4           = [rsvpGRP.smallRwd_rate_lag4];
smallRwd_rate_lag4_sem       = std([rsvpGRP.smallRwd_rate_lag4])/sqrt(nS);

largeRwd_rate_lag4           = [rsvpGRP.largeRwd_rate_lag4];
largeRwd_rate_lag4_sem       = std([rsvpGRP.largeRwd_rate_lag4])/sqrt(nS);

disp(['Reward lag 4 : ',num2str(round(mean(smallRwd_rate_lag4))), '% for small rwd & ', ...
    num2str(round(mean(largeRwd_rate_lag4))), '% for large rwd' ]);

%% =================== Performance - Conditions (Lag 2) ===================

perf_DC_lag2                 = [rsvpGRP.perf_DC_lag2];
perf_DC_lag2_sem             = std([rsvpGRP.perf_DC_lag2])/sqrt(nS);

hit_rate_DC_lag2             = mean([rsvpGRP.hit_rate_DC_lag2 ]);
reject_rate_DC_lag2          = mean([rsvpGRP.reject_rate_DC_lag2 ]);
miss_rate_DC_lag2            = mean([rsvpGRP.miss_rate_DC_lag2 ]);
falseAlarm_rate_DC_lag2      = mean([rsvpGRP.falseAlarm_rate_DC_lag2 ]);

% Control Condition
perf_CC_lag2                 = ([rsvpGRP.perf_CC_lag2]);
perf_CC_lag2_sem             = std([rsvpGRP.perf_CC_lag2])/sqrt(nS);

hit_rate_CC_lag2             = mean([rsvpGRP.hit_rate_CC_lag2 ]);
reject_rate_CC_lag2          = mean([rsvpGRP.reject_rate_CC_lag2 ]);
miss_rate_CC_lag2            = mean([rsvpGRP.miss_rate_CC_lag2 ]);
falseAlarm_rate_CC_lag2      = mean([rsvpGRP.falseAlarm_rate_CC_lag2 ]);

% Beneficial Condition
perf_BC_lag2                 = ([rsvpGRP.perf_BC_lag2]);
perf_BC_lag2_sem             = std([rsvpGRP.perf_BC_lag2])/sqrt(nS);

hit_rate_BC_lag2             = mean([rsvpGRP.hit_rate_BC_lag2 ]);
reject_rate_BC_lag2          = mean([rsvpGRP.reject_rate_BC_lag2 ]);
miss_rate_BC_lag2            = mean([rsvpGRP.miss_rate_BC_lag2 ]);
falseAlarm_rate_BC_lag2      = mean([rsvpGRP.falseAlarm_rate_BC_lag2 ]);

disp(['Emotion Lag 2: ',num2str(round(mean(perf_DC_lag2))), '% for DC, ', ...
    num2str(round(mean(perf_CC_lag2))), '% for CC & ',...
    num2str(round(mean(perf_BC_lag2))), '% for BC']);

perf_DC_smallRwd_lag2        = mean([rsvpGRP.perf_DC_smallRwd_lag2]);
perf_DC_smallRwd_lag2_sem    = std([rsvpGRP.perf_DC_smallRwd_lag2])/sqrt(nS);

perf_DC_largeRwd_lag2        = mean([rsvpGRP.perf_DC_largeRwd_lag2]);
perf_DC_largeRwd_lag2_sem    = std([rsvpGRP.perf_DC_largeRwd_lag2])/sqrt(nS);

perf_CC_smallRwd_lag2        = mean([rsvpGRP.perf_CC_smallRwd_lag2]);
perf_CC_smallRwd_lag2_sem    = std([rsvpGRP.perf_CC_smallRwd_lag2])/sqrt(nS);

perf_CC_largeRwd_lag2        = mean([rsvpGRP.perf_CC_largeRwd_lag2]);
perf_CC_largeRwd_lag2_sem    = std([rsvpGRP.perf_CC_largeRwd_lag2])/sqrt(nS);

perf_BC_smallRwd_lag2        = mean([rsvpGRP.perf_BC_smallRwd_lag2]);
perf_BC_smallRwd_lag2_sem    = std([rsvpGRP.perf_BC_smallRwd_lag2])/sqrt(nS);

perf_BC_largeRwd_lag2        = mean([rsvpGRP.perf_BC_largeRwd_lag2]);
perf_BC_largeRwd_lag2_sem    = std([rsvpGRP.perf_BC_largeRwd_lag2])/sqrt(nS);

%% =================== Performance - Conditions (Lag 4) ===================

perf_DC_lag4                 = [rsvpGRP.perf_DC_lag4];
perf_DC_lag4_sem             = std([rsvpGRP.perf_DC_lag4])/sqrt(nS);

hit_rate_DC_lag4             = mean([rsvpGRP.hit_rate_DC_lag4 ]);
reject_rate_DC_lag4          = mean([rsvpGRP.reject_rate_DC_lag4 ]);
miss_rate_DC_lag4            = mean([rsvpGRP.miss_rate_DC_lag4 ]);
falseAlarm_rate_DC_lag4      = mean([rsvpGRP.falseAlarm_rate_DC_lag4 ]);

% Control Condition
perf_CC_lag4                 = ([rsvpGRP.perf_CC_lag4]);
perf_CC_lag4_sem             = std([rsvpGRP.perf_CC_lag4])/sqrt(nS);

hit_rate_CC_lag4             = mean([rsvpGRP.hit_rate_CC_lag4 ]);
reject_rate_CC_lag4          = mean([rsvpGRP.reject_rate_CC_lag4 ]);
miss_rate_CC_lag4            = mean([rsvpGRP.miss_rate_CC_lag4 ]);
falseAlarm_rate_CC_lag4      = mean([rsvpGRP.falseAlarm_rate_CC_lag4 ]);

% Beneficial Condition
perf_BC_lag4                 = ([rsvpGRP.perf_BC_lag4]);
perf_BC_lag4_sem             = std([rsvpGRP.perf_BC_lag4])/sqrt(nS);

hit_rate_BC_lag4             = mean([rsvpGRP.hit_rate_BC_lag4 ]);
reject_rate_BC_lag4          = mean([rsvpGRP.reject_rate_BC_lag4 ]);
miss_rate_BC_lag4            = mean([rsvpGRP.miss_rate_BC_lag4 ]);
falseAlarm_rate_BC_lag4      = mean([rsvpGRP.falseAlarm_rate_BC_lag4 ]);

disp(['Emotion Lag 4: ',num2str(round(mean(perf_DC_lag4))), '% for DC, ', ...
    num2str(round(mean(perf_CC_lag4))), '% for CC & ',...
    num2str(round(mean(perf_BC_lag4))), '% for BC']);

perf_DC_smallRwd_lag4        = mean([rsvpGRP.perf_DC_smallRwd_lag4]);
perf_DC_smallRwd_lag4_sem    = std([rsvpGRP.perf_DC_smallRwd_lag4])/sqrt(nS);

perf_DC_largeRwd_lag4        = mean([rsvpGRP.perf_DC_largeRwd_lag4]);
perf_DC_largeRwd_lag4_sem    = std([rsvpGRP.perf_DC_largeRwd_lag4])/sqrt(nS);

perf_CC_smallRwd_lag4        = mean([rsvpGRP.perf_CC_smallRwd_lag4]);
perf_CC_smallRwd_lag4_sem    = std([rsvpGRP.perf_CC_smallRwd_lag4])/sqrt(nS);

perf_CC_largeRwd_lag4        = mean([rsvpGRP.perf_CC_largeRwd_lag4]);
perf_CC_largeRwd_lag4_sem    = std([rsvpGRP.perf_CC_largeRwd_lag4])/sqrt(nS);

perf_BC_smallRwd_lag4        = mean([rsvpGRP.perf_BC_smallRwd_lag4]);
perf_BC_smallRwd_lag4_sem    = std([rsvpGRP.perf_BC_smallRwd_lag4])/sqrt(nS);

perf_BC_largeRwd_lag4        = mean([rsvpGRP.perf_BC_largeRwd_lag4]);
perf_BC_largeRwd_lag4_sem    = std([rsvpGRP.perf_BC_largeRwd_lag4])/sqrt(nS);

%% =================== Learning Curves                  ===================

LC_lag2                      = zeros(subj_idx,12);
LC_smallRwd_lag2             = zeros(subj_idx,6);
LC_largeRwd_lag2             = zeros(subj_idx,6);
LC_DC_lag2                   = zeros(subj_idx,6);
LC_BC_lag2                   = zeros(subj_idx,6);
LC_CC_lag2                   = zeros(subj_idx,6);

LC_lag4                      = zeros(subj_idx,12);
LC_smallRwd_lag4             = zeros(subj_idx,6);
LC_largeRwd_lag4             = zeros(subj_idx,6);
LC_DC_lag4                   = zeros(subj_idx,6);
LC_BC_lag4                   = zeros(subj_idx,6);
LC_CC_lag4                   = zeros(subj_idx,6);

% RTsC_lag2                    = zeros(subj_idx,12);
% RTsC_smallRwd_lag2           = zeros(subj_idx,6);
% RTsC_largeRwd_lag2           = zeros(subj_idx,6);
% RTsC_DC_lag2                 = zeros(subj_idx,6);
% RTsC_BC_lag2                 = zeros(subj_idx,6);
% RTsC_CC_lag2                 = zeros(subj_idx,6);

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC_lag2(subj_idx,block)                = rsvpGRP(subj_idx).LC_lag2(block);
        LC_lag4(subj_idx,block)                = rsvpGRP(subj_idx).LC_lag4(block);
        %         RTsC_lag2(subj_idx,block)              = rsvpGRP(subj_idx).RTsC_lag2(block);
    end
    
    for blockCondi = 1:6
        LC_smallRwd_lag2(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_smallRwd_lag2(blockCondi);
        LC_largeRwd_lag2(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_largeRwd_lag2(blockCondi);
        LC_DC_lag2(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_DC_lag2(blockCondi);
        LC_BC_lag2(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_BC_lag2(blockCondi);
        LC_CC_lag2(subj_idx,blockCondi)        = (rsvpGRP(subj_idx).LC_CC_lag2(blockCondi) + rsvpGRP(subj_idx).LC_CC_lag2(blockCondi + 6))/2;
        
        LC_smallRwd_lag4(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_smallRwd_lag4(blockCondi);
        LC_largeRwd_lag4(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_largeRwd_lag4(blockCondi);
        LC_DC_lag4(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_DC_lag4(blockCondi);
        LC_BC_lag4(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_BC_lag4(blockCondi);
        LC_CC_lag4(subj_idx,blockCondi)        = (rsvpGRP(subj_idx).LC_CC_lag4(blockCondi) + rsvpGRP(subj_idx).LC_CC_lag4(blockCondi + 6))/2;
        
        %         RTsC_smallRwd_lag2(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_smallRwd_lag2(blockCondi);
        %         RTsC_largeRwd_lag2(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_largeRwd_lag2(blockCondi);
        %         RTsC_DC_lag2(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_DC_lag2(blockCondi);
        %         RTsC_BC_lag2(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_BC_lag2(blockCondi);
        %         RTsC_CC_lag2(subj_idx,blockCondi)      = (rsvpGRP(subj_idx).RTsC_CC_lag2(blockCondi) + rsvpGRP(subj_idx).RTsC_CC_lag2(blockCondi + 6))/2;
        
    end
end

%% =================== PLOT PART                        ===================

%% Performance Plots
% Performance par conditions
figure('Name', 'RSVP Performance Plots');
subplot(2,3,1)
hold on;
bar(1, mean(perf_DC_lag2),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
bar(1.5, mean(perf_CC_lag2),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
bar(2, mean(perf_BC_lag2),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
errorbar(1, mean(perf_DC_lag2), perf_DC_lag2_sem, 'k.','LineWidth',1);
errorbar(1.5, mean(perf_CC_lag2), perf_CC_lag2_sem, 'k.','LineWidth',1);
errorbar(2, mean(perf_BC_lag2), perf_BC_lag2_sem, 'k.','LineWidth',1);

bar(3, mean(perf_DC_lag4),'FaceColor',[.55 .25 .35], 'BarWidth',.5)
bar(3.5, mean(perf_CC_lag4),'FaceColor',[.75 .75 .75], 'BarWidth',.5);
bar(4, mean(perf_BC_lag4),'FaceColor',[.40 .55 .40], 'BarWidth',.5)
errorbar(3, mean(perf_DC_lag4), perf_DC_lag4_sem, 'k.','LineWidth',1);
errorbar(3.5, mean(perf_CC_lag4), perf_CC_lag4_sem, 'k.','LineWidth',1);
errorbar(4, mean(perf_BC_lag4), perf_BC_lag4_sem, 'k.','LineWidth',1);

xticks([1.5 3.5])
xticklabels({'Lag 2', 'Lag 4'})
legend('DC','CC','BC','fontsize', 6 , 'Location', 'southeast')
ylabel('Performance','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 5 50 105])
grid minor
box on
hold off

% STD Performance per conditions 
subplot(2,3,2)
hold on;
b1 = bar([1, 1.5], [hit_rate_DC_lag2, reject_rate_DC_lag2, falseAlarm_rate_DC_lag2, miss_rate_DC_lag2 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b1(1).CData = [.7 .9 .5]; b1(2).CData = [.3 .7 .0]; b1(3).CData = [.9 .5 .7]; b1(4).CData = [.7 .0 .3];
b2 = bar([1.5, 2], [hit_rate_CC_lag2, reject_rate_CC_lag2, falseAlarm_rate_CC_lag2, miss_rate_CC_lag2 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b2(1).CData = [.7 .9 .5]; b2(2).CData = [.3 .7 .0]; b2(3).CData = [.9 .5 .7]; b2(4).CData = [.7 .0 .3];
b3 = bar([2, 2.5], [hit_rate_BC_lag2, reject_rate_BC_lag2, falseAlarm_rate_BC_lag2, miss_rate_BC_lag2 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b3(1).CData = [.7 .9 .5]; b3(2).CData = [.3 .7 .0]; b3(3).CData = [.9 .5 .7]; b3(4).CData = [.7 .0 .3];
b1 = bar([3, 3.5], [hit_rate_DC_lag4, reject_rate_DC_lag4, falseAlarm_rate_DC_lag4, miss_rate_DC_lag4 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b1(1).CData = [.7 .9 .5]; b1(2).CData = [.3 .7 .0]; b1(3).CData = [.9 .5 .7]; b1(4).CData = [.7 .0 .3];
b2 = bar([3.5, 4], [hit_rate_CC_lag4, reject_rate_CC_lag4, falseAlarm_rate_CC_lag4, miss_rate_CC_lag4 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b2(1).CData = [.7 .9 .5]; b2(2).CData = [.3 .7 .0]; b2(3).CData = [.9 .5 .7]; b2(4).CData = [.7 .0 .3];
b3 = bar([4, 4.5], [hit_rate_BC_lag4, reject_rate_BC_lag4, falseAlarm_rate_BC_lag4, miss_rate_BC_lag4 ; 0 0 0 0], 'stacked', 'FaceColor','flat', 'BarWidth',1);
b3(1).CData = [.7 .9 .5]; b3(2).CData = [.3 .7 .0]; b3(3).CData = [.9 .5 .7]; b3(4).CData = [.7 .0 .3];
ylabel('Performance','fontsize', 10)
xticks([1.5 3.5])
xticklabels({'Lag 2', 'Lag 4'})
legend({'Hit', 'Reject', 'FA', 'Miss'},'fontsize', 6 , 'Location', 'southeast')
title('STD Performance According to Conditions','fontsize', 10)
axis([0 5 0 105])
grid minor
box on
hold off

% Performance par rewards
subplot(2,3,3)
hold on;
rwd_plotY = [smallRwd_rate_lag2.', largeRwd_rate_lag2.',smallRwd_rate_lag4.', largeRwd_rate_lag4.'];
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
legend({'Mean', 'Small Rwd', 'Large Rwd'},'fontsize', 6 , 'Location', 'southeast')
xticklabels({'Lag 2','Lag 4'})
ylabel('Performance','fontsize', 10)
title('Performance According to Reward Size','fontsize', 10)
axis([0 5 65 100])
grid minor
box on
hold off

perf_DC_largeRwd = {perf_DC_largeRwd_lag2 ,perf_DC_largeRwd_lag4 };
perf_CC_largeRwd = {perf_CC_largeRwd_lag2 ,perf_CC_largeRwd_lag4 };
perf_BC_largeRwd = {perf_BC_largeRwd_lag2 ,perf_BC_largeRwd_lag4 };
perf_DC_smallRwd = {perf_DC_smallRwd_lag2 ,perf_DC_smallRwd_lag4 };
perf_CC_smallRwd = {perf_CC_smallRwd_lag2 ,perf_CC_smallRwd_lag4 };
perf_BC_smallRwd = {perf_BC_smallRwd_lag2 ,perf_BC_smallRwd_lag4 };

perf_DC_largeRwd_sem = {perf_DC_largeRwd_lag2_sem ,perf_DC_largeRwd_lag4_sem };
perf_CC_largeRwd_sem = {perf_CC_largeRwd_lag2_sem ,perf_CC_largeRwd_lag4_sem };
perf_BC_largeRwd_sem = {perf_BC_largeRwd_lag2_sem ,perf_BC_largeRwd_lag4_sem };
perf_DC_smallRwd_sem = {perf_DC_smallRwd_lag2_sem ,perf_DC_smallRwd_lag4_sem };
perf_CC_smallRwd_sem = {perf_CC_smallRwd_lag2_sem ,perf_CC_smallRwd_lag4_sem };
perf_BC_smallRwd_sem = {perf_BC_smallRwd_lag2_sem ,perf_BC_smallRwd_lag4_sem };

rwd_title = {'Lag 2', 'Lag 4'}; 
for i = 1:2
    subplot(2,2,i + 2)
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
    e1.Color = [.45, .75, .80];
    line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
    xticks([1 2 3])
    legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
    xticklabels({'DC','CC','BC '})
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    title(rwd_title{i},'fontsize', 10)
    axis([0 4 70 100])
    grid minor
    box on
    hold off
end

%% Learning Curves Plots
figure('Name', 'Lag RSVP Learning Curve Plots');

LC = {LC_lag2, LC_lag4};
LC_title = {'Learning Curve LAG 2', 'Learning Curve LAG 4 '};
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
    axis([0 (length(LC{i})+1) 70 100])
    grid minor
    box on
end

LC_largeRwd = {LC_largeRwd_lag2, LC_largeRwd_lag4};
LC_smallRwd = {LC_smallRwd_lag2, LC_smallRwd_lag4};
for i = 1:2
    subplot(2,4,i + 4)
    hold on
    p2 = plot(1:6, mean(LC_largeRwd{i}),'-o','linew',1.5);
    p2.Color = [.00, .45, .55];
    p1 = plot(1:6, mean(LC_smallRwd{i}),'-x','linew',1.5);
    p1.Color = [.45, .75, .80];
    shadedErrorBar(1:6,mean(LC_largeRwd{i}),(std(LC_largeRwd{i})/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(LC_smallRwd{i}),(std(LC_smallRwd{i})/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.3);
    legend('Large Rwd','Small Rwd', 'Location', 'southeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title(LC_title{i},'fontsize', 10)
    axis([0 7 70 100])
    hold off
    grid minor
    box on
end

LC_DC = {LC_DC_lag2, LC_DC_lag4};
LC_CC = {LC_CC_lag2, LC_CC_lag4};
LC_BC = {LC_BC_lag2, LC_BC_lag4};
for i = 1:2
    subplot(2,4, i + 6)
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
    legend({'DC','BC'}, 'Location', 'southeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title(LC_title{i},'fontsize', 10)
    axis([0 7 70 100])
    hold off
    grid minor
    box on
end