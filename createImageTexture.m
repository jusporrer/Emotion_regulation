function [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, ...
    sizeImg] = createImageTexture(WMN_img, WMF_img, WFN_img, WFF_img, window)

%% Img Size 
sizeImg = size(WMN_img{1}); % all img have the same dim 

%% Make the image into a texture
for i = 1:size(WMN_img,2)
    neutralMaleTexture{i} = Screen('MakeTexture', window, WMN_img{i});
end 

for i = 1:size(WMF_img,2)
    fearMaleTexture{i} = Screen('MakeTexture', window, WMF_img{i});
end 

for i = 1:size(WFN_img,2)
    neutralFemTexture{i} = Screen('MakeTexture', window, WFN_img{i});
end 

for i = 1:size(WFF_img,2)
    fearFemTexture{i} = Screen('MakeTexture', window, WFF_img{i});
end 

end


