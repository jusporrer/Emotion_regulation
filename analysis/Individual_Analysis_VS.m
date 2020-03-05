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

training = [data_rsvp.training];
reward = [data_rsvp.reward];
condition = [data_rsvp.condition];
block = [data_rsvp.block];
trial = [data_rsvp.trial];
RTs = [data_rsvp.RTs];
response = [data_rsvp.response];
setSizeFF = [data_rsvp.setSizeFF];
setSizeNF = [data_rsvp.setSizeNF];
setSizeFM = [data_rsvp.setSizeFM];
setSizeNM= [data_rsvp.setSizeNM];


end
