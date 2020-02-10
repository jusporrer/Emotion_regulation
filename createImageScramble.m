function [img_scramble] = createImageScramble(img, nSection, window)

%% Create Matrix
[nRow, nCol, nDim] = size(img);

rowSpace = floor(linspace( 1, nRow , nSection+1 )); % make mosaic indicies
colSpace  = floor(linspace( 1, nCol , nSection+1 ));

min_possibleSize = [ max(diff(rowSpace)), max(diff(colSpace)) ];

mosaics = cell([1,(nSection)^2]); % section images into {N x N}, and temporally store into the cell 'mosaics'
permuteParameter = randperm( (nSection)^2 ); % make random indexing parameter

%% Split image into cells (with random order)
mosaic_nAppend = 0;
for rowIdx = 1:length(rowSpace)-1
    for colIdx = 1:length(rowSpace)-1
        mosaic_nAppend = mosaic_nAppend+1;
        mosaics{1,permuteParameter(mosaic_nAppend)} = imresize(img(...
            rowSpace(rowIdx):rowSpace(rowIdx+1)-1,...
            colSpace(colIdx):colSpace(colIdx+1)-1, :), min_possibleSize);
    end
end

%% Integrate by rows
cat_row = cell( [1, nSection] );
cat_row_nAppend = 0;
for cellIdx = 1:length(mosaics)
    if mod(cellIdx, nSection) == 1
        cat_row_nAppend = cat_row_nAppend+1;
    end
    cat_row{1, cat_row_nAppend} = cat(1,cat_row{1, cat_row_nAppend},...
        mosaics{1,cellIdx});
end

%% Integrate by columns
cat_col = [];
for cellIdx = 1:length(cat_row)
    cat_col = cat(2, cat_col, cat_row{1,cellIdx});
end

%% Integrate by color dimension
img_scramble = [];
for dimIdx = 1:nDim
    img_scramble = cat(3, img_scramble, imresize(squeeze(cat_col(:,:,dimIdx)), [nRow, nCol]));
end

%% Make the image into a texture
img_scramble = Screen('MakeTexture', window, img_scramble);

