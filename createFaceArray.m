function [faces] = createFaceArray(stimuli, setSizeFF, setSizeNF, setSizeFM, setSizeNM)

%% Initialise 
fearFem         = zeros(1,setSizeFF);
neutralFem      = zeros(1,setSizeNF);
fearMale        = zeros(1,setSizeFM);
neutralMale     = zeros(1,setSizeNM);

%% Create the random new faces 
faces           = {fearFem, neutralFem, fearMale, neutralMale}; 
setSizeImg      = {setSizeFF, setSizeNF, setSizeFM, setSizeNM};
stimuliImg      = {stimuli.fearFemMemory, stimuli.neutralFemMemory, ...
    stimuli.fearMaleMemory, stimuli.neutralMaleMemory}; 

for cat = 1:length(faces)
    for img = 1:setSizeImg{cat}
        a = randi(size(stimuliImg{cat},2));
        faces{cat}(img) = stimuliImg{cat}{a};
        stimuliImg{cat}(a) = [];
    end
end 
         

           

