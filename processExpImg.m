%% Settings (for img size) 
settings_rsvp;
settings_visual_search;

%% Retrieve the images

img_folder = 'exp_images';
img_files = dir([img_folder '/*.jpg']);
nb_img = size(img_files,1);

WMN = 0; WMF = 0; WFN = 0; WFF = 0; 
WMN_files = []; WMF_files = []; WFN_files = []; WFF_files = [];
WMN_img = {}; WMF_img_rsvp = {}; WFN_img_rsvp = {}; WFF_img_rsvp = {}; 
BMN = 0; BMF = 0; BFN = 0; BFF = 0; 
BMN_files = []; BMF_files = []; BFN_files = []; BFF_files = []; 
BMN_img = {}; BMF_img = {}; BFN_img = {}; BFF_img = {}; 
LMN=0; LMF=0; LFN=0; LFF=0; 
AMN=0; AMF=0; AFN=0; AFF=0;

for index_img = 1:nb_img
    if +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        WMN = WMN+1;
        WMN_files = [WMN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        WMF = WMF+1;
        WMF_files = [WMF_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        WFN = WFN+1;
        WFN_files = [WFN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'F') == 1 && ...
            +(img_files(index_img).name(16) == 'F') ==  1
        WFF = WFF+1;
        WFF_files = [WFF_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'B') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        BMN = BMN+1;
        BMN_files = [BMN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'B') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        BMF = BMF+1;
        BMF_files = [BMF_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'B') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        BFN = BFN+1;
        BFN_files = [BFN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'B') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        BFF = BFF+1;
        BFF_files = [BFF_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'L') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        LMN = LMN+1;
    elseif +(img_files(index_img).name(5) == 'L') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        LMF = LMF+1;
    elseif +(img_files(index_img).name(5) == 'L') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        LFN = LFN+1;
    elseif +(img_files(index_img).name(5) == 'L') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        LFF = LFF+1;
    elseif +(img_files(index_img).name(5) == 'A') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        AMN = AMN+1;
    elseif +(img_files(index_img).name(5) == 'A') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        AMF = AMF+1;
    elseif +(img_files(index_img).name(5) == 'A') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        AFN = AFN+1;
    elseif +(img_files(index_img).name(5) == 'A') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        AFF = AFF+1;
    end 
end 
  
%% Display the numbers of images in each condition 
disp(['WMN: There are ',num2str(WMN), ' neutral white male(s)']);  
disp(['WMF: There are ',num2str(WMF), ' fearful white male(s)']);
disp(['WFN: There are ',num2str(WFN), ' neutral white female(s)']);  
disp(['WFF: There are ',num2str(WFF), ' fearful white female(s)']);

disp(['BMN: There are ',num2str(BMN), ' neutral black male(s)']);  
disp(['BMF: There are ',num2str(BMF), ' fearful black male(s)']);
disp(['BFN: There are ',num2str(BFN), ' neutral black female(s)']);  
disp(['BFF: There are ',num2str(BFF), ' fearful black female(s)']);

disp(['LMN: There are ',num2str(LMN), ' neutral latino male(s)']);  
disp(['LMF: There are ',num2str(LMF), ' fearful latino male(s)']);
disp(['LFN: There are ',num2str(LFN), ' neutral latino female(s)']);  
disp(['LFF: There are ',num2str(LFF), ' fearful latino female(s)']);

disp(['AMN: There are ',num2str(AMN), ' neutral asian male(s)']);  
disp(['AMF: There are ',num2str(AMF), ' fearful asian male(s)']);
disp(['AFN: There are ',num2str(AFN), ' neutral asian female(s)']);  
disp(['AFF: There are ',num2str(AFF), ' fearful asian female(s)']);

nb_fear = WMF + WFF + BMF + BFF + LMF + LFF + AMF + AFF; 
disp(['There are ',num2str(nb_fear), ' fearful faces']);
nb_neutral = WMN + WFN + BMN + BFN + LMN + LFN + AMN + AFN;   
disp(['There are ',num2str(nb_neutral), ' neutral faces']);  

nb_male = WMN + WMF + BMN + BMF + LMN + LMF + AMN + AMF; 
disp(['There are ',num2str(nb_male), ' males']);  
nb_female = WFN + WFF + BFN + BFF + LFN + LFF + AFN + AFF; 
disp(['There are ',num2str(nb_female), ' females']);

nb_neutral_male = WMN + BMN + LMN + AMN; 
disp(['There are ',num2str(nb_neutral_male), ' neutral males']);  
nb_fear_male = WMF + BMF + LMF + AMF;
disp(['There are ',num2str(nb_fear_male), ' fearful males']);  

nb_neutral_female = WFN + BFN + LFN + AFN; 
disp(['There are ',num2str(nb_neutral_female), ' neutral females']);
nb_fear_female = WFF + BFF + LFF + AFF;
disp(['There are ',num2str(nb_fear_female), ' fearful females']);

%% Read and resize images

size_img = size(imread([img_folder '/' WMN_files(1,:)]));   % all files have the same dim 
rect_crop = [(size_img(2)-1500)/2 0 1500 1500]; 

WMN_img = cell(1,size(WMN_files,1)); WMN_img_rsvp = cell(1,size(WMN_files,1)); WMN_img_vs = cell(1,size(WMN_files,1));
for i = 1:size(WMN_files,1)
    WMN_img{i} = imcrop((imread([img_folder '/' WMN_files(i,:)])),rect_crop);
    WMN_img_rsvp{i} = imresize(WMN_img{i}, size_img_rsvp/size_img(1));
    WMN_img_vs{i} = imresize(WMN_img{i}, size_img_vs/size_img(1));
end 

WMF_img = cell(1,size(WMF_files,1)); WMF_img_rsvp = cell(1,size(WMF_files,1)); WMF_img_vs = cell(1,size(WMF_files,1));
for i = 1:size(WMF_files,1)
    WMF_img{i} = imcrop((imread([img_folder '/' WMF_files(i,:)])),rect_crop); 
    WMF_img_rsvp{i} = imresize(WMF_img{i}, size_img_rsvp/size_img(1));
    WMF_img_vs{i} = imresize(WMF_img{i}, size_img_vs/size_img(1));
end 

WFN_img = cell(1,size(WFN_files,1)); WFN_img_rsvp = cell(1,size(WFN_files,1)); WFN_img_vs = cell(1,size(WFN_files,1));
for i = 1:size(WFN_files,1)
    WFN_img{i} = imcrop((imread([img_folder '/' WFN_files(i,:)])), rect_crop);   
    WFN_img_rsvp{i} = imresize(WFN_img{i}, size_img_rsvp/size_img(1));
    WFN_img_vs{i} = imresize(WFN_img{i}, size_img_vs/size_img(1));
end 

WFF_img = cell(1,size(WFF_files,1)); WFF_img_rsvp = cell(1,size(WFF_files,1)); WFF_img_vs = cell(1,size(WFF_files,1));
for i = 1:size(WFF_files,1)
    WFF_img{i} = imcrop((imread([img_folder '/' WFF_files(i,:)])), rect_crop); 
    WFF_img_rsvp{i} = imresize(WFF_img{i}, size_img_rsvp/size_img(1));
    WFF_img_vs{i} = imresize(WFF_img{i}, size_img_vs/size_img(1));
end 

%% Save into mat file to make the loading easier 
save('exp_images/WMN_img_rsvp.mat','WMN_img_rsvp');
save('exp_images/WMF_img_rsvp.mat','WMF_img_rsvp');
save('exp_images/WFN_img_rsvp.mat','WFN_img_rsvp');
save('exp_images/WFF_img_rsvp.mat','WFF_img_rsvp');

save('exp_images/WMN_img_vs.mat','WMN_img_vs');
save('exp_images/WMF_img_vs.mat','WMF_img_vs');
save('exp_images/WFN_img_vs.mat','WFN_img_vs');
save('exp_images/WFF_img_vs.mat','WFF_img_vs');

