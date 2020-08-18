function dataJulianaFull = importfile(filename, startRow, endRow)
%IMPORTFILE1 Import numeric data from a text file as a matrix.
%   DATAJULIANAFULL = IMPORTFILE1(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   DATAJULIANAFULL = IMPORTFILE1(FILENAME, STARTROW, ENDROW) Reads data
%   from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   dataJulianaFull = importfile1('dataJulianaFull.csv', 1, 1265);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2020/05/05 15:31:58

%% Initialize variables.
delimiter = ';';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

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

for col=[1,3,4,6,7,8,9,10,11,12,13,14,16,17,19]
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

% Convert the contents of columns with dates to MATLAB datetimes using the
% specified date format.
try
    dates{20} = datetime(dataArray{20}, 'Format', 'MM/dd/yyyy HH:mm', 'InputFormat', 'MM/dd/yyyy HH:mm');
catch
    try
        % Handle dates surrounded by quotes
        dataArray{20} = cellfun(@(x) x(2:end-1), dataArray{20}, 'UniformOutput', false);
        dates{20} = datetime(dataArray{20}, 'Format', 'MM/dd/yyyy HH:mm', 'InputFormat', 'MM/dd/yyyy HH:mm');
    catch
        dates{20} = repmat(datetime([NaN NaN NaN]), size(dataArray{20}));
    end
end

dates = dates(:,20);

%% Split data into numeric and string columns.
rawNumericColumns = raw(:, [1,3,4,6,7,8,9,10,11,12,13,14,16,17,19]);
rawStringColumns = string(raw(:, [2,5,15,18]));


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Make sure any text containing <undefined> is properly converted to an <undefined> categorical
for catIdx = [1,2,3]
    idx = (rawStringColumns(:, catIdx) == "<undefined>");
    rawStringColumns(idx, catIdx) = "";
end

%% Create output variable
dataJulianaFull = table;
dataJulianaFull.rt = cell2mat(rawNumericColumns(:, 1));
dataJulianaFull.stimulus = categorical(rawStringColumns(:, 1));
dataJulianaFull.responses = cell2mat(rawNumericColumns(:, 2));
dataJulianaFull.key_press = cell2mat(rawNumericColumns(:, 3));
dataJulianaFull.test_part = categorical(rawStringColumns(:, 2));
dataJulianaFull.blockNb = cell2mat(rawNumericColumns(:, 4));
dataJulianaFull.trialNb = cell2mat(rawNumericColumns(:, 5));
dataJulianaFull.condiEmoBlock = cell2mat(rawNumericColumns(:, 6));
dataJulianaFull.condiEmoTrial = cell2mat(rawNumericColumns(:, 7));
dataJulianaFull.condiRwd = cell2mat(rawNumericColumns(:, 8));
dataJulianaFull.posCritDist = cell2mat(rawNumericColumns(:, 9));
dataJulianaFull.distractor = cell2mat(rawNumericColumns(:, 10));
dataJulianaFull.posTarget = cell2mat(rawNumericColumns(:, 11));
dataJulianaFull.target = cell2mat(rawNumericColumns(:, 12));
dataJulianaFull.trial_type = categorical(rawStringColumns(:, 3));
dataJulianaFull.trial_index = cell2mat(rawNumericColumns(:, 13));
dataJulianaFull.time_elapsed = cell2mat(rawNumericColumns(:, 14));
dataJulianaFull.internal_node_id = rawStringColumns(:, 4);
dataJulianaFull.subject_id = cell2mat(rawNumericColumns(:, 15));
dataJulianaFull.date = dates{:, 1};

% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% dataJulianaFull.date=datenum(dataJulianaFull.date);
