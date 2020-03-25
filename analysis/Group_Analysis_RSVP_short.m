% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 12346, 81477, 90255, 33222, 90255, 48680]; 

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP_short(subject_ID(subj_idx), false);
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

rt                      = [rsvpGRP.rt];
[h_RT, p_RT]            = adtest(rt); % Normality Anderson-Darling test

nS                      = length(subject_ID);
disp(['Number of subjects: ',num2str(nS)]);


%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf                    = [rsvpGRP.performance];
[h_perf, p_perf]        = adtest(perf); % Normality Anderson-Darling test
perf_min                = min([rsvpGRP.performance]);
perf_max                = max([rsvpGRP.performance]);
perf_sem                = std([rsvpGRP.performance])/sqrt(nS);

disp(['Mean : ', ...
    num2str(round(mean(perf))), '% correct (min perf : ', ...
    num2str(round(perf_min)), '% & max perf : ', ...
    num2str(round(perf_max)), '%) ']) ;

hit_rate                = mean([rsvpGRP.hit_rate]);
reject_rate             = mean([rsvpGRP.reject_rate]);
miss_rate               = mean([rsvpGRP.miss_rate]);
falseAlarm_rate         = mean([rsvpGRP.falseAlarm_rate]);

disp(['Sdt : ', ...
    num2str(round(hit_rate)), '% hit rate, ', ...
    num2str(round(reject_rate)), '% reject rate, ', ...
    num2str(round(miss_rate)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate)), '% false alarm ']) ;

perf_lag2               = [rsvpGRP.lag2_rate];
perf_lag2_sem           = std([rsvpGRP.lag2_rate])/sqrt(nS);

perf_lag4               = [rsvpGRP.lag4_rate];
perf_lag4_sem           = std([rsvpGRP.lag4_rate])/sqrt(nS);

[h_lag,p_lag, ci_lag]   = ttest2(perf_lag2, perf_lag4); 
if h_lag == 1 
    disp(['The ttest rejects the null hypothesis that the performance between lag 2 and lag 4 has a mean equal to zero at ', ...
        num2str(p_lag), ' of p-value with a CI [', num2str(ci_lag(1)),'-', num2str(ci_lag(2)),']']); 
elseif  h_lag == 0 
    disp(['The ttest does not reject the null hypothesis that the performance between lag 2 and lag 4 has a mean equal to zero at ', ...
        num2str(p_lag), ' of p-value with a CI [', num2str(ci_lag(1)),'-', num2str(ci_lag(2)),']']); 
end 

disp(['Lag : ', ...
    num2str(round(mean(perf_lag2))), '% for lag 2 & ', ...
    num2str(round(mean(perf_lag4))), '% for lag 4 ']) ;

%% =================== Performance - Rewards            ===================
smallRwd_rate           = [rsvpGRP.smallRwd_rate];
smallRwd_rate_sem       = std([rsvpGRP.smallRwd_rate])/sqrt(nS);

largeRwd_rate           = [rsvpGRP.largeRwd_rate];
largeRwd_rate_sem       = std([rsvpGRP.largeRwd_rate])/sqrt(nS);

disp(['Reward : ',num2str(round(mean(smallRwd_rate))), '% for small rwd & ', ...
    num2str(round(mean(largeRwd_rate))), '% for large rwd' ]);

%% =================== Performance - Genders            ===================

perf_fem                = mean([rsvpGRP.perf_fem]);
perf_fem_sem            = std([rsvpGRP.perf_fem]);

perf_hom                = mean([rsvpGRP.perf_hom]);
perf_hom_sem            = std([rsvpGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

%% =================== Performance - Conditions         ===================

perf_DC                 = [rsvpGRP.perf_DC];
perf_DC_sem             = std([rsvpGRP.perf_DC])/sqrt(nS);

hit_rate_DC             = mean([rsvpGRP.hit_rate_DC ]);
reject_rate_DC          = mean([rsvpGRP.reject_rate_DC ]);
miss_rate_DC            = mean([rsvpGRP.miss_rate_DC ]);
falseAlarm_rate_DC      = mean([rsvpGRP.falseAlarm_rate_DC ]);

perf_CC_DC              = [rsvpGRP.perf_CC_DC];
perf_CC_DC_sem          = std([rsvpGRP.perf_CC_DC])/sqrt(nS);

perf_CC                 = ([rsvpGRP.perf_CC]);
perf_CC_sem             = std([rsvpGRP.perf_CC])/sqrt(nS);

hit_rate_CC             = mean([rsvpGRP.hit_rate_CC ]);
reject_rate_CC          = mean([rsvpGRP.reject_rate_CC ]);
miss_rate_CC            = mean([rsvpGRP.miss_rate_CC ]);
falseAlarm_rate_CC      = mean([rsvpGRP.falseAlarm_rate_CC ]);

perf_CC_BC              = ([rsvpGRP.perf_CC_BC]);
perf_CC_BC_sem          = std([rsvpGRP.perf_CC_BC])/sqrt(nS);

perf_BC                 = ([rsvpGRP.perf_BC]);
perf_BC_sem             = std([rsvpGRP.perf_BC])/sqrt(nS);

hit_rate_BC             = mean([rsvpGRP.hit_rate_BC ]);
reject_rate_BC          = mean([rsvpGRP.reject_rate_BC ]);
miss_rate_BC            = mean([rsvpGRP.miss_rate_BC ]);
falseAlarm_rate_BC      = mean([rsvpGRP.falseAlarm_rate_BC ]);

disp(['Emotion : ',num2str(round(mean(perf_DC))), '% for DC, ', ...
    num2str(round(mean(perf_CC))), '% for CC & ',...
    num2str(round(mean(perf_BC))), '% for BC']);

perf_DC_smallRwd        = mean([rsvpGRP.perf_DC_smallRwd]);
perf_DC_smallRwd_sem    = std([rsvpGRP.perf_DC_smallRwd])/sqrt(nS);

perf_DC_largeRwd        = mean([rsvpGRP.perf_DC_largeRwd]);
perf_DC_largeRwd_sem    = std([rsvpGRP.perf_DC_largeRwd])/sqrt(nS);

perf_CC_smallRwd        = mean([rsvpGRP.perf_CC_smallRwd]);
perf_CC_smallRwd_sem    = std([rsvpGRP.perf_CC_smallRwd])/sqrt(nS);

perf_CC_largeRwd        = mean([rsvpGRP.perf_CC_largeRwd]);
perf_CC_largeRwd_sem    = std([rsvpGRP.perf_CC_largeRwd])/sqrt(nS);

perf_CC_DC_smallRwd     = mean([rsvpGRP.perf_CC_DC_smallRwd]);
perf_CC_DC_smallRwd_sem = std([rsvpGRP.perf_CC_DC_smallRwd])/sqrt(nS);

perf_CC_DC_largeRwd     = mean([rsvpGRP.perf_CC_DC_largeRwd]);
perf_CC_DC_largeRwd_sem = std([rsvpGRP.perf_CC_DC_largeRwd])/sqrt(nS);

perf_CC_BC_smallRwd     = mean([rsvpGRP.perf_CC_BC_smallRwd]);
perf_CC_BC_smallRwd_sem = std([rsvpGRP.perf_CC_BC_smallRwd])/sqrt(nS);

perf_CC_BC_largeRwd     = mean([rsvpGRP.perf_CC_BC_largeRwd]);
perf_CC_BC_largeRwd_sem = std([rsvpGRP.perf_CC_BC_largeRwd])/sqrt(nS);

perf_BC_smallRwd        = mean([rsvpGRP.perf_BC_smallRwd]);
perf_BC_smallRwd_sem    = std([rsvpGRP.perf_BC_smallRwd])/sqrt(nS);

perf_BC_largeRwd        = mean([rsvpGRP.perf_BC_largeRwd]);
perf_BC_largeRwd_sem    = std([rsvpGRP.perf_BC_largeRwd])/sqrt(nS);

%% =================== RTs - General                    ===================

disp('=================== RTs information ===================');

rt_correct              = ([rsvpGRP.rt_correct]);

rt_hit                  = ([rsvpGRP.rt_hit]);
rt_reject               = ([rsvpGRP.rt_reject]);

rt_incorrect            = ([rsvpGRP.rt_incorrect]);

rt_falseAlarm           = ([rsvpGRP.rt_falseAlarm]);
rt_miss                 = ([rsvpGRP.rt_miss]);

disp(['Correct : ',num2str(nanmean(rt_correct)), ' s for correct trials including ', ...
    num2str(nanmean(rt_hit)), ' s for hits & ', num2str(nanmean(rt_reject)), ' s for rejections']);

disp(['Incorrect : ',num2str(nanmean(rt_incorrect)), ' s for incorrect trials including ', ...
    num2str(nanmean(rt_falseAlarm)), ' s for false alarms & ', num2str(nanmean(rt_miss)), ' s for misses']);

%% =================== RTs - Rewards                    ===================

rt_smallRwd             = [rsvpGRP.rt_smallRwd];
rt_smallRwd_correct     = [rsvpGRP.rt_smallRwd_correct];
rt_smallRwd_incorrect   = [rsvpGRP.rt_smallRwd_incorrect];
rt_smallRwd_diff        = rt_smallRwd_incorrect-rt_smallRwd_correct;

rt_largeRwd             = [rsvpGRP.rt_largeRwd];
rt_largeRwd_correct     = [rsvpGRP.rt_largeRwd_correct];
rt_largeRwd_incorrect   = [rsvpGRP.rt_largeRwd_incorrect];
rt_largeRwd_diff        = rt_largeRwd_incorrect-rt_largeRwd_correct;

disp(['Small reward : ',...
    num2str(mean(rt_smallRwd)), ' s (', ...
    num2str(mean(rt_smallRwd_correct)), ' s for correct & ', ...
    num2str(mean(rt_smallRwd_incorrect)), ' s for incorrect)']);

disp(['Large reward : ', ...
    num2str(mean(rt_largeRwd)), ' s (', ...
    num2str(mean(rt_largeRwd_correct)), ' s for correct & ', ...
    num2str(mean(rt_largeRwd_incorrect)), ' s for incorrect)']);

%% =================== RTs - Genders                    ===================

rt_fem                  =  mean([rsvpGRP.rt_fem]);
rt_fem_sem              =  std([rsvpGRP.rt_fem]);

rt_hom                  =  mean([rsvpGRP.rt_hom]);
rt_hom_sem              =  std([rsvpGRP.rt_hom]);

disp(['Genders: ',num2str(rt_fem), ' s for condition femme & ', ...
    num2str(rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions                 ===================

rt_DC                   = [rsvpGRP.rt_DC];
rt_DC_correct           = [rsvpGRP.rt_DC_correct];
rt_DC_incorrect         = [rsvpGRP.rt_DC_incorrect];
rt_DC_diff              = rt_DC_incorrect-rt_DC_correct;

rt_CC                   = [rsvpGRP.rt_CC];
rt_CC_correct           = [rsvpGRP.rt_CC_correct];
rt_CC_incorrect         = [rsvpGRP.rt_CC_incorrect];
rt_CC_diff              = rt_CC_incorrect-rt_CC_correct;

rt_BC                   = [rsvpGRP.rt_BC];
rt_BC_correct           = [rsvpGRP.rt_BC_correct];
rt_BC_incorrect         = [rsvpGRP.rt_BC_incorrect];
rt_BC_diff              = rt_BC_incorrect-rt_BC_correct;

disp(['DC : ',...
    num2str(mean(rt_DC)), ' s (', ...
    num2str(mean(rt_DC_correct)), ' s for correct & ', ...
    num2str(mean(rt_DC_incorrect)), ' s for incorrect)']);

disp(['CC : ', ...
    num2str(mean(rt_CC)), ' s (', ...
    num2str(mean(rt_CC_correct)), ' s for correct & ', ...
    num2str(mean(rt_CC_incorrect)), ' s for incorrect)']);

disp(['BC : ', ...
    num2str(nanmean(rt_BC)), ' s (', ...
    num2str(nanmean(rt_BC_correct)), ' s for correct & ', ...
    num2str(nanmean(rt_BC_incorrect)), ' s for incorrect)']);

%% =================== RTs - Conditions & Reward        ===================

rt_DC_smallRwd          = [rsvpGRP.rt_DC_smallRwd];

rt_DC_largeRwd          = [rsvpGRP.rt_DC_largeRwd];

rt_CC_smallRwd          = [rsvpGRP.rt_CC_smallRwd];

rt_CC_largeRwd          = [rsvpGRP.rt_CC_largeRwd];

rt_BC_smallRwd          = [rsvpGRP.rt_BC_smallRwd];

rt_BC_largeRwd          = [rsvpGRP.rt_BC_largeRwd];

disp(['Small Reward : ',...
    num2str(nanmean(rt_DC_smallRwd)), ' s for DC, ', ...
    num2str(nanmean(rt_CC_smallRwd)), ' s for CC & ', ...
    num2str(nanmean(rt_BC_smallRwd)), ' s for BC ']);

disp(['Large Reward : ',...
    num2str(nanmean(rt_DC_largeRwd)), ' s for DC, ', ...
    num2str(nanmean(rt_CC_largeRwd)), ' s for CC & ', ...
    num2str(nanmean(rt_BC_largeRwd)), ' s for BC ']);

%% =================== Learning Curves                  ===================

LC                      = zeros(subj_idx,12);
LC_smallRwd             = zeros(subj_idx,6);
LC_largeRwd             = zeros(subj_idx,6);
LC_DC                   = zeros(subj_idx,6);
LC_BC                   = zeros(subj_idx,6);
LC_CC                   = zeros(subj_idx,6);

RTsC                    = zeros(subj_idx,12);
RTsC_smallRwd           = zeros(subj_idx,6);
RTsC_largeRwd           = zeros(subj_idx,6);
RTsC_DC                 = zeros(subj_idx,6);
RTsC_BC                 = zeros(subj_idx,6);
RTsC_CC                 = zeros(subj_idx,6);

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC(subj_idx,block)                = rsvpGRP(subj_idx).LC(block);
        %LC_CC(subj_idx,block)             = rsvpGRP(subj_idx).LC_CC(block);
        RTsC(subj_idx,block)              = rsvpGRP(subj_idx).RTsC(block);
        %RTsC_CC(subj_idx,block)           = rsvpGRP(subj_idx).RTsC_CC(block);    

    end
    
    for blockCondi = 1:2
        LC_smallRwd(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_smallRwd(blockCondi);
        LC_largeRwd(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_largeRwd(blockCondi);
        LC_DC(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_DC(blockCondi);
        LC_BC(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_BC(blockCondi);
        LC_CC(subj_idx,blockCondi)        = (rsvpGRP(subj_idx).LC_CC(blockCondi) + rsvpGRP(subj_idx).LC_CC(blockCondi + 6))/2;
        
        RTsC_smallRwd(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_smallRwd(blockCondi);
        RTsC_largeRwd(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_largeRwd(blockCondi);
        RTsC_DC(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_DC(blockCondi);
        RTsC_BC(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_BC(blockCondi);
        RTsC_CC(subj_idx,blockCondi)      = (rsvpGRP(subj_idx).RTsC_CC(blockCondi) + rsvpGRP(subj_idx).RTsC_CC(blockCondi + 6))/2;

    end
end

%% =================== PLOT PART                        ===================

%% Performance Plots
% Performance par conditions
figure('Name', 'RSVP Performance Plots');
subplot(2,3,1)
hold on;
bar(1, mean(perf_DC),'FaceColor',[.55 .25 .35])
b1 = bar((2-.8/3), mean(perf_CC_DC),'FaceColor',[.85 .75 .75], 'BarWidth',.8/3);
b2 = bar((2), mean(perf_CC),'FaceColor',[.75 .75 .75], 'BarWidth',.8/3);
b3 = bar((2+.8/3), mean(perf_CC_BC),'FaceColor',[.75 .85 .75], 'BarWidth',.8/3);
bar(3, mean(perf_BC),'FaceColor',[.40 .55 .40])
errorbar(1, mean(perf_DC), perf_DC_sem, 'k.','LineWidth',1);
errorbar((2-.8/3), mean(perf_CC_DC), perf_CC_DC_sem, 'k.','LineWidth',.8);
errorbar((2), mean(perf_CC), perf_CC_sem, 'k.','LineWidth',.8);
errorbar((2+.8/3), mean(perf_CC_BC), perf_CC_BC_sem, 'k.','LineWidth',.8);
errorbar(3, mean(perf_BC), perf_BC_sem, 'k.','LineWidth',1);
xticks([1 2 3])
xticklabels({'DC','CC','BC'})
legend([b1 b2 b3],{'CC (DC)','CC', 'CC (BC)'},'fontsize', 6, 'location','northeast')
ylabel('Performance','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 4 70 100])
grid minor
box on
hold off

% STD Performance per conditions 

subplot(2,3,2)
hold on;
b1 = bar([2, 3], [hit_rate_DC, reject_rate_DC, falseAlarm_rate_DC, miss_rate_DC ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b1(1).CData = [.7 .9 .5]; b1(2).CData = [.3 .7 .0]; b1(3).CData = [.9 .5 .7]; b1(4).CData = [.7 .0 .3];
b2 = bar([3, 4], [hit_rate_CC, reject_rate_CC, falseAlarm_rate_CC, miss_rate_CC ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b2(1).CData = [.7 .9 .5]; b2(2).CData = [.3 .7 .0]; b2(3).CData = [.9 .5 .7]; b2(4).CData = [.7 .0 .3];
b3 = bar([4, 5], [hit_rate_BC, reject_rate_BC, falseAlarm_rate_BC, miss_rate_BC ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b3(1).CData = [.7 .9 .5]; b3(2).CData = [.3 .7 .0]; b3(3).CData = [.9 .5 .7]; b3(4).CData = [.7 .0 .3];
xticks([2 3 4])
xticklabels({'DC','CC','BC'})
ylabel('Performance','fontsize', 10)
legend({'Hit', 'Reject', 'FA', 'Miss'},'fontsize', 6 , 'Location', 'southeast')
title('STD Performance According to Conditions','fontsize', 10)
axis([1 5 0 105])
grid minor
box on
hold off


% Performance par rewards
subplot(2,3,3)
hold on;
rwd_plotY = [smallRwd_rate.', largeRwd_rate.'];
rwd_plotX = [1, 2];
rwd_plot_color = {[.00, .45, .55], [.45, .75, .80]};
B = boxplot(rwd_plotY, rwd_plotX,'Widths',.7);
get (B, 'tag'); 
set(B(1,:), 'color', 'k'); set(B(2,:), 'color', 'k');
set(B(6,:), 'color', 'k', 'linewidth', 2);
scatter(rwd_plotX,mean(rwd_plotY),'k','filled','d')
h = findobj(gca,'Tag','Box');
 for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),rwd_plot_color{j},'FaceAlpha',.7);
 end
xticks([1 2])
legend({'Mean'}, 'Location', 'southeast')
xticklabels({'Small Rwd','Large Rwd'})
ylabel('Performance','fontsize', 10)
title('Performance According to Reward Size','fontsize', 10)
axis([0 3 70 100])
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,2,3)
hold on;
bar(1, perf_DC_smallRwd,'FaceColor',[0.65 0.35 0.45], 'BarWidth',.5)
bar(1.5-.5/3, perf_CC_DC_smallRwd,'FaceColor',[0.95 0.85 0.85], 'BarWidth',.5/3)
bar(1.5, perf_CC_smallRwd,'FaceColor',[0.85 0.85 0.85], 'BarWidth',.5/3)
bar(1.5+.5/3, perf_CC_BC_smallRwd,'FaceColor',[0.85 0.95 0.85], 'BarWidth',.5/3)
bar(2, perf_BC_smallRwd,'FaceColor',[0.50 0.65 0.50], 'BarWidth',.5)

bar(3, perf_DC_largeRwd,'FaceColor',[0.45 0.15 0.25], 'BarWidth',.5)
bar(3.5-.5/3, perf_CC_DC_largeRwd,'FaceColor',[0.75 0.65 0.65], 'BarWidth',.5/3)
bar(3.5, perf_CC_largeRwd,'FaceColor',[0.65 0.65 0.65], 'BarWidth',.5/3)
bar(3.5+.5/3, perf_CC_BC_largeRwd,'FaceColor',[0.65 0.75 0.65], 'BarWidth',.5/3)
bar(4, perf_BC_largeRwd,'FaceColor',[0.30 0.45 0.30], 'BarWidth',.5)

errorbar(1, perf_DC_smallRwd, perf_DC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(1.5-.5/3, perf_CC_DC_smallRwd, perf_CC_DC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5, perf_CC_smallRwd, perf_CC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5+.5/3, perf_CC_BC_smallRwd, perf_CC_BC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(2, perf_BC_smallRwd, perf_BC_smallRwd_sem, 'k.','LineWidth',1)

errorbar(3, perf_DC_largeRwd, perf_DC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(3.5-.5/3, perf_CC_DC_largeRwd, perf_CC_DC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5, perf_CC_largeRwd, perf_CC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5+.5/3, perf_CC_BC_largeRwd, perf_CC_BC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(4, perf_BC_largeRwd, perf_BC_largeRwd_sem, 'k.','LineWidth',1)

xticks([1.5 3.5])
xticklabels({'Small Rwd', 'Large Rwd'})
legend({'DC','CC (DC)','CC', 'CC (BC)', 'BC'}, 'fontsize', 6 , 'Location', 'northeast')
ylabel('Performance','fontsize', 10)
title('Performance According to Rewards and Conditions','fontsize', 10)
axis([0 5 70 100])
grid minor
box on
hold off

subplot(2,2,4)
hold on;
p2 = plot(1:3,[perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], 'linewidth',2.3);
p2.Color = [.00, .45, .55];
p1 = plot(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], 'linewidth',2.3);
p1.Color = [.45, .75, .80];
shadedErrorBar(1:3, [perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem],'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.2);
e2 = errorbar(1:3,[perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem], 'k.','LineWidth',.9);
e2.Color = [.00, .45, .55];
shadedErrorBar(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem],'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.2);
e1 = errorbar(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem], 'k.','LineWidth',.9);
e1.Color = [.45, .75, .80];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
xticks([1 2 3])
legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
xticklabels({'DC','CC','BC '})
ylabel('Performance (mean +/- SEM)','fontsize', 10)
title('Performance According to Reward and Conditions','fontsize', 10)
axis([0 4 70 100])
grid minor
box on
hold off

%% RTs Plots
figure('Name', 'RSVP RTs Plots');
subplot(2,3,1)
histogram(rt,'FaceColor',[.5, .5, .5], 'EdgeColor', [.5 .5 .5])
xlabel('log(RTs) (mean +/- SEM)','fontsize', 10)
ylabel('Number of Trials','fontsize', 10)
title('Distribution of RSVP Reaction Times','fontsize', 10)
if h_RT == 0
    text(-3,75,['The distribution is normal at p = ', num2str(round(p_RT,3))],'fontsize', 8)
elseif h_RT == 1
    text(-3,75,['The distribution is not normal at p = ', num2str(round(p_RT,3))],'fontsize', 8)
end
axis([-3 3 -inf inf])
grid minor
box on

% RTs par conditions
subplot(2,3,2)
hold on;
bar([nanmean(rt_DC) 0 0],'FaceColor',[0.75 0.45 0.55]);
bar([0 nanmean(rt_CC) 0],'FaceColor',[0.75 0.75 0.75]);
bar([0 0 nanmean(rt_BC)],'FaceColor',[0.40 0.55 0.40]);
errorbar(1, nanmean(rt_DC), nanstd(rt_DC)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_CC), nanstd(rt_CC)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3, nanmean(rt_BC), nanstd(rt_BC)/sqrt(nS), 'k.','LineWidth',1)
xticks([1 2 3 4])
xticklabels({'DC','CC', 'BC'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('RTs According to Conditions','fontsize', 10)
axis([0 4 -.8 .8])
grid minor
box on
hold off

% RTs par rewards
subplot(2,3,3)
hold on;
bar([nanmean(rt_smallRwd) 0],'FaceColor',[.45, .75, .80]);
bar([0 nanmean(rt_largeRwd)],'FaceColor',[.00, .45, .55]);
errorbar(1, nanmean(rt_smallRwd), nanstd(rt_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_largeRwd), nanstd(rt_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
xticks([1 2])
xticklabels({'Small Rwd','Large Rwd'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('RTs According to Reward Size','fontsize', 10)
axis([0 3 -.8 .8])
grid minor
box on
hold off

subplot(2,2,3)
hold on;
p2 = plot(1:3,[nanmean(rt_DC_largeRwd), nanmean(rt_CC_largeRwd), nanmean(rt_BC_largeRwd)], 'linewidth',2.3);
p2.Color = [.00, .45, .55];
p1 = plot(1:3,[nanmean(rt_DC_smallRwd), nanmean(rt_CC_smallRwd), nanmean(rt_BC_smallRwd)], 'linewidth',2.3);
p1.Color = [.45, .75, .80];
shadedErrorBar(1:3, [nanmean(rt_DC_largeRwd), nanmean(rt_CC_largeRwd),nanmean(rt_BC_largeRwd)], ...
    [nanstd(rt_DC_largeRwd), nanstd(rt_CC_largeRwd), nanstd(rt_BC_largeRwd)],'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.2);
e2 = errorbar(1:3,[nanmean(rt_DC_largeRwd), nanmean(rt_CC_largeRwd),nanmean(rt_BC_largeRwd)], ...
    [nanstd(rt_DC_largeRwd), nanstd(rt_CC_largeRwd), nanstd(rt_BC_largeRwd)], 'k.','LineWidth',.9);
e2.Color = [.00, .45, .55];
shadedErrorBar(1:3,[nanmean(rt_DC_smallRwd), nanmean(rt_CC_smallRwd),nanmean(rt_BC_smallRwd)], ...
    [nanstd(rt_DC_smallRwd)/sqrt(nS), nanstd(rt_CC_smallRwd)/sqrt(nS),nanstd(rt_BC_smallRwd)/sqrt(nS)],'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.2);
e1 = errorbar(1:3,[nanmean(rt_DC_smallRwd), nanmean(rt_CC_smallRwd),nanmean(rt_BC_smallRwd)], ...
    [nanstd(rt_DC_smallRwd)/sqrt(nS), nanstd(rt_CC_smallRwd)/sqrt(nS),nanstd(rt_BC_smallRwd)/sqrt(nS)], 'k.','LineWidth',.9);
e1.Color = [.45, .75, .80];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
xticks([1 2 3])
legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
xticklabels({'DC','CC','BC '})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('RTs According to Reward and Conditions','fontsize', 10)
axis([0 4 -1 1])
grid minor
box on
hold off

% RTs par conditions & rewards
subplot(2,2,4)
hold on;

p1 = plot(1:3,[nanmean(rt_DC_correct), nanmean(rt_CC_correct), nanmean(rt_BC_correct)], 'linewidth',2.3);
p1.Color = [.2 .5 .2];
p2 = plot(1:3,[nanmean(rt_DC_incorrect), nanmean(rt_CC_incorrect), nanmean(rt_BC_incorrect)], 'linewidth',2.3);
p2.Color = [.8 .3 .3];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
shadedErrorBar(1:3,[nanmean(rt_DC_correct), nanmean(rt_CC_correct), nanmean(rt_BC_correct)], ...
    [(nanstd(rt_DC_correct)/sqrt(nS)), (nanstd(rt_CC_correct)/sqrt(nS)), (nanstd(rt_BC_correct)/sqrt(nS))],'lineprops',{'Color',[.2 .5 .2]},'patchSaturation',.2);
e1 = errorbar(1:3,[nanmean(rt_DC_correct), nanmean(rt_CC_correct), nanmean(rt_BC_correct)], ...
    [(nanstd(rt_DC_correct)/sqrt(nS)), (nanstd(rt_CC_correct)/sqrt(nS)), (nanstd(rt_BC_correct)/sqrt(nS))], 'k.','LineWidth',.9);
e1.Color = [.2 .5 .2];
shadedErrorBar(1:3, [nanmean(rt_DC_incorrect), nanmean(rt_CC_incorrect), nanmean(rt_BC_incorrect)], ...
    [(nanstd(rt_DC_incorrect)/sqrt(nS)), (nanstd(rt_CC_incorrect)/sqrt(nS)), (nanstd(rt_BC_incorrect)/sqrt(nS))],'lineprops',{'Color',[.8 .3 .3]},'patchSaturation',.2);
e2 = errorbar(1:3,[nanmean(rt_DC_incorrect), nanmean(rt_CC_incorrect), nanmean(rt_BC_incorrect)], ...
    [(nanstd(rt_DC_incorrect)/sqrt(nS)), (nanstd(rt_CC_incorrect)/sqrt(nS)), (nanstd(rt_BC_incorrect)/sqrt(nS))], 'k.','LineWidth',.9);
e2.Color = [.8 .3 .3];
xticks([1 2 3])
xticklabels({'DC','CC',' BC'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('RTs for Correct and Incorrect Trials in Function of Conditions','fontsize', 10)
legend({'Correct','Incorrect'}, 'Location', 'southeast')
axis([0 4 -.8 .8])
grid minor
box on
hold off


%% Learning Curves Plots
figure('Name', 'RSVP Learning Curve Plots');

subplot(2,1,1)
p = plot(1:length(LC), mean(LC),'linew',1.5);
p.Color = [0 0 0];
shadedErrorBar(1:length(LC),mean(LC),(std(LC)/sqrt(nS)),'lineprops',{'Color',[0 0 0]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
ylabel('Performance (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:(length(LC)))
xticklabels(1:12)
title('Learning Curve RSVP Experiment','fontsize', 10)
axis([0 (length(LC)+1) 70 100])
grid minor
box on

subplot(2,2,3)
hold on
p2 = plot(1:6, mean(LC_largeRwd),'-o','linew',1.5);
p2.Color = [.00, .45, .55];
p1 = plot(1:6, mean(LC_smallRwd),'-x','linew',1.5);
p1.Color = [.45, .75, .80];
shadedErrorBar(1:6,mean(LC_largeRwd),(std(LC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(LC_smallRwd),(std(LC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
ylabel('Performance (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('Learning Curve for Small and Large Rewards','fontsize', 10)
axis([0 7 70 100])
hold off
grid minor
box on

subplot(2,2,4)
hold on
p1 = plot(1:6, mean(LC_DC),'-x','linew',1.5); 
p1.Color = [.75 .45 .55];
p2 = plot(1:6, mean(LC_CC),'-+','linew',1.5); %1:.5:6.5
p2.Color = [.50 .50 .50];
p3 = plot(1:6, mean(LC_BC),'-o','linew',1.5);
p3.Color = [.40 .55 .40];
shadedErrorBar(1:6,mean(LC_DC),(std(LC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(LC_CC),(std(LC_CC)/sqrt(nS)),'lineprops',{'Color',[.50 .50 .50]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(LC_BC),(std(LC_BC)/sqrt(nS)),'lineprops',{'Color',[.40 .55 .40]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
legend({'DC','CC','BC'}, 'Location', 'southeast')
ylabel('Performance (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('Learning Curve for Each Conditions','fontsize', 10)
axis([0 7 70 100])
hold off
grid minor
box on

%% RTs Curves Plots
figure('Name', 'RSVP RTs Curve Plots');

subplot(2,1,1)
p = plot(1:length(RTsC), mean(RTsC),'linew',1.5);
p.Color = [0 0 0];
shadedErrorBar(1:length(RTsC), mean(RTsC),(std(RTsC)/sqrt(nS)),'lineprops',{'Color',[0 0 0]},'patchSaturation',.3);
line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:(length(RTsC)))
xticklabels(1:12)
title('RTs Curve RSVP Experiment','fontsize', 10)
axis([0 (length(RTsC)+1) -1 0])
grid minor
box on

subplot(2,2,3)
hold on
p2 = plot(1:6, mean(RTsC_largeRwd),'-o','linew',1.5);
p2.Color = [.00, .45, .55];
p1 = plot(1:6, mean(RTsC_smallRwd),'-x','linew',1.5);
p1.Color = [.45, .75, .80];
shadedErrorBar(1:6,mean(RTsC_largeRwd),(std(RTsC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(RTsC_smallRwd),(std(RTsC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.3);
line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('RTs Curve for Small and Large Rewards','fontsize', 10)
axis([0 7 -1 0])
hold off
grid minor
box on

subplot(2,2,4)
hold on
p1 = plot(1:6, mean(RTsC_DC),'-x','linew',1.5); 
p1.Color = [.75 .45 .55];
p2 = plot(1:6, mean(RTsC_CC),'-+','linew',1.5); %1:.5:6.5 if 12 blocks 
p2.Color = [.50 .50 .50];
p3 = plot(1:6, mean(RTsC_BC),'-o','linew',1.5);
p3.Color = [.40 .55 .40];
shadedErrorBar(1:6,mean(RTsC_DC),(std(RTsC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(RTsC_CC),(std(RTsC_CC)/sqrt(nS)),'lineprops',{'Color',[.50 .50 .50]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(RTsC_BC),(std(RTsC_BC)/sqrt(nS)),'lineprops',{'Color',[.40 .55 .40]},'patchSaturation',.3);
line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
legend({'DC','CC','BC'}, 'Location', 'southeast')
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('RTs Curve for Each Conditions','fontsize', 10)
axis([0 7 -1 0])
hold off
grid minor
box on

