% JS group analysis script for the effect of lag on performance in RSVP 

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

nS              = length(subject_ID);

%% =================== Performance - General            ===================
disp('=================== Performance Information ===================');

perf            = [rsvpGRP.performance];
[h_perf, p_perf]= adtest(perf); % Normality Anderson-Darling test
perf_min        = min([rsvpGRP.performance]);
perf_max        = max([rsvpGRP.performance]);
perf_sem        = std([rsvpGRP.performance])/sqrt(nS);

disp(['Mean : ', ...
    num2str(round(mean(perf))), '% correct (min perf : ', ...
    num2str(round(perf_min)), '% & max perf : ', ...
    num2str(round(perf_max)), '%) ']) ;

perf_lag2           = [rsvpGRP.lag2_rate];
perf_lag2_mean      = mean([rsvpGRP.lag2_rate]);
perf_lag2_min       = min([rsvpGRP.lag2_rate]);
perf_lag2_max       = max([rsvpGRP.lag2_rate]);
perf_lag2_sem       = std([rsvpGRP.lag2_rate])/sqrt(nS);
[h_lag2, p_lag2, stats_lag2 ] = adtest(perf_lag2); 

perf_lag4           = [rsvpGRP.lag4_rate];
perf_lag4_mean      = mean([rsvpGRP.lag4_rate]);
perf_lag4_min       = min([rsvpGRP.lag4_rate]);
perf_lag4_max       = max([rsvpGRP.lag4_rate]);
perf_lag4_sem       = std([rsvpGRP.lag4_rate])/sqrt(nS);
[h_lag4, p_lag4, stats_lag4 ] = adtest(perf_lag4); 

disp(['Lag : ', ...
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
