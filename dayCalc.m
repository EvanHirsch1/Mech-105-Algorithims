function dc = dayCalc(mo,da,leap)
% Day calculator function
%%   This function determines the amount of days elapsed from the start of 
% the year based on inputs of the user. Is used by entering months, days, 
% and whether or not a leap year is true.
%   Inputs
%       mo = 1:21;
%       da = 1: 31;
%       leap = 0 or 1;
%   Outputs
%       dc:
dc=0;
%% 
if leap == 1 && mo > 2  % Determines if year is a leap year
    feb=29;             % If yes, adds another day
else                    % If not, feb stays the same
    feb=28;
end
%% 
if mo == 1 % If month is january, there is no need to determine the days
    dc=da; % elapsed because the user inputs it. 
else
    A=[31,feb,31,30,31,30,31,31,30,31,30,31];   % An array of months by
    for i = 1: (mo-1)                           % days in them
        dc = dc + sum(A(i));                    % Sums the # of days
    end
    
end
dc=dc+da
end