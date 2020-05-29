% Pre-processing Online Data 
% Author : Juliana Sporrer 
% Creation : May 2020

clear all; 

%% =================== Load the data                    ===================

data_rsvp_Aws = importfileServerAws("tableEmo_Aws_2905.csv"); 

useless_parts = (data_rsvp_Aws.test_part == "fullscreenExp" | ...
    data_rsvp_Aws.test_part == "instr" | data_rsvp_Aws.test_part == "fixation"| ...
    data_rsvp_Aws.test_part == "rsvp_img_15"| data_rsvp_Aws.test_part == "firstFullscreen" | data_rsvp_Aws.test_part == "instrCondi" | ...
    data_rsvp_Aws.runID == 26 | data_rsvp_Aws.participant_participantID ~= "user7" );

data_rsvp_Aws = data_rsvp_Aws(~useless_parts,:); 

data_rsvp_Aws(1,:) = []; %take out the first line 

save('data_rsvp_Aws.mat', 'data_rsvp_Aws') 
