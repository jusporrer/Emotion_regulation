% Pre-processing Online Data 
% Author : Juliana Sporrer 
% Creation : May 2020

clearvars; 

%% =================== Load the data                    ===================

data_rsvp_Aws = importBigFileServerAws("tableEmo_Aws/tableEmo_Aws_1708.csv"); 

data_try = data_rsvp_Aws;

% Takes out useless information 
useless_parts = (data_rsvp_Aws.test_part == "fullscreenExp" | ...
    data_rsvp_Aws.test_part == "instr" | data_rsvp_Aws.test_part == "fixation"| ...
    data_rsvp_Aws.test_part == "rsvp_img_15"| data_rsvp_Aws.test_part == "firstFullscreen" | data_rsvp_Aws.test_part == "instrCondi");

data_rsvp_Aws = data_rsvp_Aws(~useless_parts,:); 

% Takes out the session that were not finished 
unfinished_data = (data_rsvp_Aws.doneTime == ""); 
data_rsvp_Aws = data_rsvp_Aws(~unfinished_data,:); 

% Takes out the rest
data_rsvp_Aws.runID = [];
%data_rsvp_Aws.startTime = [];
%data_rsvp_Aws.doneTime = [];
data_rsvp_Aws.taskSession_taskSessionID = [];
data_rsvp_Aws.taskSessionID = [];
%data_rsvp_Aws.sessionName = [];
data_rsvp_Aws.openingTime = [];
data_rsvp_Aws.closingTime = [];
data_rsvp_Aws.task_taskID = [];
data_rsvp_Aws.time_elapsed = [];
data_rsvp_Aws.internal_node_id = [];
data_rsvp_Aws.run_id = [];
data_rsvp_Aws.data_rsvp_Aws.date = [];

% Takes out the first line with the names
data_rsvp_Aws(1,:) = []; 

% Takes out the test IDs 
id = data_rsvp_Aws.participant_participantID; 

test_id = (id == "KOG1MOOD" | id == "KOG2MOOD" | id == "KOG3MOOD" ...
    | id == "KOG4MOOD" | id == "KOG5MOOD" | id == "KOG6MOOD" | id == "KOG7MOOD" ...
    | id == "KOG8MOOD"| id == "KOG9MOOD");

data_rsvp_Aws = data_rsvp_Aws(~test_id,:);

subject_id = unique(data_rsvp_Aws.participant_participantID); 

% Takes out any repeat (only looks at the first session)

first_session = 




save('data_rsvp_Aws_1708.mat', 'data_rsvp_Aws') 
save('subject_id.mat', 'subject_id') 
