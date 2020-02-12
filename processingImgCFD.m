clearvars;

%% Import the CSV file 
CFD_norming_data_original = importfileCFD('CFD_norming_data_experience.csv', 2, 598);

%% Save original copy 
CFD_norming_data = CFD_norming_data_original; 

%% Initialise The Variables 
% Target = CFD_norming_data.Target;
% Race = CFD_norming_data.Race;
% Gender = CFD_norming_data.Gender;
% Age = CFD_norming_data.Age;
% NumberofRaters = CFD_norming_data.NumberofRaters;
% Afraid = CFD_norming_data.Afraid;
% Angry = CFD_norming_data.Angry;
% Attractive = CFD_norming_data.Attractive;
% Babyface = CFD_norming_data.Babyface;
% Disgusted = CFD_norming_data.Disgusted;
% Dominant = CFD_norming_data.Dominant;
% Feminine = CFD_norming_data.Feminine;
% Happy = CFD_norming_data.Happy;
% Masculine = CFD_norming_data.Masculine;
% Prototypic = CFD_norming_data.Prototypic;
% Sad = CFD_norming_data.Sad;
% Afraid = CFD_norming_data.Afraid;
% Surprised = CFD_norming_data.Surprised;
% Threatening = CFD_norming_data.Threatening;
% Trustworthy = CFD_norming_data.Trustworthy;
% Unusual = CFD_norming_data.Unusual;
% Luminance_median = CFD_norming_data.Luminance_median;

%% Take out the images that are not luminous enough
std_Luminance  = std(CFD_norming_data.Luminance_median)*2 ; % 2 standard-deviation from the mode
mode_Luminance = mode(CFD_norming_data.Luminance_median) ;
low_Luminance_bound = mode_Luminance-std_Luminance;
up_Luminance_bound = mode_Luminance+std_Luminance ;

remove_lumi = []; 
 for nbimg = 1: size(CFD_norming_data,1)
     if CFD_norming_data.Luminance_median(nbimg) < low_Luminance_bound
         remove_lumi = [remove_lumi, nbimg];
     end 
 end 

 disp([' - ',num2str(length(remove_lumi)),' people were removed because of luminousity'])
 
 %% Take out the people that are too Unusual
std_Unusual  = std(CFD_norming_data.Unusual)*2 ; % 2 std from the mean
mean_Unusual = mean(CFD_norming_data.Unusual) ;
low_Unusual_bound = mean_Unusual-std_Unusual;
up_Unusual_bound = mean_Unusual+std_Unusual ;

remove_unusual = []; 

 for nbimg = 1: size(CFD_norming_data,1)
     if CFD_norming_data.Unusual(nbimg) > up_Unusual_bound
         remove_unusual = [remove_unusual, nbimg];
     end 
 end 
 
 disp([' - ',num2str(length(remove_unusual)),' people were removed because of unusuality'])
 
%% Take out the people that look Afraid (even in neutral) 
std_Afraid  = std(CFD_norming_data.Afraid)*3 ; % 3 std from the mean
mean_Afraid = mean(CFD_norming_data.Afraid) ;
low_Afraid_bound = mean_Afraid-std_Afraid;
up_Afraid_bound = mean_Afraid+std_Afraid ;

remove_Afraid = []; 

 for nbimg = 1: size(CFD_norming_data,1)
     if CFD_norming_data.Afraid(nbimg) > up_Afraid_bound
         remove_Afraid = [remove_Afraid, nbimg];
     end 
 end 
 
 disp([' - ',num2str(length(remove_Afraid)),' people were removed because they looked afraid'])
 
 %% Take out the people that look Surprised (even in neutral) 

std_Surprised  = std(CFD_norming_data.Surprised)*3 ; % 3 std from the mean
mean_Surprised = mean(CFD_norming_data.Surprised) ;
low_Surprised_bound = mean_Surprised-std_Surprised;
up_Surprised_bound = mean_Surprised+std_Surprised ;

remove_Surprised = []; 

 for nbimg = 1: size(CFD_norming_data,1)
     if CFD_norming_data.Surprised(nbimg) > up_Surprised_bound 
         remove_Surprised = [remove_Surprised, nbimg];
     end 
 end 
 
 disp([' - ',num2str(length(remove_Surprised)),' people were removed because they looked surprised'])
 
 %% Total of People Removed 
 
 % remove = [remove_lumi,remove_unusual,remove_Afraid, remove_Surprised]; 
  
 % CFD_norming_data(remove,:) = [];
 
 disp(['Warning: ',num2str(size(CFD_norming_data_original,1)-size(CFD_norming_data,1)),' people were removed'])
 disp(['Warning: ',num2str(size(CFD_norming_data,1)),' out of ', num2str(size(CFD_norming_data_original,1)) ,' people remain'])
 
 %% Transfer the files from the downloaded folder to the experimental one 
 
% Creates new folders for the experimental images. 
initial_folder = 'CFD 2.0.3 Images';
dest_folder = '../exp_images';

if ~isfolder(dest_folder)
    mkdir ../exp_images 
end 

% Creat names of the files and copy them to dest folder
file_names = [];
for img = 1: size(CFD_norming_data,1)
    file_names = [file_names; fullfile(initial_folder,char(CFD_norming_data.Target(img)),'*.jpg')];
    copyfile (file_names(img,:),dest_folder) 
end 

disp(['End: the selected files were transfered correctly']);

