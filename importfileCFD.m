function CFDnormingdataexperience = importfileCFD(filename, startRow, endRow)
% IMPORTFILE Import numeric data from a text file as a matrix.

% CFD_norming_data = importfileCFD('CFD_norming_data_experience.csv', 2, 598);

%% Initialize variables.
delimiter = ';';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r','n','UTF-8');
% Skip the BOM (Byte Order Mark).
fseek(fileID, 3, 'bof');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Split data into numeric and string columns.
rawNumericColumns = raw(:, [4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61]);
rawStringColumns = string(raw(:, [1,2,3,17]));


%% Make sure any text containing <undefined> is properly converted to an <undefined> categorical
for catIdx = [1,2,3]
    idx = (rawStringColumns(:, catIdx) == "<undefined>");
    rawStringColumns(idx, catIdx) = "";
end

%% Create output variable
CFDnormingdataexperience = table;
CFDnormingdataexperience.Target = categorical(rawStringColumns(:, 1));
CFDnormingdataexperience.Race = categorical(rawStringColumns(:, 2));
CFDnormingdataexperience.Gender = categorical(rawStringColumns(:, 3));
CFDnormingdataexperience.Age = cell2mat(rawNumericColumns(:, 1));
CFDnormingdataexperience.NumberofRaters = cell2mat(rawNumericColumns(:, 2));
CFDnormingdataexperience.Afraid = cell2mat(rawNumericColumns(:, 3));
CFDnormingdataexperience.Angry = cell2mat(rawNumericColumns(:, 4));
CFDnormingdataexperience.Attractive = cell2mat(rawNumericColumns(:, 5));
CFDnormingdataexperience.Babyface = cell2mat(rawNumericColumns(:, 6));
CFDnormingdataexperience.Disgusted = cell2mat(rawNumericColumns(:, 7));
CFDnormingdataexperience.Dominant = cell2mat(rawNumericColumns(:, 8));
CFDnormingdataexperience.Feminine = cell2mat(rawNumericColumns(:, 9));
CFDnormingdataexperience.Happy = cell2mat(rawNumericColumns(:, 10));
CFDnormingdataexperience.Masculine = cell2mat(rawNumericColumns(:, 11));
CFDnormingdataexperience.Prototypic = cell2mat(rawNumericColumns(:, 12));
CFDnormingdataexperience.Sad = cell2mat(rawNumericColumns(:, 13));
CFDnormingdataexperience.Suitability = categorical(rawStringColumns(:, 4));
CFDnormingdataexperience.Surprised = cell2mat(rawNumericColumns(:, 14));
CFDnormingdataexperience.Threatening = cell2mat(rawNumericColumns(:, 15));
CFDnormingdataexperience.Trustworthy = cell2mat(rawNumericColumns(:, 16));
CFDnormingdataexperience.Unusual = cell2mat(rawNumericColumns(:, 17));
CFDnormingdataexperience.Luminance_median = cell2mat(rawNumericColumns(:, 18));
CFDnormingdataexperience.Nose_Width = cell2mat(rawNumericColumns(:, 19));
CFDnormingdataexperience.Nose_Length = cell2mat(rawNumericColumns(:, 20));
CFDnormingdataexperience.Lip_Thickness = cell2mat(rawNumericColumns(:, 21));
CFDnormingdataexperience.Face_Length = cell2mat(rawNumericColumns(:, 22));
CFDnormingdataexperience.R_Eye_H = cell2mat(rawNumericColumns(:, 23));
CFDnormingdataexperience.L_Eye_H = cell2mat(rawNumericColumns(:, 24));
CFDnormingdataexperience.Avg_Eye_Height = cell2mat(rawNumericColumns(:, 25));
CFDnormingdataexperience.R_Eye_W = cell2mat(rawNumericColumns(:, 26));
CFDnormingdataexperience.L_Eye_W = cell2mat(rawNumericColumns(:, 27));
CFDnormingdataexperience.Avg_Eye_Width = cell2mat(rawNumericColumns(:, 28));
CFDnormingdataexperience.Face_Width_Cheeks = cell2mat(rawNumericColumns(:, 29));
CFDnormingdataexperience.Face_Width_Mouth = cell2mat(rawNumericColumns(:, 30));
CFDnormingdataexperience.Forehead = cell2mat(rawNumericColumns(:, 31));
CFDnormingdataexperience.Pupil_Top_R = cell2mat(rawNumericColumns(:, 32));
CFDnormingdataexperience.Pupil_Top_L = cell2mat(rawNumericColumns(:, 33));
CFDnormingdataexperience.Asymmetry_pupil_top = cell2mat(rawNumericColumns(:, 34));
CFDnormingdataexperience.Pupil_Lip_R = cell2mat(rawNumericColumns(:, 35));
CFDnormingdataexperience.Pupil_Lip_L = cell2mat(rawNumericColumns(:, 36));
CFDnormingdataexperience.Asymmetry_pupil_lip = cell2mat(rawNumericColumns(:, 37));
CFDnormingdataexperience.BottomLip_Chin = cell2mat(rawNumericColumns(:, 38));
CFDnormingdataexperience.Midcheek_Chin_R = cell2mat(rawNumericColumns(:, 39));
CFDnormingdataexperience.Midcheek_Chin_L = cell2mat(rawNumericColumns(:, 40));
CFDnormingdataexperience.Cheeks_avg = cell2mat(rawNumericColumns(:, 41));
CFDnormingdataexperience.Midbrow_Hairline_R = cell2mat(rawNumericColumns(:, 42));
CFDnormingdataexperience.Midbrow_Hairline_L = cell2mat(rawNumericColumns(:, 43));
CFDnormingdataexperience.Faceshape = cell2mat(rawNumericColumns(:, 44));
CFDnormingdataexperience.Heartshapeness = cell2mat(rawNumericColumns(:, 45));
CFDnormingdataexperience.Noseshape = cell2mat(rawNumericColumns(:, 46));
CFDnormingdataexperience.LipFullness = cell2mat(rawNumericColumns(:, 47));
CFDnormingdataexperience.EyeShape = cell2mat(rawNumericColumns(:, 48));
CFDnormingdataexperience.EyeSize = cell2mat(rawNumericColumns(:, 49));
CFDnormingdataexperience.UpperHeadLength = cell2mat(rawNumericColumns(:, 50));
CFDnormingdataexperience.MidfaceLength = cell2mat(rawNumericColumns(:, 51));
CFDnormingdataexperience.ChinLength = cell2mat(rawNumericColumns(:, 52));
CFDnormingdataexperience.ForeheadHeight = cell2mat(rawNumericColumns(:, 53));
CFDnormingdataexperience.CheekboneHeight = cell2mat(rawNumericColumns(:, 54));
CFDnormingdataexperience.CheekboneProminence = cell2mat(rawNumericColumns(:, 55));
CFDnormingdataexperience.FaceRoundness = cell2mat(rawNumericColumns(:, 56));
CFDnormingdataexperience.fWHR = cell2mat(rawNumericColumns(:, 57));

