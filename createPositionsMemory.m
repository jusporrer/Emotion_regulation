function [posFF, posNF, posFM, posNM] = createPositionsMemory(positionMatrix, setSize,setSizeFF, setSizeNF, setSizeFM, setSizeNM, sizeImg)

%% Initialise the matrices 
positions = zeros(2,setSize);
imgPositions = zeros(setSize, 4);

%% Create the random matrices for position 
for i = 1:setSize
    % random indice between 1 and the number of columns in the matrix
    a = randi(numel(positionMatrix(1,:))); 
    
    % Store the randomly selected coordinates and Add jitters 
    positions(1,i) = positionMatrix(1,a) + ((positionMatrix(1,a)+20)-(positionMatrix(1,a)-20))*round(randn,1); 
    positions(2,i) = positionMatrix(2,a) + ((positionMatrix(2,a)+10)-(positionMatrix(2,a)-10))*round(randn,1);
        
    positions = ceil(positions);
     
    % Creates the positions in terms of 4 coordinates 
    posX =  [((positions(1,i) - sizeImg(2))/2) , ((positions(1,i) + sizeImg(2))/2)];
    posY = [((positions(2,i) - sizeImg(1))/2),  ((positions(2,i) + sizeImg(1))/2 )];
    
    imgPositions(i,:) = [posX(1), posY(1), posX(2), posY(2)];
    
    % Delete the already used pair of coordinates  
    positionMatrix(:,a) = []; 
    
end 

%% Store them for the 4 set of stimuli (can be optimised ?)  

posFF = imgPositions(1:setSizeFF, :);
posNF = imgPositions((setSizeFF + 1):(setSizeFF + setSizeNF), :);
posFM = imgPositions((setSizeFF + setSizeNF + 1) : (setSizeFF + setSizeNF + setSizeFM), :);
posNM = imgPositions((setSizeFF + setSizeNF + setSizeFM + 1):end, :);

if size(posNM,1) ~= setSizeNM
    disp('Error, problems with set Size'); 
end 

