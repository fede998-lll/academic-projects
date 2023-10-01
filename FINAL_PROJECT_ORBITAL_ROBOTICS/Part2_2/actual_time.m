function [minutes, seconds] = actual_time(t)
% ACTUAL_TIME converts a value in seconds to minutes:seconds format.
%
% Inputs:
%   t: A value in seconds that needs to be converted to minutes:seconds format.
%
% Outputs:
%   minutes: The number of minutes obtained from the conversion.
%   seconds: The remaining seconds after converting to minutes.

    % Calculate minutes by dividing the input value by 60 and rounding down
    minutes = floor(t/60);
    
    % Calculate seconds by taking the remainder of the input value divided by 60
    seconds = mod(t, 60);

end
