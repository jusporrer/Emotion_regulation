% JS initial script analysis for the effect of inentives on emotion regulation
% February 2020

function [] = Individual_Analysis_VS(ID)

%% Load the data (on an individual level)
resp_folder = '../results';

resp_vs = [num2str(ID),'_visual_search.mat'];

resp_file_vs = fullfile(resp_folder,resp_vs);

load(resp_file_vs,'data_visual_search');

if ~isfile(resp_file_vs)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% Start minimal analysis RSVP 

for i = 1:size(data_visual_search, 1)
    if data_visual_search(i,2) == 1 
        training_vs = data_visual_search(i,:);
    elseif data_visual_search(i,2) == 0 
        exp_vs = data_visual_search(i,:);
    end 
end 

% To make sure no trial was lost. 
if size(exp_vs,1) < 180 %nb of decided trials 
    disp(['Warning : There were only ', num2str(size(exp_vs,1)),' trials']); 
end 

% Attribute each column a name 

% respMatColumnsVS = ["ID", "Training", "Reward", "Condition", ...
  %  "Nb Block","Nb Trial", "RTs", "ResponseFF", "ResponseNF", "ResponseFM", "ResponseNM"];

end
