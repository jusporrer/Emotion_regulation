% Pre-processing Online Data 
% Author : Juliana Sporrer 
% Creation : May 2020

clear all; 

%% =================== Load the data                    ===================

data_rsvp = importfile("dataMamaFull.csv"); 

% pos_happyexp = [] ;
% for i = 1:length(test_part)
%     % we are looking for moodpart 
%     if +(test_part{i}(4:6) == 'dte') == [1 1 1]
%         pos_happyexp = [pos_happyexp i] ;
%     end
% end

useless_parts = (data_rsvp.test_part == "fullscreenExp" | ...
    data_rsvp.test_part == "instr" | data_rsvp.test_part == "fixation"| ...
    data_rsvp.test_part == "firstFullscreen" | data_rsvp.test_part == "instrCondi");

data_rsvp = data_rsvp(~useless_parts,:); 

data_rsvp(1,:) = []; %take out the first line 

save('data_rsvp.mat', 'data_rsvp') 
