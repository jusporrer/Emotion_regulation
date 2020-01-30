function [position1, position2, position3, position4, imagPositionsRand] = createPositions(positionMatrix, setSize, sizeImg, screenXpixels, screenYpixels)

%% Initialise the matrices 
positions = zeros(setSize,4);
imgPositions = zeros(setSize, 4); % 4 coordinates 
imagPositionsRand = zeros(1,setSize);

%% Create the random matrices for position 
for i = 1:setSize
    % random indice between 1 and the number of columns in the matrix
    a = randi(numel(positionMatrix(1,:))); 
    
    % Store the randomly selected coordinates with no jitters 
    %positions(:,i) = positionMatrix(:,a);  
    
    % Store the randomly selected coordinates and Add jitters 
    positions(1,i) = positionMatrix(1,a) + ((positionMatrix(1,a)+100)-(positionMatrix(1,a)-100))*rand; % our current cell size is 272*272
    positions(2,i) = positionMatrix(2,a)+ ((positionMatrix(2,a)+50)-(positionMatrix(2,a)-50))*rand;
    
    % Adds more jitter: round to integers
    positions = ceil(positions);
     
    % Creates the positions in terms of 4 coordinates 
    posX =  [((screenXpixels + positions(1,i) - sizeImg(1))/2) , ((screenXpixels + positions(1,i) + sizeImg(1))/2)];
    posY = [((screenYpixels + positions(2,i) - sizeImg(2))/2),  ((screenYpixels + positions(2,i) + sizeImg(2))/2 )];
    imgPositions(i,:) = [posX(1), posY(1), posX(2), posY(2)];
    
    % Delete the already used pair of coordinates  
    positionMatrix(:,a) = []; 
    
end 

%% Store them for the 4 set of stimuli (can be optimised ?)  
imgSetSize = setSize/4;

position1 = imgPositions(1:imgSetSize, :);
position2 = imgPositions(imgSetSize + 1:imgSetSize*2, :);
position3 = imgPositions(imgSetSize*2+1:imgSetSize*3, :);
position4 = imgPositions(imgSetSize*3 + 1:end, :);

%% Create the random orientation between 0° and 90°
for i = 1:setSize
    imagPositionsRand(i) = ceil(90*rand);
end 

end 