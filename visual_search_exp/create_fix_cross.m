function [CoordsFix, lineWidthFix] = create_fix_cross()

    %% Fixation cross

    % Size of the Arms of the Fixation cross
    SizeFix = 40;

    % Coordinates in the centre
    xCoordsFix = [-SizeFix SizeFix 0 0];
    yCoordsFix = [0 0 -SizeFix SizeFix];
    CoordsFix = [xCoordsFix; yCoordsFix];

    % Line Width (Pixels)
    lineWidthFix = 6;
end 