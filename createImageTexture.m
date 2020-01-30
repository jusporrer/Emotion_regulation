function [fearFemTexture,fearMaleTexture, neutralFemTexture, neutralMaleTexture, sizeImg] = createImageTexture(window)

%% Retrieve the images

% Name file
folder = 'images';

% Name image
nameFearFem = 'FearFem.png';
nameFearMale = 'FearMale.png';
nameNeutralFem = 'NeutralFem.png';
nameNeutralMale = 'NeutralMale.png';

% Read image
fearFem = imread([folder '/' nameFearFem]);
fearMale = imread([folder '/' nameFearMale]);
neutralFem = imread([folder '/' nameNeutralFem]);
neutralMale = imread([folder '/' nameNeutralMale]);

%% Resize it
sizeImg = size(fearFem);
% 
% %  Maintain the aspect ratio of the image when we draw it different sizes
% aspectRatio = s2/s1;
% 
% heightScalers = 
% imageHeights = screenYpixels .* heightScalers;
% imageWidths = imageHeights .* aspectRatio;

% Maybe write a Test to check if the size is not too big to fit on the position
% if s1 > screenYpixels || s2 > screenYpixels
%     disp('ERROR! Image is too big to fit on the screen');
%     sca;
%     return;
% end

%% Make the image into a texture

fearFemTexture = Screen('MakeTexture', window, fearFem);
fearMaleTexture = Screen('MakeTexture', window, fearMale);  
neutralFemTexture = Screen('MakeTexture', window, neutralFem);  
neutralMaleTexture = Screen('MakeTexture', window, neutralMale);  

end


