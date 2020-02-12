%% Settings (for img size) 
settings_rsvp;

%% Load the initial matrices 
load('exp_images/WMN_img_rsvp.mat');
load('exp_images/WMF_img_rsvp.mat');
load('exp_images/WFN_img_rsvp.mat');
load('exp_images/WFF_img_rsvp.mat');

%% Transform them into scrambled images 
WMN_img_scramble = cell(1,size(WMN_img_rsvp,2));
for i = 1:size(WMN_img_rsvp,2)
    WMN_img_scramble{i} = createImageScramble(WMN_img_rsvp{i},nSection);
end 

WMF_img_scramble = cell(1,size(WMF_img_rsvp,2));
for j = 1:size(WMF_img_rsvp,2)
    WMF_img_scramble{j} = createImageScramble(WMF_img_rsvp{j},nSection); 
end 

WFN_img_scramble = cell(1,size(WFN_img_rsvp,2));
for k = 1:size(WFN_img_rsvp,2)
    WFN_img_scramble{k} = createImageScramble(WFN_img_rsvp{k},nSection); 
end 

WFF_img_scramble = cell(1,size(WFF_img_rsvp,2));
for l = 1:size(WFF_img_rsvp,2)
    WFF_img_scramble{l} = createImageScramble(WFF_img_rsvp{l},nSection); 
end 

%% Save the scrambled images 

save('exp_images/WMN_img_scramble.mat','WMN_img_scramble');
save('exp_images/WMF_img_scramble.mat','WMF_img_scramble');
save('exp_images/WFN_img_scramble.mat','WFN_img_scramble');
save('exp_images/WFF_img_scramble.mat','WFF_img_scramble');
