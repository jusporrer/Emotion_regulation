% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars; 
close all; 

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 81477, 98197, 12346, 12346, 90255, 33222, 90255, 48680];

for subj_idx = 1:length(subject_ID) 
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP(subject_ID(subj_idx), false); 
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

nS              = length(subject_ID); 
disp(['Number of subjects: ',num2str(nS)]);

nExcTrial       = [rsvpGRP.nExcTrial];

disp(['Number of excluded trials : ',num2str(mean(nExcTrial))]);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf            = mean([rsvpGRP.performance]);
perf_min        = min([rsvpGRP.performance]);
perf_max        = max([rsvpGRP.performance]);
perf_std        = std([rsvpGRP.performance]);

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
perf_lag2_std   = std([rsvpGRP.lag2_rate]);

perf_lag4       = mean([rsvpGRP.lag4_rate]);
perf_lag4_std   = std([rsvpGRP.lag4_rate]);

disp(['Lag : ', ...
    num2str(round(perf_lag2)), '% for lag 2 & ', ...
    num2str(round(perf_lag4)), '% for lag 4 ']) ;

%% =================== Performance - Rewards            ===================
smallRwd_rate       = mean([rsvpGRP.smallRwd_rate]);
smallRwd_rate_std   = std([rsvpGRP.smallRwd_rate]);

largeRwd_rate       = mean([rsvpGRP.largeRwd_rate]);
largeRwd_rate_std   = std([rsvpGRP.largeRwd_rate]);

disp(['Reward : ',num2str(round(smallRwd_rate)), '% for small rwd & ', ...
    num2str(round(largeRwd_rate)), '% for large rwd' ]);

%% =================== Performance - Genders            ===================

perf_fem            = mean([rsvpGRP.perf_fem]);
perf_fem_std        = std([rsvpGRP.perf_fem]);

perf_hom            = mean([rsvpGRP.perf_hom]);
perf_hom_std        = std([rsvpGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

%% =================== Performance - Condition          ===================

perf_DC         = mean([rsvpGRP.perf_DC]);
perf_DC_std     = std([rsvpGRP.perf_DC]);

perf_CC         = mean([rsvpGRP.perf_CC]);
perf_CC_std     = std([rsvpGRP.perf_CC]);

perf_BC         = mean([rsvpGRP.perf_BC]);
perf_BC_std     = std([rsvpGRP.perf_BC]);

disp(['Emotion : ',num2str(round(perf_DC)), '% for DC, ', ...
    num2str(round(perf_CC)), '% for CC & ',...
    num2str(ceil(perf_BC)), '% for BC']);

perf_DC_smallRwd        = mean([rsvpGRP.perf_DC_smallRwd]);
perf_DC_smallRwd_std    = std([rsvpGRP.perf_DC_smallRwd]);

perf_DC_largeRwd        = mean([rsvpGRP.perf_DC_largeRwd]);
perf_DC_largeRwd_std    = std([rsvpGRP.perf_DC_largeRwd]);

perf_CC_smallRwd        = mean([rsvpGRP.perf_CC_smallRwd]);
perf_CC_smallRwd_std    = std([rsvpGRP.perf_CC_smallRwd]);

perf_CC_largeRwd        = mean([rsvpGRP.perf_CC_largeRwd]);
perf_CC_largeRwd_std    = std([rsvpGRP.perf_CC_largeRwd]);

perf_BC_smallRwd        = mean([rsvpGRP.perf_BC_smallRwd]);
perf_BC_smallRwd_std    = std([rsvpGRP.perf_BC_smallRwd]);

perf_BC_largeRwd        = mean([rsvpGRP.perf_BC_largeRwd]);
perf_BC_largeRwd_std    = std([rsvpGRP.perf_BC_largeRwd]);

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

rt_largeRwd             = [rsvpGRP.rt_largeRwd];
rt_largeRwd_correct     = [rsvpGRP.rt_largeRwd_correct];
rt_largeRwd_incorrect   = [rsvpGRP.rt_largeRwd_incorrect];

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
rt_fem_std              =  std([rsvpGRP.rt_fem]);

rt_hom                  =  mean([rsvpGRP.rt_hom]);
rt_hom_std              =  std([rsvpGRP.rt_hom]);

disp(['Genders: ',num2str(rt_fem), ' s for condition femme & ', ...
    num2str(rt_hom), ' s for condition homme ']);

%% =================== RTs - Conditions                 ===================

rt_DC                   = [rsvpGRP.rt_DC];
rt_DC_correct           = [rsvpGRP.rt_DC_correct];
rt_DC_incorrect         = [rsvpGRP.rt_DC_incorrect];

rt_CC                   = [rsvpGRP.rt_CC];
rt_CC_correct           = [rsvpGRP.rt_CC_correct];
rt_CC_incorrect         = [rsvpGRP.rt_CC_incorrect];

rt_BC                   = [rsvpGRP.rt_BC];
rt_BC_correct           = [rsvpGRP.rt_BC_correct];
rt_BC_incorrect         = [rsvpGRP.rt_BC_incorrect];

disp(['DC : ',...
    num2str(nanmean(rt_DC)), ' s (', ...
    num2str(nanmean(rt_DC_correct)), ' s for correct & ', ...
    num2str(nanmean(rt_DC_incorrect)), ' s for incorrect)']);

disp(['CC : ', ...
    num2str(nanmean(rt_CC)), ' s (', ...
    num2str(nanmean(rt_CC_correct)), ' s for correct & ', ...
    num2str(nanmean(rt_CC_incorrect)), ' s for incorrect)']);

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

    %% Learning Curves Plots
    figure('Name', 'Learning Curve Plots');

    subplot(2,1,1)
    p = plot(1:length(LC), mean(LC),'linew',1.5);
    p.Color = [0 0 0];
    shadedErrorBar(1:length(LC),mean(LC),(std(LC)/sqrt(nS)),'lineprops',{'Color',[0 0 0]},'patchSaturation',.3);
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:(length(LC)))
    xticklabels(1:12)
    title('Learning Curve Experiment','fontsize', 10)
    axis([0 (length(LC)+1) 40 105])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p1 = plot(1:6, mean(LC_smallRwd),'-x','linew',1.5);
    p1.Color = [.75, .85, .9];
    p2 = plot(1:6, mean(LC_largeRwd),'-o','linew',1.5);
    p2.Color = [.35, .5, .6];
    shadedErrorBar(1:6,mean(LC_smallRwd),(std(LC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.75, .85, .9]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(LC_largeRwd),(std(LC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.35, .5, .6]},'patchSaturation',.3);
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    legend({'Small Reward','Large Reward'})
    ylabel('Performance','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('Learning Curve for Small and Large Rewards','fontsize', 10)
    axis([0 7 40 110])
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
    line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    legend({'DC','BC'})
    ylabel('Performance','fontsize', 10)
    xlabel('Number of blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('Learning Curve for Detrimental Condition and Beneficial Condition','fontsize', 10)
    axis([0 7 40 110])
    hold off
    grid minor
    box on

