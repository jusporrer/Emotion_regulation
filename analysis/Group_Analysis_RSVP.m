% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 12346, 81477, 90255, 33222, 90255, 48680]; 

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP(subject_ID(subj_idx), false);
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

rt              = [rsvpGRP.rt];

nS              = length(subject_ID);
disp(['Number of subjects: ',num2str(nS)]);

nExcTrial       = [rsvpGRP.nExcTrial];

disp(['Number of excluded trials : ',num2str(mean(nExcTrial))]);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf            = mean([rsvpGRP.performance]);
perf_min        = min([rsvpGRP.performance]);
perf_max        = max([rsvpGRP.performance]);
perf_sem        = std([rsvpGRP.performance])/sqrt(nS);

disp(['Mean : ', ...
    num2str(round(perf)), '% correct (min perf : ', ...
    num2str(round(perf_min)), '% & max perf : ', ...
    num2str(round(perf_max)), '%) ']) ;

hit_rate        = mean([rsvpGRP.hit_rate]);
reject_rate     = mean([rsvpGRP.reject_rate]);

miss_rate       = mean([rsvpGRP.miss_rate]);
falseAlarm_rate = mean([rsvpGRP.falseAlarm_rate]);

disp(['Sdt : ', ...
    num2str(round(hit_rate)), '% hit rate, ', ...
    num2str(round(reject_rate)), '% reject rate, ', ...
    num2str(round(miss_rate)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate)), '% false alarm ']) ;

perf_lag2       = mean([rsvpGRP.lag2_rate]);
perf_lag2_sem   = std([rsvpGRP.lag2_rate])/sqrt(nS);

perf_lag4       = mean([rsvpGRP.lag4_rate]);
perf_lag4_sem   = std([rsvpGRP.lag4_rate])/sqrt(nS);

disp(['Lag : ', ...
    num2str(round(perf_lag2)), '% for lag 2 & ', ...
    num2str(round(perf_lag4)), '% for lag 4 ']) ;

%% =================== Performance - Rewards            ===================
smallRwd_rate       = mean([rsvpGRP.smallRwd_rate]);
smallRwd_rate_sem   = std([rsvpGRP.smallRwd_rate])/sqrt(nS);

largeRwd_rate       = mean([rsvpGRP.largeRwd_rate]);
largeRwd_rate_sem   = std([rsvpGRP.largeRwd_rate])/sqrt(nS);

disp(['Reward : ',num2str(round(smallRwd_rate)), '% for small rwd & ', ...
    num2str(round(largeRwd_rate)), '% for large rwd' ]);

%% =================== Performance - Genders            ===================

perf_fem            = mean([rsvpGRP.perf_fem]);
perf_fem_sem        = std([rsvpGRP.perf_fem]);

perf_hom            = mean([rsvpGRP.perf_hom]);
perf_hom_sem        = std([rsvpGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

%% =================== Performance - Condition          ===================

perf_DC         = mean([rsvpGRP.perf_DC]);
perf_DC_sem     = std([rsvpGRP.perf_DC])/sqrt(nS);

perf_CC         = mean([rsvpGRP.perf_CC]);
perf_CC_sem     = std([rsvpGRP.perf_CC])/sqrt(nS);

perf_BC         = mean([rsvpGRP.perf_BC]);
perf_BC_sem     = std([rsvpGRP.perf_BC])/sqrt(nS);

disp(['Emotion : ',num2str(round(perf_DC)), '% for DC, ', ...
    num2str(round(perf_CC)), '% for CC & ',...
    num2str(ceil(perf_BC)), '% for BC']);

perf_DC_smallRwd        = mean([rsvpGRP.perf_DC_smallRwd]);
perf_DC_smallRwd_sem    = std([rsvpGRP.perf_DC_smallRwd])/sqrt(nS);

perf_DC_largeRwd        = mean([rsvpGRP.perf_DC_largeRwd]);
perf_DC_largeRwd_sem    = std([rsvpGRP.perf_DC_largeRwd])/sqrt(nS);

perf_CC_smallRwd        = mean([rsvpGRP.perf_CC_smallRwd]);
perf_CC_smallRwd_sem    = std([rsvpGRP.perf_CC_smallRwd])/sqrt(nS);

perf_CC_largeRwd        = mean([rsvpGRP.perf_CC_largeRwd]);
perf_CC_largeRwd_sem    = std([rsvpGRP.perf_CC_largeRwd])/sqrt(nS);

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

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC(subj_idx,block)                = rsvpGRP(subj_idx).LC(block);
    end
    
    for blockCondi = 1:6
        LC_smallRwd(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_smallRwd(blockCondi);
        LC_largeRwd(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_largeRwd(blockCondi);
        LC_DC(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_DC(blockCondi);
        LC_BC(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_BC(blockCondi);
    end
end

%% =================== PLOT PART                        ===================

%% Performance Plots
% Performance par conditions
figure('Name', 'RSVP Performance Plots');
subplot(2,3,1)
hold on;
bar([perf_DC 0 0],'FaceColor',[0.55 0.25 0.35]);
bar([0 perf_CC 0],'FaceColor',[0.75 0.75 0.75]);
bar([0 0 perf_BC],'FaceColor',[0.40 0.55 0.40]);
errorbar(1, perf_DC, perf_DC_sem, 'k.','LineWidth',1);
errorbar(2, perf_CC, perf_CC_sem, 'k.','LineWidth',1);
errorbar(3, perf_BC, perf_BC_sem, 'k.','LineWidth',1);
xticks([1 2 3 4])
xticklabels({'DC','CC', 'BC'})
ylabel('Performance','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 4 50 100])
grid minor
box on
hold off

% Performance par rewards
subplot(2,3,2)
hold on;
bar([smallRwd_rate 0],'FaceColor',[0.75, 0.85, 0.90]);
bar([0 largeRwd_rate],'FaceColor',[0.35, 0.50, 0.60]);
errorbar(1, smallRwd_rate, smallRwd_rate_sem, 'k.','LineWidth',1)
errorbar(2, largeRwd_rate, largeRwd_rate_sem, 'k.','LineWidth',1);
xticks([1 2])
xticklabels({'Small Rwd','Large Rwd'})
ylabel('Performance','fontsize', 10)
title('Performance According to Reward Size','fontsize', 10)
axis([0 3 50 100])
grid minor
box on
hold off

% Performance par lag
subplot(2,3,3)
hold on;
bar([perf_lag2 0],'FaceColor',[.9, .8, .9]);
bar([0 perf_lag4],'FaceColor',[.9, .7, .7]);
errorbar(1, perf_lag2, perf_lag2_sem, 'k.','LineWidth',1)
errorbar(2, perf_lag4, perf_lag4_sem, 'k.','LineWidth',1);
xticks([1 2])
xticklabels({'Lag 2','Lag 4'})
ylabel('Performance','fontsize', 10)
title('Performance According to Lag Size','fontsize', 10)
axis([0 3 50 100])
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,2,3)
hold on;
bar([perf_DC_smallRwd 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
bar([0 perf_DC_largeRwd 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
bar([0 0 perf_CC_smallRwd 0 0 0],'FaceColor',[0.85 0.85 0.85]);
bar([0 0 0 perf_CC_largeRwd 0 0],'FaceColor',[0.65 0.65 0.65]);
bar([0 0 0 0 perf_BC_smallRwd 0],'FaceColor',[0.50 0.65 0.50]);
bar([0 0 0 0 0 perf_BC_largeRwd],'FaceColor',[0.30 0.45 0.30]);
errorbar(1, perf_DC_smallRwd, perf_DC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(2, perf_DC_largeRwd, perf_DC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(3, perf_CC_smallRwd, perf_CC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(4, perf_CC_largeRwd, perf_CC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(5, perf_BC_smallRwd, perf_BC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(6, perf_BC_largeRwd, perf_BC_largeRwd_sem, 'k.','LineWidth',1)
xticks([1 2 3 4 5 6])
xticklabels({'DC SR','DC LR','CC SR','CC LR','BC SR',' BC LR'})
ylabel('Performance','fontsize', 10)
title('Performance According to Rewards and Conditions','fontsize', 10)
axis([0 7 50 100])
grid minor
box on
hold off

subplot(2,2,4)
hold on;
p2 = plot(1:3,[perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], 'linewidth',2.3);
p2.Color = [.35, .5, .6];
p1 = plot(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], 'linewidth',2.3);
p1.Color = [.75, .85, .9];
shadedErrorBar(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem],'lineprops',{'Color',[.75, .85, .9]},'patchSaturation',.2);
e1 = errorbar(1:3,[perf_DC_smallRwd, perf_CC_smallRwd,perf_BC_smallRwd], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem], 'k.','LineWidth',.9);
e1.Color = [.75, .85, .9];
shadedErrorBar(1:3, [perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem],'lineprops',{'Color',[.35, .5, .6]},'patchSaturation',.2);
e2 = errorbar(1:3,[perf_DC_largeRwd, perf_CC_largeRwd,perf_BC_largeRwd], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem], 'k.','LineWidth',.9);
e2.Color = [.35, .5, .6];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.5)
xticks([1 2 3])
legend({'Large Rwd','Small Rwd'})
xticklabels({'DC','CC','BC '})
ylabel('Performance','fontsize', 10)
title('Performance According to Reward and Conditions','fontsize', 10)
axis([0 4 80 100])
grid minor
box on
hold off

%% RTs Plots
figure('Name', 'RSVP RTs Plots');
[h_RT, p_RT] = adtest(rt);
subplot(2,3,1)
histogram(rt,'FaceColor',[.5, .5, .5], 'EdgeColor', [.5 .5 .5])
xlabel('log(RTs)','fontsize', 10)
ylabel('Number of Trials','fontsize', 10)
title('Distribution of RSVP Reaction Times','fontsize', 12)
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
ylabel('log(RTs)','fontsize', 10)
title('RTs According to Conditions','fontsize', 10)
axis([0 4 -.8 .8])
grid minor
box on
hold off

% RTs par rewards
subplot(2,3,3)
hold on;
bar([nanmean(rt_smallRwd) 0],'FaceColor',[0.75, 0.85, 0.90]);
bar([0 nanmean(rt_largeRwd)],'FaceColor',[0.35, 0.50, 0.60]);
errorbar(1, nanmean(rt_smallRwd), nanstd(rt_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_largeRwd), nanstd(rt_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
xticks([1 2])
xticklabels({'Small Rwd','Large Rwd'})
ylabel('log(RTs)','fontsize', 10)
title('RTs According to Reward Size','fontsize', 10)
axis([0 3 -.8 .8])
grid minor
box on
hold off

% RTs par conditions & rewards
subplot(2,2,3)
hold on;
bar([nanmean(rt_DC_smallRwd) 0 0 0 0 0],'FaceColor',[0.65 0.35 0.45]);
bar([0 nanmean(rt_DC_largeRwd) 0 0 0 0],'FaceColor',[0.45 0.15 0.25]);
bar([0 0 nanmean(rt_CC_smallRwd) 0 0 0],'FaceColor',[0.85 0.85 0.85]);
bar([0 0 0 nanmean(rt_CC_largeRwd) 0 0],'FaceColor',[0.65 0.65 0.65]);
bar([0 0 0 0 nanmean(rt_BC_smallRwd) 0],'FaceColor',[0.50 0.65 0.50]);
bar([0 0 0 0 0 nanmean(rt_BC_largeRwd)],'FaceColor',[0.30 0.45 0.30]);
errorbar(1, nanmean(rt_DC_smallRwd), nanstd(rt_DC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_DC_largeRwd), nanstd(rt_DC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3, nanmean(rt_CC_smallRwd), nanstd(rt_CC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(4, nanmean(rt_CC_largeRwd), nanstd(rt_CC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(5, nanmean(rt_BC_smallRwd), nanstd(rt_BC_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(6, nanmean(rt_BC_largeRwd), nanstd(rt_BC_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
xticks([1 2 3 4 5 6])
xticklabels({'DC SR','DC LR','CC SR','CC LR','BC SR',' BC LR'})
ylabel('log(RTs)','fontsize', 10)
title('RTs According to Rewards and Conditions','fontsize', 10)
axis([0 7 -.8 .8])
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
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.5)
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
ylabel('log(RTs)','fontsize', 10)
title('RTs for Correct and Incorrect Trials in Function of Conditions','fontsize', 10)
legend({'Correct','Incorrect'})
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
ylabel('Performance','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:(length(LC)))
xticklabels(1:12)
title('Learning Curve RSVP Experiment','fontsize', 10)
axis([0 (length(LC)+1) 50 100])
grid minor
box on

subplot(2,2,3)
hold on
p2 = plot(1:6, mean(LC_largeRwd),'-o','linew',1.5);
p2.Color = [.35, .5, .6];
p1 = plot(1:6, mean(LC_smallRwd),'-x','linew',1.5);
p1.Color = [.75, .85, .9];
shadedErrorBar(1:6,mean(LC_largeRwd),(std(LC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.35, .5, .6]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(LC_smallRwd),(std(LC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.75, .85, .9]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
legend({'Large Rwd','Small Rwd'})
ylabel('Performance','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('Learning Curve for Small and Large Rewards','fontsize', 10)
axis([0 7 50 100])
hold off
grid minor
box on

subplot(2,2,4)
hold on
p1 = plot(1:6, mean(LC_DC),'-x','linew',1.5);
p1.Color = [0.75 0.45 0.55];
p2 = plot(1:6, mean(LC_BC),'-o','linew',1.5);
p2.Color = [0.40 0.55 0.40];
shadedErrorBar(1:6,mean(LC_DC),(std(LC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.3);
shadedErrorBar(1:6,mean(LC_BC),(std(LC_BC)/sqrt(nS)),'lineprops',{'Color',[.4 .55 .4]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
legend({'DC','BC'})
ylabel('Performance','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:6); xticklabels(1:6)
title('Learning Curve for Detrimental and Beneficial Condition','fontsize', 10)
axis([0 7 50 100])
hold off
grid minor
box on

