% JS initial script analysis for the effect of inentives on emotion regulation
% February 2020

function [] = Individual_Analysis(ID)

try 
%% Load the data (on an individual level)
resp_folder = '../results';

resp_rsvp = [num2str(ID),'_rsvp.mat'];
resp_vs = [num2str(ID),'_visual_search.mat'];

resp_file_rsvp = fullfile(resp_folder,resp_rsvp);
resp_file_vs = fullfile(resp_folder,resp_vs);

load(resp_file_rsvp);
load(resp_file_vs);

if ~isfile(resp_file_rsvp) && ~isfile(resp_file_vs)
    warningMessage = sprintf(['The data for ',num2str(ID),' was not found']);
    uiwait(msgbox(warningMessage));
end

%% Start minimal analysis RSVP 

for i = 1:size(data_rsvp, 1)
    if data_rsvp(i,2) == 1 
        training_rsvp = data_rsvp(i,:);
    elseif data_rsvp(i,2) == 0 
        exp_rsvp = data_rsvp(i,:);
    end 
end 

% To make sure no trial was lost. 
if size(exp_rsvp,1) < 180 %nb of decided trials 
    disp(['Warning : There were only ', num2str(size(exp_rsvp,1)),' trials']); 
end 





catch
    fprintf('This was the last error : \n');
end

end

%% 

