% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020
clearvars; 
close all; 

%% =================== Get All Individual Data          ===================

subject_ID = [81473, 74239, 81473, 98197, 12346, 90255, 33222, 90255];

for subj_idx = 1:length(subject_ID) 
    disp(subject_ID(subj_idx))
    rsvpGRP(subj_idx) = Individual_Analysis_RSVP(subject_ID(subj_idx), false); 
end

%% =================== Performance                      ===================

perf            = mean([rsvpGRP.performance]);
perf_std        = std([rsvpGRP.performance]);

hit_rate        = mean([rsvpGRP.hit_rate]);
reject_rate     = mean([rsvpGRP.reject_rate]);

miss_rate       = mean([rsvpGRP.miss_rate]);
falseAlarm_rate = mean([rsvpGRP.falseAlarm_rate]);


perf_DC         = mean([rsvpGRP.perf_DC]);
perf_DC_std     = std([rsvpGRP.perf_DC]);

perf_CC         = mean([rsvpGRP.perf_CC]);
perf_CC_std     = std([rsvpGRP.perf_CC]);

perf_BC         = mean([rsvpGRP.perf_BC]);
perf_BC_std     = std([rsvpGRP.perf_BC]);
    
perf_lag2       = mean([rsvpGRP.lag2_rate]);
perf_lag2_std   = std([rsvpGRP.lag2_rate]);

perf_lag4       = mean([rsvpGRP.lag4_rate]);
perf_lag4_std   = std([rsvpGRP.lag4_rate]);
