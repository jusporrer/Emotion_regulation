% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81433, 79662, 90580] %[98197, 81477, 90255, 90266]; % [81473, 74239, 98197, 12346, 81477, 90255, 90266, 33222, 48680];  %  [81433, 79662, 90580];

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP(subject_ID(subj_idx), false);
end

%% =================== General Information              ===================
disp('=================== General Group Information ===================');

rt                      = [rsvpGRP.rt];
%[h_RT, p_RT]            = adtest(rt); % Normality Anderson-Darling test

nS                      = length(subject_ID);
disp(['Number of subjects: ',num2str(nS)]);

nExcTrial               = mean([rsvpGRP.nExcTrial]);
nExcTrial_sem           = std([rsvpGRP.nExcTrial])/sqrt(nS);

disp(['Number of excluded trials : ',num2str(nExcTrial)]);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf                    = [rsvpGRP.performance];
%[h_perf, p_perf]        = adtest(perf); % Normality Anderson-Darling test
perf_min                = min([rsvpGRP.performance]);
perf_max                = max([rsvpGRP.performance]);
perf_sem                = std([rsvpGRP.performance])/sqrt(nS);

disp(['Mean : ', ...
    num2str(round(mean(perf))), '% correct (min perf : ', ...
    num2str(round(perf_min)), '% & max perf : ', ...
    num2str(round(perf_max)), '%) ']) ;

hit_rate                = mean([rsvpGRP.hit_rate])*100;
reject_rate             = mean([rsvpGRP.reject_rate])*100;
miss_rate               = mean([rsvpGRP.miss_rate])*100;
falseAlarm_rate         = mean([rsvpGRP.falseAlarm_rate])*100;

disp(['Sdt : ', ...
    num2str(round(hit_rate)), '% hit rate, ', ...
    num2str(round(reject_rate)), '% reject rate, ', ...
    num2str(round(miss_rate)), '% miss rate & ', ...
    num2str(round(falseAlarm_rate)), '% false alarm ']) ;

[h_correct_std, p_correct_std, ci_correct_std, stats_correct_std]           = ttest2([rsvpGRP.hit_rate], [rsvpGRP.reject_rate]);
[h_incorrect_std, p_incorrect_std, ci_incorrect_std, stats_incorrect_std]   = ttest2([rsvpGRP.miss_rate], [rsvpGRP.falseAlarm_rate]);

% Lag

perf_lag2               = [rsvpGRP.lag2_rate];
perf_lag2_sem           = std([rsvpGRP.lag2_rate])/sqrt(nS);

perf_lag4               = [rsvpGRP.lag4_rate];
perf_lag4_sem           = std([rsvpGRP.lag4_rate])/sqrt(nS);

[h_lag,p_lag, ci_lag]   = ttest2(perf_lag2, perf_lag4);

disp(['Lag : ', ...
    num2str(round(mean(perf_lag2))), '% for lag 2 & ', ...
    num2str(round(mean(perf_lag4))), '% for lag 4 ']) ;

%% =================== Performance - Rewards            ===================
perf_smallRwd           = [rsvpGRP.smallRwd_rate];
perf_smallRwd_sem       = std([rsvpGRP.smallRwd_rate])/sqrt(nS);

perf_largeRwd           = [rsvpGRP.largeRwd_rate];
perf_largeRwd_sem       = std([rsvpGRP.largeRwd_rate])/sqrt(nS);

disp(['Reward : ',num2str(round(mean(perf_smallRwd))), '% for small rwd & ', ...
    num2str(round(mean(perf_largeRwd))), '% for large rwd' ]);

[h_perf_rwd, p_perf_rwd, ci_perf_rwd, stats_perf_rwd] = ttest2(perf_smallRwd, perf_largeRwd);

%% =================== Performance - Genders            ===================

perf_fem                =[rsvpGRP.perf_fem];
perf_fem_sem            = std([rsvpGRP.perf_fem]);

perf_hom                = [rsvpGRP.perf_hom];
perf_hom_sem            = std([rsvpGRP.perf_hom]);

disp(['Gender: ',num2str(round(perf_fem)), '% for condition femme & ', ...
    num2str(round(perf_hom)), '% for condition homme ']);

[h_perf_gender, p_perf_gender, ci_perf_gender, stats_perf_gender] = ttest2(perf_fem, perf_hom);

%% =================== Performance - Conditions         ===================

perf_DC                 = [rsvpGRP.perf_DC];
perf_DC_sem             = std([rsvpGRP.perf_DC])/sqrt(nS);

hit_rate_DC             = ([rsvpGRP.hit_rate_DC ]);
reject_rate_DC          = ([rsvpGRP.reject_rate_DC ]);
miss_rate_DC            = ([rsvpGRP.miss_rate_DC ]);
falseAlarm_rate_DC      = ([rsvpGRP.falseAlarm_rate_DC ]);

perf_CC_DC              = [rsvpGRP.perf_CC_DC];
perf_CC_DC_sem          = std([rsvpGRP.perf_CC_DC])/sqrt(nS);

perf_CC                 = ([rsvpGRP.perf_CC]);
perf_CC_sem             = std([rsvpGRP.perf_CC])/sqrt(nS);

hit_rate_CC             = [rsvpGRP.hit_rate_CC ];
reject_rate_CC          = [rsvpGRP.reject_rate_CC ];
miss_rate_CC            = [rsvpGRP.miss_rate_CC ];
falseAlarm_rate_CC      = [rsvpGRP.falseAlarm_rate_CC ];

perf_CC_BC              = ([rsvpGRP.perf_CC_BC]);
perf_CC_BC_sem          = std([rsvpGRP.perf_CC_BC])/sqrt(nS);

perf_BC                 = ([rsvpGRP.perf_BC]);
perf_BC_sem             = std([rsvpGRP.perf_BC])/sqrt(nS);

hit_rate_BC             = ([rsvpGRP.hit_rate_BC ]);
reject_rate_BC          = ([rsvpGRP.reject_rate_BC ]);
miss_rate_BC            = ([rsvpGRP.miss_rate_BC ]);
falseAlarm_rate_BC      = ([rsvpGRP.falseAlarm_rate_BC ]);

disp(['Emotion : ',num2str(round(mean(perf_DC))), '% for DC, ', ...
    num2str(round(mean(perf_CC))), '% for CC & ',...
    num2str(round(mean(perf_BC))), '% for BC']);

perf_DC_smallRwd        = ([rsvpGRP.perf_DC_smallRwd]);
perf_DC_smallRwd_sem    = std([rsvpGRP.perf_DC_smallRwd])/sqrt(nS);

perf_DC_largeRwd        = ([rsvpGRP.perf_DC_largeRwd]);
perf_DC_largeRwd_sem    = std([rsvpGRP.perf_DC_largeRwd])/sqrt(nS);

[h_perf_DC_rwd, p_perf_DC_rwd, ci_perf_DC_rwd, stats_perf_DC_rwd]          = ttest2(perf_DC_smallRwd, perf_DC_largeRwd);

perf_CC_smallRwd        = ([rsvpGRP.perf_CC_smallRwd]);
perf_CC_smallRwd_sem    = std([rsvpGRP.perf_CC_smallRwd])/sqrt(nS);

perf_CC_largeRwd        = ([rsvpGRP.perf_CC_largeRwd]);
perf_CC_largeRwd_sem    = std([rsvpGRP.perf_CC_largeRwd])/sqrt(nS);

[h_perf_CC_rwd, p_perf_CC_rwd, ci_perf_CC_rwd, stats_perf_CC_rwd]          = ttest2(perf_CC_smallRwd, perf_CC_largeRwd);

perf_CC_DC_smallRwd     = ([rsvpGRP.perf_CC_DC_smallRwd]);
perf_CC_DC_smallRwd_sem = std([rsvpGRP.perf_CC_DC_smallRwd])/sqrt(nS);

perf_CC_DC_largeRwd     = ([rsvpGRP.perf_CC_DC_largeRwd]);
perf_CC_DC_largeRwd_sem = std([rsvpGRP.perf_CC_DC_largeRwd])/sqrt(nS);

[h_perf_CC_DC_rwd, p_perf_CC_DC_rwd, ci_perf_CC_DC_rwd, stats_perf_CC_DC_rwd] = ttest2(perf_CC_DC_smallRwd, perf_CC_DC_largeRwd);

perf_CC_BC_smallRwd     = ([rsvpGRP.perf_CC_BC_smallRwd]);
perf_CC_BC_smallRwd_sem = std([rsvpGRP.perf_CC_BC_smallRwd])/sqrt(nS);

perf_CC_BC_largeRwd     = ([rsvpGRP.perf_CC_BC_largeRwd]);
perf_CC_BC_largeRwd_sem = std([rsvpGRP.perf_CC_BC_largeRwd])/sqrt(nS);

[h_perf_CC_BC_rwd, p_perf_CC_BC_rwd, ci_perf_CC_BC_rwd, stats_perf_CC_BC_rwd] = ttest2(perf_CC_BC_smallRwd, perf_CC_BC_largeRwd);

perf_BC_smallRwd        = ([rsvpGRP.perf_BC_smallRwd]);
perf_BC_smallRwd_sem    = std([rsvpGRP.perf_BC_smallRwd])/sqrt(nS);

perf_BC_largeRwd        = ([rsvpGRP.perf_BC_largeRwd]);
perf_BC_largeRwd_sem    = std([rsvpGRP.perf_BC_largeRwd])/sqrt(nS);

[h_perf_BC_rwd, p_perf_BC_rwd, ci_perf_BC_rwd, stats_perf_BC_rwd]          = ttest2(perf_BC_smallRwd, perf_BC_largeRwd);

% T-test
[h_perf_DC_CC, p_perf_DC_CC, ci_perf_DC_CC, stats_perf_DC_CC]              = ttest2(perf_DC, perf_CC);
[h_perf_DC_BC, p_perf_DC_BC, ci_perf_DC_BC, stats_perf_DC_BC]              = ttest2(perf_DC, perf_BC);
[h_perf_CC_BC, p_perf_CC_BC, ci_perf_CC_BC, stats_perf_CC_BC]              = ttest2(perf_CC, perf_BC);
[h_perf_CC_both, p_perf_CC_both, ci_perf_CC_both, stats_perf_CC_both]      = ttest2(perf_CC_DC, perf_CC_BC);

[h_perf_DC_CC_smallRwd, p_perf_DC_CC_smallRwd, ci_perf_DC_CC_smallRwd, stats_perf_DC_CC_smallRwd] = ttest2(perf_DC_smallRwd, perf_CC_smallRwd);
[h_perf_DC_BC_smallRwd, p_perf_DC_BC_smallRwd, ci_perf_DC_BC_smallRwd, stats_perf_DC_BC_smallRwd] = ttest2(perf_DC_smallRwd, perf_BC_smallRwd);
[h_perf_CC_BC_smallRwd, p_perf_CC_BC_smallRwd, ci_perf_CC_BC_smallRwd, stats_perf_CC_BC_smallRwd] = ttest2(perf_CC_smallRwd, perf_BC_smallRwd);
[h_perf_CC_both_smallRwd, p_perf_CC_both_smallRwd, ci_perf_CC_both_smallRwd, stats_perf_CC_both_smallRwd] = ttest2(perf_CC_DC_smallRwd, perf_CC_BC_smallRwd);

[h_perf_DC_CC_largeRwd, p_perf_DC_CC_largeRwd, ci_perf_DC_CC_largeRwd, stats_perf_DC_CC_largeRwd] = ttest2(perf_DC_largeRwd, perf_CC_largeRwd);
[h_perf_DC_BC_largeRwd, p_perf_DC_BC_largeRwd, ci_perf_DC_BC_largeRwd, stats_perf_DC_BC_largeRwd] = ttest2(perf_DC_largeRwd, perf_BC_largeRwd);
[h_perf_CC_BC_largeRwd, p_perf_CC_BC_largeRwd, ci_perf_CC_BC_largeRwd, stats_perf_CC_BC_largeRwd] = ttest2(perf_CC_largeRwd, perf_BC_largeRwd);
[h_perf_CC_both_largeRwd, p_perf_CC_both_largeRwd, ci_perf_CC_both_largeRwd, stats_perf_CC_both_largeRwd] = ttest2(perf_CC_DC_smallRwd, perf_CC_BC_smallRwd);


%% =================== Performance - Gender & Rewards   ===================

% Female
perf_fem_smallRwd         = [rsvpGRP.perf_fem_smallRwd];
perf_fem_largeRwd         = [rsvpGRP.perf_fem_largeRwd];
[h_perf_fem_rwd, p_perf_fem_rwd, ci_perf_fem_rwd, stats_perf_fem_rwd] = ttest2(perf_fem_smallRwd, perf_fem_largeRwd);

perf_DC_fem                 = [rsvpGRP.DC_fem_rate];
perf_CC_fem                 = [rsvpGRP.CC_fem_rate];
perf_BC_fem                 = [rsvpGRP.BC_fem_rate];
[h_perf_DC_BC_fem, p_perf_DC_BC_fem, ci_perf_DC_BC_fem, stats_perf_DC_BC_fem] = ttest2(perf_DC_fem, perf_BC_fem);
[h_perf_DC_CC_fem, p_perf_DC_CC_fem, ci_perf_DC_CC_fem, stats_perf_DC_CC_fem] = ttest2(perf_DC_fem, perf_CC_fem);
[h_perf_CC_BC_fem, p_perf_CC_BC_fem, ci_perf_CC_BC_fem, stats_perf_CC_BC_fem] = ttest2(perf_CC_fem, perf_BC_fem);

perf_DC_fem_smallRwd = [rsvpGRP.perf_DC_fem_smallRwd];
perf_DC_fem_largeRwd = [rsvpGRP.perf_DC_fem_largeRwd];

perf_CC_fem_smallRwd = [rsvpGRP.perf_CC_fem_smallRwd];
perf_CC_fem_largeRwd = [rsvpGRP.perf_CC_fem_largeRwd];

perf_BC_fem_smallRwd = [rsvpGRP.perf_BC_fem_smallRwd];
perf_BC_fem_largeRwd = [rsvpGRP.perf_BC_fem_largeRwd];

% Male
perf_hom_smallRwd         = [rsvpGRP.perf_hom_smallRwd];
perf_hom_largeRwd         = [rsvpGRP.perf_hom_largeRwd];
[h_perf_hom_rwd, p_perf_hom_rwd, ci_perf_hom_rwd, stats_perf_hom_rwd] = ttest2(perf_hom_smallRwd, perf_hom_largeRwd);

perf_DC_hom                 = [rsvpGRP.DC_hom_rate];
perf_BC_hom                 = [rsvpGRP.BC_hom_rate];
perf_CC_hom                 = [rsvpGRP.CC_hom_rate];
[h_perf_DC_BC_hom, p_perf_DC_BC_hom, ci_perf_DC_BC_hom, stats_perf_DC_BC_hom] = ttest2(perf_DC_hom, perf_BC_hom);
[h_perf_DC_CC_hom, p_perf_DC_CC_hom, ci_perf_DC_CC_hom, stats_perf_DC_CC_hom] = ttest2(perf_DC_hom, perf_CC_hom);
[h_perf_CC_BC_hom, p_perf_CC_BC_hom, ci_perf_CC_BC_hom, stats_perf_CC_BC_hom] = ttest2(perf_CC_hom, perf_BC_hom);

perf_DC_hom_smallRwd = [rsvpGRP.perf_DC_hom_smallRwd];
perf_DC_hom_largeRwd = [rsvpGRP.perf_DC_hom_largeRwd];

perf_CC_hom_smallRwd = [rsvpGRP.perf_CC_hom_smallRwd];
perf_CC_hom_largeRwd = [rsvpGRP.perf_CC_hom_largeRwd];

perf_BC_hom_smallRwd = [rsvpGRP.perf_BC_hom_smallRwd];
perf_BC_hom_largeRwd = [rsvpGRP.perf_BC_hom_largeRwd];

% Between Gender
[h_perf_fem_hom_smallRwd, p_perf_fem_hom_smallRwd, ci_perf_fem_hom_smallRwd, stats_perf_fem_hom_smallRwd] = ttest2(perf_fem_smallRwd, perf_hom_smallRwd);
[h_perf_fem_hom_largeRwd, p_perf_fem_hom_largeRwd, ci_perf_fem_hom_largeRwd, stats_perf_fem_hom_largeRwd] = ttest2(perf_fem_largeRwd, perf_hom_largeRwd);

[h_perf_DC_gender, p_perf_DC_gender, ci_perf_DC_gender, stats_perf_DC_gender] = ttest2(perf_DC_hom, perf_DC_fem);
[h_perf_CC_gender, p_perf_CC_gender, ci_perf_CC_gender, stats_perf_CC_gender] = ttest2(perf_CC_hom, perf_CC_fem);
[h_perf_BC_gender, p_perf_BC_gender, ci_perf_BC_gender, stats_perf_BC_gender] = ttest2(perf_BC_hom, perf_BC_fem);

%% =================== Signal Detection Theory          ===================

dprime_smallRwd      = [rsvpGRP.dprime_smallRwd];
dprime_smallRwd_sem  = std(dprime_smallRwd)/sqrt(nS);
dprime_largeRwd      = [rsvpGRP.dprime_largeRwd];
dprime_largeRwd_sem  = std(dprime_largeRwd)/sqrt(nS);

[h_dprime_rwd, p_dprime_rwd, ci_dprime_rwd, stats_dprime_rwd]              = ttest2(dprime_smallRwd, dprime_largeRwd);

dprime                  = [rsvpGRP.dprime];
disp(['Dprime : ',num2str(mean(dprime))]);

dprime_DC               = [rsvpGRP.dprime_DC];
dprime_DC_sem           = std(dprime_DC)/sqrt(nS);
dprime_DC_smallRwd      = [rsvpGRP.dprime_DC_smallRwd];
dprime_DC_smallRwd_sem  = std(dprime_DC_smallRwd)/sqrt(nS);
dprime_DC_largeRwd      = [rsvpGRP.dprime_DC_largeRwd];
dprime_DC_largeRwd_sem  = std(dprime_DC_largeRwd)/sqrt(nS);

dprime_CC_DC            = [rsvpGRP.dprime_CC_DC];
dprime_CC_DC_sem        = std(dprime_CC_DC)/sqrt(nS);
dprime_CC_DC_smallRwd   = [rsvpGRP.dprime_DC_smallRwd];
dprime_CC_DC_smallRwd_sem  = std(dprime_CC_DC_smallRwd)/sqrt(nS);
dprime_CC_DC_largeRwd   = [rsvpGRP.dprime_CC_DC_largeRwd];
dprime_CC_DC_largeRwd_sem  = std(dprime_CC_DC_largeRwd)/sqrt(nS);

dprime_CC               = [rsvpGRP.dprime_CC];
dprime_CC_sem           = std(dprime_CC)/sqrt(nS);
dprime_CC_smallRwd      = [rsvpGRP.dprime_CC_smallRwd];
dprime_CC_smallRwd_sem  = std(dprime_CC_smallRwd)/sqrt(nS);
dprime_CC_largeRwd      = [rsvpGRP.dprime_CC_largeRwd];
dprime_CC_largeRwd_sem  = std(dprime_CC_largeRwd)/sqrt(nS);

dprime_CC_BC            = [rsvpGRP.dprime_CC_BC];
dprime_CC_BC_sem        = std(dprime_CC_BC)/sqrt(nS);
dprime_CC_BC_smallRwd   = [rsvpGRP.dprime_BC_smallRwd];
dprime_CC_BC_smallRwd_sem  = std(dprime_CC_BC_smallRwd)/sqrt(nS);
dprime_CC_BC_largeRwd   = [rsvpGRP.dprime_CC_BC_largeRwd];
dprime_CC_BC_largeRwd_sem  = std(dprime_CC_BC_largeRwd)/sqrt(nS);

dprime_BC               = [rsvpGRP.dprime_BC];
dprime_BC_sem           = std(dprime_BC)/sqrt(nS);
dprime_BC_smallRwd      = [rsvpGRP.dprime_BC_smallRwd];
dprime_BC_smallRwd_sem  = std(dprime_BC_smallRwd)/sqrt(nS);
dprime_BC_largeRwd      = [rsvpGRP.dprime_BC_largeRwd];
dprime_BC_largeRwd_sem  = std(dprime_BC_largeRwd)/sqrt(nS);

[h_dprime_DC_CC, p_dprime_DC_CC, ci_dprime_DC_CC, stats_dprime_DC_CC]      = ttest2(dprime_DC, dprime_CC);
[h_dprime_DC_BC, p_dprime_DC_BC, ci_dprime_DC_BC, stats_dprime_DC_BC]      = ttest2(dprime_DC, dprime_BC);
[h_dprime_CC_BC, p_dprime_CC_BC, ci_dprime_CC_BC, stats_dprime_CC_BC]      = ttest2(dprime_CC, dprime_BC);
[h_dprime_CC_both, p_dprime_CC_both, ci_dprime_CC_both, stats_dprime_CC_both] = ttest2(dprime_CC_DC, dprime_CC_BC);

[h_dprime_DC_rwd, p_dprime_DC_rwd, ci_dprime_DC_rwd, stats_dprime_DC_rwd]  = ttest2(dprime_DC_smallRwd, dprime_DC_largeRwd);
[h_dprime_CC_rwd, p_dprime_CC_rwd, ci_dprime_CC_rwd, stats_dprime_CC_rwd]  = ttest2(dprime_CC_smallRwd, dprime_CC_largeRwd);
[h_dprime_BC_rwd, p_dprime_BC_rwd, ci_dprime_BC_rwd, stats_dprime_BC_rwd]  = ttest2(dprime_BC_smallRwd, dprime_BC_largeRwd);

criterion               = [rsvpGRP.criterion];
disp(['Criterion : ',num2str(mean(criterion))]);

criterion_DC            = [rsvpGRP.criterion_DC];
criterion_DC_sem        = std(criterion_DC)/sqrt(nS);
criterion_CC_DC         = [rsvpGRP.criterion_CC_DC];
criterion_CC_DC_sem     = std(criterion_CC_DC)/sqrt(nS);
criterion_CC            = [rsvpGRP.criterion_CC];
criterion_CC_sem        = std(criterion_CC)/sqrt(nS);
criterion_CC_BC         = [rsvpGRP.criterion_CC_BC];
criterion_CC_BC_sem     = std(criterion_CC_BC)/sqrt(nS);
criterion_BC            = [rsvpGRP.criterion_BC];
criterion_BC_sem        = std(criterion_BC)/sqrt(nS);

[h_crit_DC_CC, p_crit_DC_CC, ci_crit_DC_CC, stats_crit_DC_CC]              = ttest2(criterion_DC, criterion_CC);
[h_crit_DC_BC, p_crit_DC_BC, ci_crit_DC_BC, stats_crit_DC_BC]              = ttest2(criterion_DC, criterion_BC);
[h_crit_CC_BC, p_crit_CC_BC, ci_crit_CC_BC, stats_crit_CC_BC]              = ttest2(criterion_CC, criterion_BC);
[h_crit_CC_both, p_crit_CC_both, ci_crit_CC_both, stats_crit_CC_both]      = ttest2(criterion_CC_DC, criterion_CC_BC);

aprime                  = [rsvpGRP.aprime];
bprime                  = [rsvpGRP.bprime];

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

[h_rt_correct, p_rt_correct, ci_rt_correct, stats_rt_correct]           = ttest2(rt_hit, rt_reject);
[h_rt_incorrect, p_rt_incorrect, ci_rt_incorrect, stats_rt_incorrect]   = ttest2(rt_miss, rt_falseAlarm);

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

% T-test
[h_rt_rwd, p_rt_rwd, ci_rt_rwd, stats_rwd] = ttest2(rt_smallRwd, rt_largeRwd);

[h_rt_smallRwd, p_rt_smallRwd, ci_rt_smallRwd, stats_smallRwd] = ttest2(rt_smallRwd_correct, rt_smallRwd_incorrect);
[h_rt_largeRwd, p_rt_largeRwd, ci_rt_largeRwd, stats_largeRwd] = ttest2(rt_largeRwd_correct, rt_largeRwd_incorrect);
[h_rt_correct_rwd, p_rt_correct_rwd, ci_rt_correct_rwd, stats_correct_rwd] = ttest2(rt_smallRwd_correct, rt_largeRwd_correct);
[h_rt_rwd_diff, p_rt_rwd_diff, ci_rt_rwd_diff, stats_rwd_diff] = ttest2(rt_smallRwd_diff, rt_largeRwd_diff);

%% =================== RTs - Genders                    ===================

rt_fem                  =  ([rsvpGRP.rt_fem]);
rt_fem_sem              =  std([rsvpGRP.rt_fem]);

rt_hom                  =  ([rsvpGRP.rt_hom]);
rt_hom_sem              =  std([rsvpGRP.rt_hom]);

disp(['Genders: ',num2str(mean(rt_fem)), ' s for condition femme & ', ...
    num2str(mean(rt_hom)), ' s for condition homme ']);

[h_rt_gender, p_rt_gender, ci_rt_gender, stats_gender] = ttest2(rt_fem, rt_hom);

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

% T-test
[h_rt_DC_CC, p_rt_DC_CC, ci_rt_DC_CC, stats_rt_DC_CC] = ttest2(rt_DC, rt_CC);
[h_rt_DC_BC, p_rt_DC_BC, ci_rt_DC_BC, stats_rt_DC_BC] = ttest2(rt_DC, rt_BC);
[h_rt_CC_BC, p_rt_CC_BC, ci_rt_CC_BC, stats_rt_CC_BC] = ttest2(rt_CC, rt_BC);

[h_rt_DC_correct, p_rt_DC_correct, ci_rt_DC_correct, stats_DC_correct] = ttest2(rt_DC_correct, rt_DC_incorrect);
[h_rt_CC_correct, p_rt_CC_correct, ci_rt_CC_correct, stats_CC_correct] = ttest2(rt_CC_correct, rt_CC_incorrect);
[h_rt_BC_correct, p_rt_BC_correct, ci_rt_BC_correct, stats_BC_correct] = ttest2(rt_BC_correct, rt_BC_incorrect);

[h_rt_DC_CC_diff, p_rt_DC_CC_diff, ci_rt_DC_CC_diff, stats_rt_DC_CC_diff] = ttest2(rt_DC_diff, rt_CC_diff);
[h_rt_DC_BC_diff, p_rt_DC_BC_diff, ci_rt_DC_BC_diff, stats_rt_DC_BC_diff] = ttest2(rt_DC_diff, rt_BC_diff);
[h_rt_CC_BC_diff, p_rt_CC_BC_diff, ci_rt_CC_BC_diff, stats_rt_CC_BC_diff] = ttest2(rt_CC_diff, rt_BC_diff);

%% =================== RTs - Conditions & Reward        ===================

rt_DC_smallRwd          = [rsvpGRP.rt_DC_smallRwd];
rt_DC_largeRwd          = [rsvpGRP.rt_DC_largeRwd];

[h_rt_DC_rwd, p_rt_DC_rwd, ci_rt_DC_rwd, stats_rt_DC_rwd] = ttest2(rt_DC_smallRwd, rt_DC_largeRwd);

rt_CC_smallRwd          = [rsvpGRP.rt_CC_smallRwd];
rt_CC_largeRwd          = [rsvpGRP.rt_CC_largeRwd];

[h_rt_CC_rwd, p_rt_CC_rwd, ci_rt_CC_rwd, stats_rt_CC_rwd] = ttest2(rt_CC_smallRwd, rt_CC_largeRwd);

rt_BC_smallRwd          = [rsvpGRP.rt_BC_smallRwd];
rt_BC_largeRwd          = [rsvpGRP.rt_BC_largeRwd];

[h_rt_BC_rwd, p_rt_BC_rwd, ci_rt_BC_rwd, stats_rt_BC_rwd] = ttest2(rt_BC_smallRwd, rt_BC_largeRwd);

disp(['Small Reward : ',...
    num2str(nanmean(rt_DC_smallRwd)), ' s for DC, ', ...
    num2str(nanmean(rt_CC_smallRwd)), ' s for CC & ', ...
    num2str(nanmean(rt_BC_smallRwd)), ' s for BC ']);

disp(['Large Reward : ',...
    num2str(nanmean(rt_DC_largeRwd)), ' s for DC, ', ...
    num2str(nanmean(rt_CC_largeRwd)), ' s for CC & ', ...
    num2str(nanmean(rt_BC_largeRwd)), ' s for BC ']);

[h_rt_DC_CC_smallRwd, p_rt_DC_CC_smallRwd, ci_rt_DC_CC_smallRwd, stats_rt_DC_CC_smallRwd] = ttest2(rt_DC_smallRwd, rt_CC_smallRwd);
[h_rt_DC_BC_smallRwd, p_rt_DC_BC_smallRwd, ci_rt_DC_BC_smallRwd, stats_rt_DC_BC_smallRwd] = ttest2(rt_DC_smallRwd, rt_BC_smallRwd);
[h_rt_CC_BC_smallRwd, p_rt_CC_BC_smallRwd, ci_rt_CC_BC_smallRwd, stats_rt_CC_BC_smallRwd] = ttest2(rt_CC_smallRwd, rt_BC_smallRwd);

[h_rt_DC_CC_largeRwd, p_rt_DC_CC_largeRwd, ci_rt_DC_CC_largeRwd, stats_rt_DC_CC_largeRwd] = ttest2(rt_DC_largeRwd, rt_CC_largeRwd);
[h_rt_DC_BC_largeRwd, p_rt_DC_BC_largeRwd, ci_rt_DC_BC_largeRwd, stats_rt_DC_BC_largeRwd] = ttest2(rt_DC_largeRwd, rt_BC_largeRwd);
[h_rt_CC_BC_largeRwd, p_rt_CC_BC_largeRwd, ci_rt_CC_BC_largeRwd, stats_rt_CC_BC_largeRwd] = ttest2(rt_CC_largeRwd, rt_BC_largeRwd);

%% =================== RTs - Gender & Rewards           ===================

rt_fem_smallRwd         = [rsvpGRP.rt_fem_smallRwd];
rt_fem_largeRwd         = [rsvpGRP.rt_fem_largeRwd];

[h_rt_fem_rwd, p_rt_fem_rwd, ci_rt_fem_rwd, stats_rt_fem_rwd] = ttest2(rt_fem_smallRwd, rt_fem_largeRwd);

rt_hom_smallRwd         = [rsvpGRP.rt_hom_smallRwd];
rt_hom_largeRwd         = [rsvpGRP.rt_hom_largeRwd];

[h_rt_hom_rwd, p_rt_hom_rwd, ci_rt_hom_rwd, stats_rt_hom_rwd] = ttest2(rt_hom_smallRwd, rt_hom_largeRwd);

[h_rt_fem_hom_smallRwd, p_rt_fem_hom_smallRwd, ci_rt_fem_hom_smallRwd, stats_rt_fem_hom_smallRwd] = ttest2(rt_fem_smallRwd, rt_hom_smallRwd);
[h_rt_fem_hom_largeRwd, p_rt_fem_hom_largeRwd, ci_rt_fem_hom_largeRwd, stats_rt_fem_hom_largeRwd] = ttest2(rt_fem_largeRwd, rt_hom_largeRwd);

%% =================== Learning & RTs Curves            ===================

LC                      = zeros(subj_idx,12); LC_CC                   = zeros(subj_idx,6);
LC_smallRwd             = zeros(subj_idx,6); LC_largeRwd             = zeros(subj_idx,6);
LC_DC                   = zeros(subj_idx,6); LC_BC                   = zeros(subj_idx,6);


RTsC                    = zeros(subj_idx,12); RTsC_CC                 = zeros(subj_idx,6);
RTsC_smallRwd           = zeros(subj_idx,6); RTsC_largeRwd           = zeros(subj_idx,6);
RTsC_DC                 = zeros(subj_idx,6); RTsC_BC                 = zeros(subj_idx,6);

rt_slow_perf            = [rsvpGRP.rt_slow_perf];
rt_fast_perf            = [rsvpGRP.rt_fast_perf];

[h_rt_perf, p_rt_perf, ci_rt_perf, stats_rt_perf] = ttest2(rt_slow_perf, rt_fast_perf);

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC(subj_idx,block)                = rsvpGRP(subj_idx).LC(block);
        %LC_CC(subj_idx,block)             = rsvpGRP(subj_idx).LC_CC(block);
        RTsC(subj_idx,block)              = rsvpGRP(subj_idx).RTsC(block);
        %RTsC_CC(subj_idx,block)           = rsvpGRP(subj_idx).RTsC_CC(block);
        
    end
    
    for blockCondi = 1:6
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
subplot(2,2,1)
hold on;
errorbar(1, mean(perf_DC), perf_DC_sem, 'k.','LineWidth',1);
errorbar((2-.8/3), mean(perf_CC_DC), perf_CC_DC_sem, 'k.','LineWidth',.8);
errorbar((2), mean(perf_CC), perf_CC_sem, 'k.','LineWidth',.8);
errorbar((2+.8/3), mean(perf_CC_BC), perf_CC_BC_sem, 'k.','LineWidth',.8);
errorbar(3, mean(perf_BC), perf_BC_sem, 'k.','LineWidth',1);
bar(1, mean(perf_DC),'FaceColor',[.55 .25 .35], 'FaceAlpha', .9)
b1 = bar((2-.8/3), mean(perf_CC_DC),'FaceColor',[.85 .75 .75], 'BarWidth',.8/3,'FaceAlpha', .9);
b2 = bar((2), mean(perf_CC),'FaceColor',[.75 .75 .75], 'BarWidth',.8/3,'FaceAlpha', .9);
b3 = bar((2+.8/3), mean(perf_CC_BC),'FaceColor',[.75 .85 .75], 'BarWidth',.8/3, 'FaceAlpha', .9);
bar(3, mean(perf_BC),'FaceColor',[.40 .55 .40], 'FaceAlpha', .9)
sigstar({[1,2],[1,3],[2,3]},[p_perf_DC_CC, p_perf_DC_BC, p_perf_CC_BC], 0, 100);
xticks([1 2 3])
xticklabels({'DC','CC','BC'})
legend([b1 b2 b3],{'CC (DC)','CC', 'CC (BC)'},'fontsize', 6, 'location','southeast')
ylabel('Performance (mean +/- SEM %)','fontsize', 10)
title('Performance According to Conditions','fontsize', 10)
axis([0 4 50 105])
grid minor
box on
hold off

% Performance par rewards
subplot(2,2,2)
hold on;
rwd_plotY = [perf_smallRwd.', perf_largeRwd.'];
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
sigstar({[1,2]},p_perf_rwd, 0, 1);
xticks([1 2])
legend({'Mean'}, 'Location', 'southeast')
xticklabels({'Small Rwd','Large Rwd'})
ylabel('Performance (median +/- percentile %)','fontsize', 10)
title('Performance According to Reward Size','fontsize', 10)
axis([0 3 50 110])
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,2,3)
hold on;
errorbar(1, mean(perf_DC_smallRwd), perf_DC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(1.5-.5/3, mean(perf_CC_DC_smallRwd), perf_CC_DC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5, mean(perf_CC_smallRwd), perf_CC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5+.5/3, mean(perf_CC_BC_smallRwd), perf_CC_BC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(2, mean(perf_BC_smallRwd), perf_BC_smallRwd_sem, 'k.','LineWidth',1)

errorbar(3, mean(perf_DC_largeRwd), perf_DC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(3.5-.5/3, mean(perf_CC_DC_largeRwd), perf_CC_DC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5, mean(perf_CC_largeRwd), perf_CC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5+.5/3, mean(perf_CC_BC_largeRwd), perf_CC_BC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(4, mean(perf_BC_largeRwd), perf_BC_largeRwd_sem, 'k.','LineWidth',1)

b1 = bar(1, mean(perf_DC_smallRwd),'FaceColor',[.65 .35 .45], 'BarWidth',.5, 'FaceAlpha', .9);
b2 = bar(1.5-.5/3, mean(perf_CC_DC_smallRwd),'FaceColor',[.95 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b3 = bar(1.5, mean(perf_CC_smallRwd),'FaceColor',[.85 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b4 = bar(1.5+.5/3, mean(perf_CC_BC_smallRwd),'FaceColor',[.85 .95 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b5 = bar(2, mean(perf_BC_smallRwd),'FaceColor',[.50 .65 .50], 'BarWidth',.5, 'FaceAlpha', .9);

bar(3, mean(perf_DC_largeRwd),'FaceColor',[.45 .15 .25], 'BarWidth',.5, 'FaceAlpha', .9);
bar(3.5-.5/3, mean(perf_CC_DC_largeRwd),'FaceColor',[.75 .65 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(3.5, mean(perf_CC_largeRwd),'FaceColor',[.65 .65 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(3.5+.5/3, mean(perf_CC_BC_largeRwd),'FaceColor',[.65 .75 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(4, mean(perf_BC_largeRwd),'FaceColor',[.30 .45 .30], 'BarWidth',.5, 'FaceAlpha', .9);

sigstar({[1,1.5],[1,2],[1.5,2]},[p_perf_DC_CC_smallRwd, p_perf_DC_BC_smallRwd, p_perf_CC_BC_smallRwd], 0, 100);
sigstar({[3,3.5],[3,4],[3.5,4]},[p_perf_DC_CC_largeRwd, p_perf_DC_BC_largeRwd, p_perf_CC_BC_largeRwd], 0, 100);

xticks([1.5 3.5])
xticklabels({'Small Rwd', 'Large Rwd'})
legend([b1 b2 b3 b4 b5],{'DC','CC (DC)','CC', 'CC (BC)', 'BC'}, 'fontsize', 6 , 'Location', 'southeast')
ylabel('Performance (mean +/- SEM %)','fontsize', 10)
title('Performance According to Rewards and Conditions','fontsize', 10)
axis([0 5 50 105])
grid minor
box on
hold off

subplot(2,2,4)
hold on;
p2 = plot(1:3,[mean(perf_DC_largeRwd), mean(perf_CC_largeRwd), mean(perf_BC_largeRwd)], 'linewidth',2.3);
p2.Color = [.00, .45, .55];
p1 = plot(1:3,[mean(perf_DC_smallRwd), mean(perf_CC_smallRwd), mean(perf_BC_smallRwd)], 'linewidth',2.3);
p1.Color = [.45, .75, .80];
shadedErrorBar(1:3, [mean(perf_DC_largeRwd), mean(perf_CC_largeRwd), mean(perf_BC_largeRwd)], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem],'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.2);
e2 = errorbar(1:3,[mean(perf_DC_largeRwd), mean(perf_CC_largeRwd), mean(perf_BC_largeRwd)], ...
    [perf_DC_largeRwd_sem, perf_CC_largeRwd_sem, perf_BC_largeRwd_sem], 'k.','LineWidth',.9);
e2.Color = [.00, .45, .55];
shadedErrorBar(1:3,[mean(perf_DC_smallRwd), mean(perf_CC_smallRwd), mean(perf_BC_smallRwd)], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem],'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.2);
e1 = errorbar(1:3,[mean(perf_DC_smallRwd), mean(perf_CC_smallRwd), mean(perf_BC_smallRwd)], ...
    [perf_DC_smallRwd_sem, perf_CC_smallRwd_sem,perf_BC_smallRwd_sem], 'k.','LineWidth',.9);
e1.Color = [.45, .75, .80];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
sigstar({[.8,1.2],[1.8,2.2],[2.8,3.2]},[p_perf_DC_rwd, p_perf_CC_rwd, p_perf_BC_rwd], 0, 100);
xticks([1 2 3])
legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
xticklabels({'DC','CC','BC '})
ylabel('Performance (mean +/- SEM)','fontsize', 10)
title('Performance According to Reward and Conditions','fontsize', 10)
axis([0 4 50 105])
grid minor
box on
hold off

% Title of the performance plots
sgtitle(['Performance Plots for ',num2str(nS), ' Pilots'])

%% SDT Plots 
figure('Name', 'RSVP SDT Plots');
subplot(2,3,1)
hold on;
b1 = bar([2, 3], [mean(hit_rate_DC), mean(reject_rate_DC), mean(falseAlarm_rate_DC), mean(miss_rate_DC) ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b1(1).CData = [.70 .84 .77]; b1(2).CData = [.40 .54 .47]; b1(3).CData = [.88 .74 .74]; b1(4).CData = [.73 .37 .37];
b2 = bar([3, 4], [mean(hit_rate_CC), mean(reject_rate_CC), mean(falseAlarm_rate_CC), mean(miss_rate_CC) ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b2(1).CData = [.70 .84 .77]; b2(2).CData = [.40 .54 .47]; b2(3).CData = [.88 .74 .74]; b2(4).CData = [.73 .37 .37];
b3 = bar([4, 5], [mean(hit_rate_BC), mean(reject_rate_BC), mean(falseAlarm_rate_BC), mean(miss_rate_BC) ; 0 0 0 0], 'stacked', 'FaceColor','flat');
b3(1).CData = [.70 .84 .77]; b3(2).CData = [.40 .54 .47]; b3(3).CData = [.88 .74 .74]; b3(4).CData = [.73 .37 .37];
xticks([2 3 4])
xticklabels({'DC','CC','BC'})
ylabel('Probability','fontsize', 10)
legend({'Hit', 'Reject', 'FA', 'Miss'},'fontsize', 6 , 'Location', 'southeast')
title('SDT Performance According to Conditions','fontsize', 10)
axis([1 5 0 1])
grid minor
box on
hold off

subplot(2,3,2)
hold on;
errorbar(1, mean(criterion_DC), criterion_DC_sem, 'k.','LineWidth',1)
errorbar(1.5-.5/3, mean(criterion_CC_DC), criterion_CC_DC_sem, 'k.','LineWidth',.8)
errorbar(1.5, mean(criterion_CC), criterion_CC_sem, 'k.','LineWidth',.8)
errorbar(1.5+.5/3, mean(criterion_CC_BC), criterion_CC_BC_sem, 'k.','LineWidth',.8)
errorbar(2, mean(criterion_BC), criterion_BC_sem, 'k.','LineWidth',1)

bar(1, mean(criterion_DC),'FaceColor',[.70 .60 .70], 'BarWidth',.5, 'FaceAlpha', .9);
b5 = bar(1.5-.5/3, mean(criterion_CC_DC),'FaceColor',[0.73,0.68,0.73], 'BarWidth',.5/3, 'FaceAlpha', .9);
b6 = bar(1.5, mean(criterion_CC),'FaceColor',[.65 .65 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
b7 = bar(1.5+.5/3, mean(criterion_CC_BC),'FaceColor',[0.54,0.47,0.54], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(2, mean(criterion_BC),'FaceColor',[0.52,0.37,0.52], 'BarWidth',.5, 'FaceAlpha', .9);

sigstar({[1,1.5],[1,2],[1.5,2]},[p_crit_DC_CC, p_crit_DC_BC, p_crit_CC_BC], 0, 100);
xticks([1 1.5 2])
xticklabels({'DC','CC','BC'})
legend([b5 b6 b7],{'CC (DC)','CC', 'CC (BC)'},'fontsize', 6, 'location','southeast')
ylabel('Criterion C (mean +/- SEM %)','fontsize', 10)
title('Criterion According to the Conditions','fontsize', 10)
axis([0 3 0 1.5])
grid minor
box on
hold off

subplot(2,3,3)
hold on
scatter(mean(dprime_DC), mean(perf_DC), 30, 'MarkerFaceColor', 'r' ,'MarkerEdgeColor','k')
scatter(mean(dprime_CC), mean(perf_CC), 30, 'MarkerFaceColor', 'k' ,'MarkerEdgeColor','k')
scatter(mean(dprime_BC), mean(perf_BC), 30, 'MarkerFaceColor', 'g' ,'MarkerEdgeColor','k')
legend({'DC','CC', 'BC'},'fontsize', 6, 'location','southeast')
%line([0, 1], [0, 100], 'color', 'r','LineStyle','--','LineWidth',1.5);
xlim([0 1]); ylim([0 100]);
xlabel('D Prime', 'fontsize', 10);
ylabel('Performance', 'fontsize', 10);
title("Link betwene Performance and D'",'fontsize', 10);
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,3,4)
hold on;
errorbar(1, mean(dprime_DC), dprime_DC_sem, 'k.','LineWidth',1)
errorbar(1.5-.5/3, mean(dprime_CC_DC), dprime_CC_DC_sem, 'k.','LineWidth',.8)
errorbar(1.5, mean(dprime_CC), dprime_CC_sem, 'k.','LineWidth',.8)
errorbar(1.5+.5/3, mean(dprime_CC_BC), dprime_CC_BC_sem, 'k.','LineWidth',.8)
errorbar(2, mean(dprime_BC), dprime_BC_sem, 'k.','LineWidth',1)

bar(1, mean(dprime_DC),'FaceColor',[.90 .58 .69], 'BarWidth',.5, 'FaceAlpha', .9);
b2 = bar(1.5-.5/3, mean(dprime_CC_DC),'FaceColor',[.95 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b3 = bar(1.5, mean(dprime_CC),'FaceColor',[.85 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b4 = bar(1.5+.5/3, mean(dprime_CC_BC),'FaceColor',[.85 .95 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(2, mean(dprime_BC),'FaceColor',[.63 .82 .75], 'BarWidth',.5, 'FaceAlpha', .9);

sigstar({[1,1.5],[1,2],[1.5,2]},[p_dprime_DC_CC, p_dprime_DC_BC, p_dprime_CC_BC], 0, 100);
xticks([1 1.5 2])
xticklabels({'DC','CC','BC'})
legend([b2 b3 b4],{'CC (DC)','CC', 'CC (BC)'},'fontsize', 6, 'location','southeast')
ylabel('D prime (mean +/- SEM %)','fontsize', 10)
title('Sensitivty Index According to the Conditions','fontsize', 10)
axis([0 3 0 1.5])
grid minor
box on
hold off

% Performance par conditions & rewards
subplot(2,3,5:6)
hold on;
errorbar(1, mean(dprime_DC_smallRwd), dprime_DC_smallRwd_sem, 'k.','LineWidth',1)
errorbar(1.5-.5/3, mean(dprime_CC_DC_smallRwd), dprime_CC_DC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5, mean(dprime_CC_smallRwd), dprime_CC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(1.5+.5/3, mean(dprime_CC_BC_smallRwd), dprime_CC_BC_smallRwd_sem, 'k.','LineWidth',.8)
errorbar(2, mean(dprime_BC_smallRwd), dprime_BC_smallRwd_sem, 'k.','LineWidth',1)

errorbar(3, mean(dprime_DC_largeRwd), dprime_DC_largeRwd_sem, 'k.','LineWidth',1)
errorbar(3.5-.5/3, mean(dprime_CC_DC_largeRwd), dprime_CC_DC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5, mean(dprime_CC_largeRwd), dprime_CC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(3.5+.5/3, mean(dprime_CC_BC_largeRwd), dprime_CC_BC_largeRwd_sem, 'k.','LineWidth',.8)
errorbar(4, mean(dprime_BC_largeRwd), dprime_BC_largeRwd_sem, 'k.','LineWidth',1)

b1 = bar(1, mean(dprime_DC_smallRwd),'FaceColor',[.95 .63 .75], 'BarWidth',.5, 'FaceAlpha', .9);
b2 = bar(1.5-.5/3, mean(dprime_CC_DC_smallRwd),'FaceColor',[.95 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b3 = bar(1.5, mean(dprime_CC_smallRwd),'FaceColor',[.85 .85 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b4 = bar(1.5+.5/3, mean(dprime_CC_BC_smallRwd),'FaceColor',[.85 .95 .85], 'BarWidth',.5/3, 'FaceAlpha', .9);
b5 = bar(2, mean(dprime_BC_smallRwd),'FaceColor',[.68 .88 .80], 'BarWidth',.5, 'FaceAlpha', .9);

bar(3, mean(dprime_DC_largeRwd),'FaceColor',[.85 .52 .61], 'BarWidth',.5, 'FaceAlpha', .9);
bar(3.5-.5/3, mean(dprime_CC_DC_largeRwd),'FaceColor',[.75 .65 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(3.5, mean(dprime_CC_largeRwd),'FaceColor',[.65 .65 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(3.5+.5/3, mean(dprime_CC_BC_largeRwd),'FaceColor',[.65 .75 .65], 'BarWidth',.5/3, 'FaceAlpha', .9);
bar(4, mean(dprime_BC_largeRwd),'FaceColor',[.58 .77 .70], 'BarWidth',.5, 'FaceAlpha', .9);

sigstar({[1,3],[1.5,3.5],[2,4]},[p_dprime_DC_rwd, p_dprime_CC_rwd, p_dprime_BC_rwd], 0, 100);

xticks([1.5 3.5])
xticklabels({'Small Rwd', 'Large Rwd'})
legend([b1 b2 b3 b4 b5],{'DC','CC (DC)','CC', 'CC (BC)', 'BC'}, 'fontsize', 6 , 'Location', 'southeast')
ylabel('D prime (mean +/- SEM %)','fontsize', 10)
title('Sensitivty Index According to Rewards and Conditions','fontsize', 10)
axis([0 5 0 1.5])
grid minor
box on
hold off

% Title of the performance plots
sgtitle(['SDT Plots for ',num2str(nS), ' Pilots'])

%% RTs Plots
figure('Name', 'RSVP RTs Plots');
subplot(2,3,1)
histogram(rt,'FaceColor',[.44, .24, .38], 'EdgeColor', [.5 .5 .5])
xlabel('log(RTs) (mean +/- SEM)','fontsize', 10)
ylabel('Number of Trials','fontsize', 10)
title('Fig1. Distribution of RSVP Reaction Times','fontsize', 10)
axis([-3 3 -inf inf])
grid minor
box on

% RTs par conditions
subplot(2,3,2)
hold on;
bar([nanmean(rt_DC) 0 0],'FaceColor',[.55 .25 .35]);
bar([0 nanmean(rt_CC) 0],'FaceColor',[.75 .75 .75]);
bar([0 0 nanmean(rt_BC)],'FaceColor',[.40 .55 .40]);
errorbar(1, nanmean(rt_DC), nanstd(rt_DC)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, nanmean(rt_CC), nanstd(rt_CC)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3, nanmean(rt_BC), nanstd(rt_BC)/sqrt(nS), 'k.','LineWidth',1)
sigstar({[1,2],[1,3],[2,3]},[p_rt_DC_CC, p_rt_DC_BC, p_rt_CC_BC], 0, 1);
xticks([1 2 3 4])
xticklabels({'DC','CC', 'BC'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('Fig2. RTs According to Conditions','fontsize', 10)
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
sigstar({[1,2]},p_rt_rwd, 0, 1);
xticks([1 2])
xticklabels({'Small Rwd','Large Rwd'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title( 'Fig3. RTs According to Reward Size','fontsize', 10)
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
sigstar({[.8,1.2],[1.8,2.2],[2.8,3.2]},[p_rt_DC_rwd, p_rt_CC_rwd, p_rt_BC_rwd], 0, 1);
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
xticks([1 2 3])
legend({'Large Rwd','Small Rwd'}, 'Location', 'northeast')
xticklabels({'DC','CC','BC '})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('Fig4. RTs According to Reward and Conditions','fontsize', 10)
axis([0 4 -1 1])
grid minor
box on
hold off

% RTs par conditions & correct
subplot(2,2,4)
hold on;

p1 = plot(1:3,[mean(rt_DC_correct), mean(rt_CC_correct), mean(rt_BC_correct)], 'linewidth',2.3);
p1.Color = [.2 .5 .2];
p2 = plot(1:3,[mean(rt_DC_incorrect), mean(rt_CC_incorrect), mean(rt_BC_incorrect)], 'linewidth',2.3);
p2.Color = [.8 .3 .3];
line([0,5], [0,0], 'color','k','LineStyle',':','LineWidth',.8)
shadedErrorBar(1:3,[mean(rt_DC_correct), mean(rt_CC_correct), mean(rt_BC_correct)], ...
    [(std(rt_DC_correct)/sqrt(nS)), (nanstd(rt_CC_correct)/sqrt(nS)), (std(rt_BC_correct)/sqrt(nS))],'lineprops',{'Color',[.2 .5 .2]},'patchSaturation',.2);
e1 = errorbar(1:3,[mean(rt_DC_correct), mean(rt_CC_correct), mean(rt_BC_correct)], ...
    [(std(rt_DC_correct)/sqrt(nS)), (std(rt_CC_correct)/sqrt(nS)), (std(rt_BC_correct)/sqrt(nS))], 'k.','LineWidth',.9);
e1.Color = [.2 .5 .2];
shadedErrorBar(1:3, [nanmean(rt_DC_incorrect), nanmean(rt_CC_incorrect), nanmean(rt_BC_incorrect)], ...
    [(nanstd(rt_DC_incorrect)/sqrt(nS)), (nanstd(rt_CC_incorrect)/sqrt(nS)), (nanstd(rt_BC_incorrect)/sqrt(nS))],'lineprops',{'Color',[.8 .3 .3]},'patchSaturation',.2);
e2 = errorbar(1:3,[nanmean(rt_DC_incorrect), nanmean(rt_CC_incorrect), nanmean(rt_BC_incorrect)], ...
    [(nanstd(rt_DC_incorrect)/sqrt(nS)), (nanstd(rt_CC_incorrect)/sqrt(nS)), (nanstd(rt_BC_incorrect)/sqrt(nS))], 'k.','LineWidth',.9);
e2.Color = [.8 .3 .3];
sigstar({[.8,1.2],[1.8,2.2],[2.8,3.2]},[p_rt_DC_correct, p_rt_CC_correct, p_rt_BC_correct], 0, 1);
xticks([1 2 3])
xticklabels({'DC','CC',' BC'})
ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
title('Fig5. RTs for Correct and Incorrect Trials in fct of Conditions','fontsize', 10)
legend({'Correct','Incorrect'}, 'Location', 'northeast')
axis([0 4 -.8 .8])
grid minor
box on
hold off

% Title of the performance plots
sgtitle(['RTs Plots for ',num2str(nS), ' Pilots'])

%% Gender Plots

% % Performance par gender
 figure('Name', 'Gender Plots');
% 
% subplot(2,2,1)
% hold on;
% bar(1, mean(perf_fem),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(1.5, mean(perf_hom),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% bar(2.5, mean(perf_fem(1:4)),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(3, mean(perf_hom(1:4)),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% bar(4, mean(perf_fem(5:end)),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(4.5, mean(perf_hom(5:end)),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% errorbar(1, mean(perf_fem), std(perf_fem)/sqrt(nS), 'k.','LineWidth',1)
% errorbar(1.5, mean(perf_hom), std(perf_hom)/sqrt(nS), 'k.','LineWidth',1)
% errorbar(2.5, mean(perf_fem(1:4)), std(perf_fem(1:4))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(3, mean(perf_hom(1:4)), std(perf_hom(1:4))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(4, mean(perf_fem(5:end)), std(perf_fem(5:end))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(4.5, mean(perf_hom(5:end)), std(perf_hom(5:end))/sqrt(nS), 'k.','LineWidth',1)
% sigstar({[1,1.5]},p_perf_gender, 0, 100);
% legend({'Female Face', 'Male Face'},'fontsize', 6 , 'Location', 'northeast')
% xticks([1 2.5 4])
% xticklabels({'General','Female pilot','Male pilot'})
% ylabel('Performance (mean +/- SEM %)','fontsize', 10)
% title('Performance according to gender','fontsize', 10)
% axis([0.5 5 50 105])
% grid minor
% box on
% hold off
% 
% subplot(2,2,2)
% hold on;
% bar(1, mean(rt_fem),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(1.5, mean(rt_hom),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% bar(2.5, mean(rt_fem(1:4)),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(3, mean(rt_hom(1:4)),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% bar(4, mean(rt_fem(5:end)),'FaceColor',[0.85 0.55 0.65],'BarWidth',.5);
% bar(4.5, mean(rt_hom(5:end)),'FaceColor',[0.45, 0.60, 0.70],'BarWidth',.5);
% errorbar(1, mean(rt_fem), std(rt_fem)/sqrt(nS), 'k.','LineWidth',1)
% errorbar(1.5, mean(rt_hom), std(rt_hom)/sqrt(nS), 'k.','LineWidth',1)
% errorbar(2.5, mean(rt_fem(1:4)), std(rt_fem(1:4))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(3, mean(rt_hom(1:4)), std(rt_hom(1:4))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(4, mean(rt_fem(5:end)), std(rt_fem(5:end))/sqrt(nS), 'k.','LineWidth',1)
% errorbar(4.5, mean(rt_hom(5:end)), std(rt_hom(5:end))/sqrt(nS), 'k.','LineWidth',1)
% %sigstar({[1,1.5]},p_rt_gender, 0, 1);
% legend({'Female Face', 'Male Face'},'fontsize', 6 , 'Location', 'northeast')
% xticks([1 2.5 4])
% xticklabels({'General','Female pilot','Male pilot'})
% ylabel('log(RTs)','fontsize', 10)
% title('RTs according to gender','fontsize', 10)
% axis([0.5 5 -1 1])
% grid minor
% box on
% hold off
% 
% Performance par genre & conditions
subplot(2,1,2)
hold on;
bar(1, mean(perf_DC_fem_smallRwd),'FaceColor',[0.65 0.35 0.45],'BarWidth',.45);
bar(1.5, mean(perf_DC_fem_largeRwd),'FaceColor',[0.45 0.15 0.25],'BarWidth',.45);
bar(2, mean(perf_CC_fem_smallRwd),'FaceColor',[0.85 0.85 0.85],'BarWidth',.45);
bar(2.5, mean(perf_CC_fem_largeRwd),'FaceColor',[0.65 0.65 0.65],'BarWidth',.45);
bar(3, mean(perf_BC_fem_smallRwd),'FaceColor',[0.50 0.65 0.50],'BarWidth',.45);
bar(3.5, mean(perf_BC_fem_largeRwd),'FaceColor',[0.30 0.45 0.30],'BarWidth',.45);

errorbar(1, mean(perf_DC_fem_smallRwd), std(perf_DC_fem_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(1.5, mean(perf_DC_fem_largeRwd), std(perf_DC_fem_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2, mean(perf_CC_fem_smallRwd), std(perf_CC_fem_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(2.5, mean(perf_CC_fem_largeRwd), std(perf_CC_fem_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3, mean(perf_BC_fem_smallRwd), std(perf_BC_fem_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
errorbar(3.5, mean(perf_BC_fem_largeRwd), std(perf_BC_fem_largeRwd)/sqrt(nS), 'k.','LineWidth',1)

bar(4.5, mean(perf_DC_hom_smallRwd),'FaceColor',[0.65 0.35 0.45],'BarWidth',.45);
errorbar(4.5, mean(perf_DC_hom_smallRwd), std(perf_DC_hom_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
bar(5, mean(perf_DC_hom_largeRwd),'FaceColor',[0.45 0.15 0.25],'BarWidth',.45);
errorbar(5, mean(perf_DC_hom_largeRwd), std(perf_DC_hom_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
bar(5.5, mean(perf_CC_hom_smallRwd),'FaceColor',[0.85 0.85 0.85],'BarWidth',.45);
errorbar(5.5, mean(perf_CC_hom_smallRwd), std(perf_CC_hom_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
bar(6, mean(perf_CC_hom_largeRwd),'FaceColor',[0.65 0.65 0.65],'BarWidth',.45);
errorbar(6, mean(perf_CC_hom_largeRwd), std(perf_CC_hom_largeRwd)/sqrt(nS), 'k.','LineWidth',1)
bar(6.5, mean(perf_BC_hom_smallRwd),'FaceColor',[0.50 0.65 0.50],'BarWidth',.45);
errorbar(6.5, mean(perf_BC_hom_smallRwd), std(perf_BC_hom_smallRwd)/sqrt(nS), 'k.','LineWidth',1)
bar(7, mean(perf_BC_hom_largeRwd),'FaceColor',[0.30 0.45 0.30],'BarWidth',.45);
errorbar(7, mean(perf_BC_hom_largeRwd), std(perf_BC_hom_largeRwd)/sqrt(nS), 'k.','LineWidth',1)

xticks([1.5 5])
xticklabels({'Female Faces', 'Male Faces'})
legend({'DC SR', 'DC LR', 'CC SR', 'CC LR', 'BC SR', 'BC LR'},'fontsize', 6 , 'Location', 'northeast')
ylabel('Performance (mean +/- SEM %)','fontsize', 10)
title('Performance according to gender & conditions','fontsize', 10)
axis([0 8 50 105])
grid minor
box on
hold off

% Title of the performance plots
sgtitle(['Gender Plots for ',num2str(nS), ' Pilots'])

%% Learning Curves Plots
fig = false;
if fig
    figure('Name', 'RSVP Learning Curve Plots');
    
    subplot(2,1,1)
    p = plot(1:length(LC), mean(LC),'linew',1.5);
    p.Color = [.0, .0, .0];
    shadedErrorBar(1:length(LC),mean(LC),(std(LC)/sqrt(nS)),'lineprops',{'Color',[.0, .0, .0]},'patchSaturation',.4);
    %line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:(length(LC)))
    xticklabels(1:12)
    title('Learning Curve RSVP Experiment','fontsize', 10)
    axis([0 (length(LC)+1) 40 100])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p2 = plot(1:6, mean(LC_largeRwd),'-o','linew',1.5);
    p2.Color = [.00, .45, .55];
    p1 = plot(1:6, mean(LC_smallRwd),'-x','linew',1.5);
    p1.Color = [.45, .75, .80];
    shadedErrorBar(1:6,mean(LC_largeRwd),(std(LC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(LC_smallRwd),(std(LC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.4);
    %line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('Learning Curve for Small and Large Rewards','fontsize', 10)
    axis([0 7 40 100])
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
    shadedErrorBar(1:6,mean(LC_DC),(std(LC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.4);
    shadedErrorBar(1:6,mean(LC_CC),(std(LC_CC)/sqrt(nS)),'lineprops',{'Color',[.50 .50 .50]},'patchSaturation',.4);
    shadedErrorBar(1:6,mean(LC_BC),(std(LC_BC)/sqrt(nS)),'lineprops',{'Color',[.40 .55 .40]},'patchSaturation',.4);
    %line([-15,15], [50,50],'color','k','LineStyle','--','LineWidth',.7)
    legend({'DC','CC','BC'}, 'Location', 'southeast')
    ylabel('Performance (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('Learning Curve for Each Conditions','fontsize', 10)
    axis([0 7 40 100])
    hold off
    grid minor
    box on
    
    % Title of the LC plots
    sgtitle(['Learning Curve Plots for ',num2str(nS), 'Pilots'])
    
    %% RTs Curves Plots
    figure('Name', 'RSVP RTs Curve Plots');
    subplot(2,3,1)
    hold on;
    rt_plotY = [rt_slow_perf.', rt_fast_perf.'];
    rt_plotX = [1, 2];
    rt_plot_color = {[.44, .24, .38], [.69, .56, .65]};
    B = boxplot(rt_plotY, rt_plotX,'Widths',.7);
    get (B, 'tag');
    set(B(1,:), 'color', 'k'); set(B(2,:), 'color', 'k');
    set(B(6,:), 'color', 'k', 'linewidth', 2);
    scatter(rt_plotX,mean(rt_plotY),'k','filled','d')
    h = findobj(gca,'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),rt_plot_color{j},'FaceAlpha',.7);
    end
    sigstar({[1,2]},p_rt_perf, 0, 1);
    xticks([1 2])
    legend({'Mean'}, 'Location', 'southeast')
    xticklabels({'Slow RTs','Fast RTs'}) %(> or < median(log(rt))
    ylabel('Performance','fontsize', 10)
    title('Performance According to Slow and Fast Response','fontsize', 10)
    axis([0 3 50 105])
    grid minor
    box on
    hold off
    
    
    subplot(2,3,2:3)
    p = plot(1:length(RTsC), smooth(mean(RTsC)),'linew',1.5);
    p.Color = [.44, .24, .38];
    shadedErrorBar(1:length(RTsC), smooth(mean(RTsC)),(std(RTsC)/sqrt(nS)),'lineprops',{'Color',[.44, .24, .38]},'patchSaturation',.4);
    line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
    ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:(length(RTsC)))
    xticklabels(1:12)
    title('RTs Curve RSVP Experiment','fontsize', 10)
    axis([0 (length(RTsC)+1)  -1 1])
    grid minor
    box on
    
    subplot(2,2,3)
    hold on
    p2 = plot(1:6, mean(RTsC_largeRwd),'-o','linew',1.5);
    p2.Color = [.00, .45, .55];
    p1 = plot(1:6, mean(RTsC_smallRwd),'-x','linew',1.5);
    p1.Color = [.45, .75, .80];
    shadedErrorBar(1:6,mean(RTsC_largeRwd),(std(RTsC_largeRwd)/sqrt(nS)),'lineprops',{'Color',[.00, .45, .55]},'patchSaturation',.3);
    shadedErrorBar(1:6,mean(RTsC_smallRwd),(std(RTsC_smallRwd)/sqrt(nS)),'lineprops',{'Color',[.45, .75, .80]},'patchSaturation',.4);
    line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
    legend({'Large Rwd','Small Rwd'}, 'Location', 'southeast')
    ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('RTs Curve for Small and Large Rewards','fontsize', 10)
    axis([0 7 -1 1])
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
    shadedErrorBar(1:6,mean(RTsC_DC),(std(RTsC_DC)/sqrt(nS)),'lineprops',{'Color',[.75 .45 .55]},'patchSaturation',.4);
    shadedErrorBar(1:6,mean(RTsC_CC),(std(RTsC_CC)/sqrt(nS)),'lineprops',{'Color',[.50 .50 .50]},'patchSaturation',.4);
    shadedErrorBar(1:6,mean(RTsC_BC),(std(RTsC_BC)/sqrt(nS)),'lineprops',{'Color',[.40 .55 .40]},'patchSaturation',.4);
    line([-15,15], [0,0],'color','k','LineStyle','--','LineWidth',.7)
    legend({'DC','CC','BC'}, 'Location', 'southeast')
    ylabel('log(RTs) (mean +/- SEM)','fontsize', 10)
    xlabel('Number of Blocks','fontsize', 10)
    xticks(1:6); xticklabels(1:6)
    title('RTs Curve for Each Conditions','fontsize', 10)
    axis([0 7 -1 1])
    hold off
    grid minor
    box on
    
    % Title of the RTS curve plots
    sgtitle(['RTs Curve Plots for ',num2str(nS), 'Pilots'])
    
end
