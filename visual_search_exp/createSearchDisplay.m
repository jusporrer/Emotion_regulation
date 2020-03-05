function img = createSearchDisplay(WMN_img_vs, WMF_img_vs, WFN_img_vs, WFF_img_vs, setSize,...
posFF,posNF, posFM, posNM, screenXpixels,screenYpixels)

img = ones(screenYpixels,screenXpixels,3); 

% Select setSize/4 new faces
for nb_img = 1: 4 %setSize/4
    fearFem{nb_img} = WFF_img_vs{randi([1 size(WFF_img_vs,2)])};
    neutralFem{nb_img} = WFN_img_vs{randi([1 size(WFN_img_vs,2)])};
    fearMale{nb_img} = WMF_img_vs{randi([1 size(WMF_img_vs,2)])};
    neutralMale{nb_img} = WMN_img_vs{randi([1 size(WMN_img_vs,2)])};
end

% Paste search items on the background

for i = 1: setSize/4
    display(posFF)
    img(floor(posFF(i,2)+1:posFF(i,4)),floor(posFF(i,1)+1:posFF(i,3)),:) = 255-fearFem{i};
    img(floor(posNF(i,2)+1:posNF(i,4)),floor(posNF(i,1)+1:posNF(i,3)),:) = 255-neutralFem{i};
    img(floor(posFM(i,2)+1:posFM(i,4)),floor(posFM(i,1)+1:posFM(i,3)),:) = 255-fearMale{i};
    img(floor(posNM(i,2)+1:posNM(i,4)),floor(posNM(i,1)+1:posNM(i,3)),:) = 255-neutralMale{i};
end 
img = ones(screenYpixels,screenXpixels,3);
end 