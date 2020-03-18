% JS initial group analysis script for the effect of incentives on emotion regulation

% Creation : Mars 2020

subject_ID = [81473, 74239, 81477, 98197, 12346, 90255, 33222, 90255, 48680];

for subj_idx = 1:length(subject_ID) 
    disp(subject_ID(subj_idx))
    mem(subj_idx) = Individual_Analysis_Memory(subject_ID(subj_idx), false); 
end

perf = mean([mem.performance]);
perf_DC = mean([mem.perf_DC]);
perf_CC = mean([mem.perf_CC]);
perf_BC = mean([mem.perf_BC]);

