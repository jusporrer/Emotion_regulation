% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars; 
close all; 

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 81477, 98197, 12346, 12346, 90255, 33222, 90255, 48680];

for subj_idx = 1:length(subject_ID) 
    disp(subject_ID(subj_idx))
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP(subject_ID(subj_idx), false); 
end

%% =================== General Information              ===================

disp(['Number of subjects: ',num2str(subj_idx)]);

nExcTrial       = mean([rsvpGRP.nExcTrial]);
nExcTrial_std   = std([rsvpGRP.nExcTrial]);

disp(['Number of excluded trials : ',num2str(nExcTrial)]);

%% =================== Performance General              ===================
disp('Performance information');
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
    num2str(round(reject_rate)), '% reject rate ', ...
    num2str(round(miss_rate)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate)), '% false alarm ']) ;

perf_lag2       = mean([rsvpGRP.lag2_rate]);
perf_lag2_std   = std([rsvpGRP.lag2_rate]);

perf_lag4       = mean([rsvpGRP.lag4_rate]);
perf_lag4_std   = std([rsvpGRP.lag4_rate]);

disp(['Lag : ', ...
    num2str(round(perf_lag2)), '% for lag 2 & ', ...
    num2str(round(perf_lag4)), '% for lag 4. ']) ;

%% =================== Performance per Rwd              ===================
smallRwd_rate       = mean([rsvpGRP.smallRwd_rate]);
smallRwd_rate_std   = std([rsvpGRP.smallRwd_rate]);

largeRwd_rate       = mean([rsvpGRP.largeRwd_rate]);
largeRwd_rate_std   = std([rsvpGRP.largeRwd_rate]);

disp(['Reward : ',num2str(round(smallRwd_rate)), '% were correct for small rwd & ', ...
    num2str(round(largeRwd_rate)), '% were correct for large rwd' ]);

%% =================== Performance per gender        ===================
perf_fem            = mean([rsvpGRP.perf_fem]);
perf_fem_std        = std([rsvpGRP.perf_fem]);

perf_hom            = mean([rsvpGRP.perf_hom]);
perf_hom_std        = std([rsvpGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

%% =================== Performance per condition        ===================

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

%% =================== RTs                              ===================


