%% Settings (for img size) 
settings_rsvp;
settings_visual_search;

%% Retrieve the images

img_folder = '../exp_images';
img_files = dir([img_folder '/*.jpg']);
nb_img = size(img_files,1);

WMN_files = []; WMF_files = []; WFN_files = []; WFF_files = [];

for index_img = 1:nb_img
    if +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        WMN_files = [WMN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'M') == 1 &&...
            +(img_files(index_img).name(16) == 'F') ==  1
        WMF_files = [WMF_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'F') == 1 &&...
            +(img_files(index_img).name(16) == 'N') ==  1
        WFN_files = [WFN_files; img_files(index_img).name];
        
    elseif +(img_files(index_img).name(5) == 'W') == 1 && +(img_files(index_img).name(6) == 'F') == 1 && ...
            +(img_files(index_img).name(16) == 'F') ==  1
        WFF_files = [WFF_files; img_files(index_img).name];
    end 
end 

WMN = size(WMN_files,1);
WMF = size(WMF_files,1);
WFN = size(WFN_files,1);
WFF = size(WFF_files,1);

%% Display the numbers of images in each condition 
disp(['WMN: There are ',num2str(WMN), ' neutral male(s)']);  
disp(['WMF: There are ',num2str(WMF), ' fearful male(s)']);
disp(['WFN: There are ',num2str(WFN), ' neutral female(s)']);  
disp(['WFF: There are ',num2str(WFF), ' fearful female(s)']);

nb_fear = WMF + WFF; 
disp(['There are ',num2str(nb_fear), ' fearful faces']);
nb_neutral = WMN + WFN;   
disp(['There are ',num2str(nb_neutral), ' neutral faces']);  

nb_male = WMN + WMF; 
disp(['There are ',num2str(nb_male), ' males']);  
nb_female = WFN + WFF; 
disp(['There are ',num2str(nb_female), ' females']);

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

