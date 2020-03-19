% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 81477, 12346, 90255, 33222, 90255, 48680];

for subj_idx = 1:length(subject_ID) 
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    memGRP(subj_idx) = Individual_Analysis_Memory(subject_ID(subj_idx), false); 
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

rt              = [memGRP.rt];

nS              = length(subject_ID);
disp(['Number of subjects: ',num2str(nS)]);

nExcTrial       = [memGRP.nExcTrial];

disp(['Number of excluded trials : ',num2str(mean(nExcTrial))]);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf                = mean([memGRP.performance]);
perf_min            = min([memGRP.performance]);
perf_max            = max([memGRP.performance]);
perf_sem            = std([memGRP.performance])/sqrt(nS);

disp(['Mean : ', ...
    num2str(round(perf)), '% correct (min perf : ', ...
    num2str(round(perf_min)), '% & max perf : ', ...
    num2str(round(perf_max)), '%) ']) ;

perf_imgShort       = mean([memGRP.imgShort_rate]);
perf_imgShort_sem   = std([memGRP.imgShort_rate])/sqrt(nS);

perf_imgLong        = mean([memGRP.imgLong_rate]);
perf_imgLong_sem    = std([memGRP.imgLong_rate])/sqrt(nS);

disp(['Image Presentation Duration : ', ...
    num2str(round(perf_imgShort)), '% for 1.5 s & ', ...
    num2str(round(perf_imgLong)), '% for 2 s ']) ;

%% =================== Performance - Rewards            ===================
smallRwd_rate       = mean([memGRP.smallRwd_rate]);
smallRwd_rate_sem   = std([memGRP.smallRwd_rate])/sqrt(nS);

largeRwd_rate       = mean([memGRP.largeRwd_rate]);
largeRwd_rate_sem   = std([memGRP.largeRwd_rate])/sqrt(nS);

disp(['Reward : ',num2str(round(smallRwd_rate)), '% for small rwd & ', ...
    num2str(round(largeRwd_rate)), '% for large rwd' ]);

%% =================== Performance - Genders            ===================

perf_fem            = mean([memGRP.perf_fem]);
perf_fem_sem        = std([memGRP.perf_fem]);

perf_hom            = mean([memGRP.perf_hom]);
perf_hom_sem        = std([memGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

%% =================== Performance - Condition          ===================

perf_DC         = mean([memGRP.perf_DC]);
perf_DC_sem     = std([memGRP.perf_DC])/sqrt(nS);

perf_CC         = mean([memGRP.perf_CC]);
perf_CC_sem     = std([memGRP.perf_CC])/sqrt(nS);

perf_BC         = mean([memGRP.perf_BC]);
perf_BC_sem     = std([memGRP.perf_BC])/sqrt(nS);

disp(['Emotion : ',num2str(round(perf_DC)), '% for DC, ', ...
    num2str(round(perf_CC)), '% for CC & ',...
    num2str(ceil(perf_BC)), '% for BC']);

perf_DC_smallRwd        = mean([memGRP.perf_DC_smallRwd]);
perf_DC_smallRwd_sem    = std([memGRP.perf_DC_smallRwd])/sqrt(nS);

perf_DC_largeRwd        = mean([memGRP.perf_DC_largeRwd]);
perf_DC_largeRwd_sem    = std([memGRP.perf_DC_largeRwd])/sqrt(nS);

perf_CC_smallRwd        = mean([memGRP.perf_CC_smallRwd]);
perf_CC_smallRwd_sem    = std([memGRP.perf_CC_smallRwd])/sqrt(nS);

perf_CC_largeRwd        = mean([memGRP.perf_CC_largeRwd]);
perf_CC_largeRwd_sem    = std([memGRP.perf_CC_largeRwd])/sqrt(nS);

perf_BC_smallRwd        = mean([memGRP.perf_BC_smallRwd]);
perf_BC_smallRwd_sem    = std([memGRP.perf_BC_smallRwd])/sqrt(nS);

perf_BC_largeRwd        = mean([memGRP.perf_BC_largeRwd]);
perf_BC_largeRwd_sem    = std([memGRP.perf_BC_largeRwd])/sqrt(nS);

%% =================== RTs - General                    ===================

disp('=================== RTs information ===================');

rt_correct              = ([memGRP.rt_correct]);

rt_incorrect            = ([memGRP.rt_incorrect]);

disp(['Correct : ',num2str(nanmean(rt_correct)), ' s ']);

disp(['Incorrect : ',num2str(nanmean(rt_incorrect)), ' s ']);

%% =================== RTs - Rewards                    ===================

rt_smallRwd             = [memGRP.rt_smallRwd];
rt_smallRwd_correct     = [memGRP.rt_smallRwd_correct];
rt_smallRwd_incorrect   = [memGRP.rt_smallRwd_incorrect];

rt_largeRwd             = [memGRP.rt_largeRwd];
rt_largeRwd_correct     = [memGRP.rt_largeRwd_correct];
rt_largeRwd_incorrect   = [memGRP.rt_largeRwd_incorrect];

disp(['Small reward : ',...
    num2str(mean(rt_smallRwd)), ' s (', ...
    num2str(mean(rt_smallRwd_correct)), ' s for correct & ', ...
    num2str(mean(rt_smallRwd_incorrect)), ' s for incorrect)']);

disp(['Large reward : ', ...
    num2str(mean(rt_largeRwd)), ' s (', ...
    num2str(mean(rt_largeRwd_correct)), ' s for correct & ', ...
    num2str(mean(rt_largeRwd_incorrect)), ' s for incorrect)']);

%% =================== RTs - Genders                    ===================

rt_fem                  =  mean([memGRP.rt_fem]);
rt_fem_sem              =  std([memGRP.rt_fem])/sqrt(nS);

rt_hom                  =  mean([memGRP.rt_hom]);
rt_hom_sem              =  std([memGRP.rt_hom])/sqrt(nS);

disp(['Genders: ',num2str(rt_fem), ' s for condition femme & ', ...
    num2str(rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions                 ===================

rt_DC                   = [memGRP.rt_DC];
rt_DC_correct           = [memGRP.rt_DC_correct];
rt_DC_incorrect         = [memGRP.rt_DC_incorrect];

rt_CC                   = [memGRP.rt_CC];
rt_CC_correct           = [memGRP.rt_CC_correct];
rt_CC_incorrect         = [memGRP.rt_CC_incorrect];

rt_BC                   = [memGRP.rt_BC];
rt_BC_correct           = [memGRP.rt_BC_correct];
rt_BC_incorrect         = [memGRP.rt_BC_incorrect];

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

rt_DC_smallRwd          = [memGRP.rt_DC_smallRwd];

rt_DC_largeRwd          = [memGRP.rt_DC_largeRwd];

rt_CC_smallRwd          = [memGRP.rt_CC_smallRwd];

rt_CC_largeRwd          = [memGRP.rt_CC_largeRwd];

rt_BC_smallRwd          = [memGRP.rt_BC_smallRwd];

rt_BC_largeRwd          = [memGRP.rt_BC_largeRwd];

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
        LC(subj_idx,block)                = memGRP(subj_idx).LC(block);
    end
    
    for blockCondi = 1:6
        LC_smallRwd(subj_idx,blockCondi)  = memGRP(subj_idx).LC_smallRwd(blockCondi);
        LC_largeRwd(subj_idx,blockCondi)  = memGRP(subj_idx).LC_largeRwd(blockCondi);
        LC_DC(subj_idx,blockCondi)        = memGRP(subj_idx).LC_DC(blockCondi);
        LC_BC(subj_idx,blockCondi)        = memGRP(subj_idx).LC_BC(blockCondi);
    end
end

%% =================== PLOT PART                        ===================

%% Performance Plots
% Performance par conditions
figure('Name', 'Memory Task Performance Plots');
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

% Performance par img presentation
subplot(2,3,3)
hold on;
bar([perf_imgShort 0],'FaceColor',[.9, .8, .9]);
bar([0 perf_imgLong],'FaceColor',[.9, .7, .7]);
errorbar(1, perf_imgShort, perf_imgShort_sem, 'k.','LineWidth',1)
errorbar(2, perf_imgLong, perf_imgLong_sem, 'k.','LineWidth',1);
xticks([1 2])
xticklabels({'1.5 s ','2 s'})
ylabel('Performance','fontsize', 10)
title('Performance According to Image Presentation Duration','fontsize', 10)
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
axis([0 4 50 100])
grid minor
box on
hold off

%% RTs Plots
figure('Name', 'Memory Task RTs Plots');
[h_RT, p_RT] = adtest(rt);
subplot(2,3,1)
histogram(rt,'FaceColor',[.5, .5, .5], 'EdgeColor', [.5 .5 .5])
xlabel('log(RTs)','fontsize', 10)
ylabel('Number of Trials','fontsize', 10)
title('Distribution of Reaction Times','fontsize', 12)
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
axis([0 4 -1 1])
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
axis([0 3 -1 1])
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
axis([0 7 -1 1])
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
axis([0 4 -1 1])
grid minor
box on
hold off


%% Learning Curves Plots
figure('Name', 'Memory Task Learning Curve Plots');

subplot(2,1,1)
p = plot(1:length(LC), smooth(mean(LC),'sgolay'),'linew',1.5);
p.Color = [0 0 0];
shadedErrorBar(1:length(LC),smooth(mean(LC),'sgolay'),(std(LC)/sqrt(nS)),'lineprops',{'Color',[0 0 0]},'patchSaturation',.3);
%line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
ylabel('Performance','fontsize', 10)
xlabel('Number of Blocks','fontsize', 10)
xticks(1:(length(LC)))
xticklabels(1:12)
title('Learning Curve Memory Experiment','fontsize', 10)
axis([0 (length(LC)+1) 50 100])
grid minor
box on

subplot(2,2,3)
hold on
p2 = plot(1:6, smooth(mean(LC_largeRwd),'sgolay'),'-o','linew',1.5);
p2.Color = [.35, .5, .6];
p1 = plot(1:6, smooth(mean(LC_smallRwd),'sgolay'),'-x','linew',1.5);
p1.Color = [.75, .85, .9];
shadedErrorBar(1:6,smooth(mean(LC_largeRwd),'sgolay'),(std(LC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.35, .5, .6]},'patchSaturation',.3);
shadedErrorBar(1:6,smooth(mean(LC_smallRwd),'sgolay'),(std(LC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.75, .85, .9]},'patchSaturation',.3);
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
p1 = plot(1:6, smooth(mean(LC_DC),'sgolay'),'-x','linew',1.5); 
p1.Color = [0.75 0.45 0.55];
p2 = plot(1:6, smooth(mean(LC_BC),'sgolay'),'-o','linew',1.5);
p2.Color = [0.40 0.55 0.40];
shadedErrorBar(1:6,smooth(mean(LC_DC),'sgolay'),(std(LC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.3);
shadedErrorBar(1:6,smooth(mean(LC_BC),'sgolay'),(std(LC_BC)/sqrt(nS)),'lineprops',{'Color',[.4 .55 .4]},'patchSaturation',.3);
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

