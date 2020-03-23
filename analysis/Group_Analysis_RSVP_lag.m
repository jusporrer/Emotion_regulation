% JS group analysis script for the effect of lag on performance in RSVP 

% Creation : Mars 2020
clearvars;
close all;

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 98197, 12346, 81477, 90255, 33222, 90255, 48680]; 

for subj_idx = 1:length(subject_ID)
    disp(['=================== Subject ', ...
        num2str(subject_ID(subj_idx)), ' ===================' ]);
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP_lag(subject_ID(subj_idx));
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

% RTsC_lag2                    = zeros(subj_idx,12);
% RTsC_smallRwd_lag2           = zeros(subj_idx,6);
% RTsC_largeRwd_lag2           = zeros(subj_idx,6);
% RTsC_DC_lag2                 = zeros(subj_idx,6);
% RTsC_BC_lag2                 = zeros(subj_idx,6);
% RTsC_CC_lag2                 = zeros(subj_idx,6);

for subj_idx = 1:length(subject_ID)
    
    for block = 1:12
        LC_lag2(subj_idx,block)                = rsvpGRP(subj_idx).LC_lag2(block);
%         RTsC_lag2(subj_idx,block)              = rsvpGRP(subj_idx).RTsC_lag2(block);  
    end
    
    for blockCondi = 1:6
        LC_smallRwd_lag2(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_smallRwd_lag2(blockCondi);
        LC_largeRwd_lag2(subj_idx,blockCondi)  = rsvpGRP(subj_idx).LC_largeRwd_lag2(blockCondi);
        LC_DC_lag2(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_DC_lag2(blockCondi);
        LC_BC_lag2(subj_idx,blockCondi)        = rsvpGRP(subj_idx).LC_BC_lag2(blockCondi);
        LC_CC_lag2(subj_idx,blockCondi)        = (rsvpGRP(subj_idx).LC_CC_lag2(blockCondi) + rsvpGRP(subj_idx).LC_CC_lag2(blockCondi + 6))/2;
        
%         RTsC_smallRwd_lag2(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_smallRwd_lag2(blockCondi);
%         RTsC_largeRwd_lag2(subj_idx,blockCondi)= rsvpGRP(subj_idx).RTsC_largeRwd_lag2(blockCondi);
%         RTsC_DC_lag2(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_DC_lag2(blockCondi);
%         RTsC_BC_lag2(subj_idx,blockCondi)      = rsvpGRP(subj_idx).RTsC_BC_lag2(blockCondi);
%         RTsC_CC_lag2(subj_idx,blockCondi)      = (rsvpGRP(subj_idx).RTsC_CC_lag2(blockCondi) + rsvpGRP(subj_idx).RTsC_CC_lag2(blockCondi + 6))/2;

    end
end