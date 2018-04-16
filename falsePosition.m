function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
% falsePosition Determines the root of a function using the false position
% method
%   Inputs:
%       func = The function you want to evaluate
%       xl = The lower guess
%       xu = The upper guess
%       es = The desired relative error (default to 0.0001)
%       maxiter = The number of iterations desired (default to 200)
%   Outputs:
%       root = The estimated root location
%       fx = The function evaluated at root location
%       ea = The approximate relative error (percent)
%       iter = The number of iterations performed

%--------------------------------------------------------------------------
%% This section represents the the nargin determination

tic         

if nargin < 3
    error('Enter at least three inputs')    % Checks if nargin is less than 3
elseif nargin < 4   % Checks if user input less than  
    maxiter = 200;  % Sets defaults for maxiter and desired error  
    es = 0.0001;    % 200 for maxiter and es to 0.0001
elseif nargin < 5   % Checks if user input 4
    maxiter = 200;  % Sets default maxiter to 200
elseif nargin > 5
    error('Can only enter up to 5 inputs') % Checks if user input greater than 5 inputs
end

%%
if func(xl)*func(xu) > 0    % Checks if brackets input have a root
    error('No sign change occurs between the brackets given')
elseif func(xl) == 0    % Checks if lower bound is a root
    error('Lower bound is a root')
elseif func(xu) == 0    % Checks if upper bound is a root
    error('Upper bound is a root')
end

%%
iter = 0;   % Sets starting iterations to 0 making error 100
prvsroot = 0;   % Sets previous root to 0 so starting error is still 100

while iter <= maxiter % While the iterations is less than the maxiter (defaults 200)
    root = xu - ((func(xu)*(xl-xu))/(func(xl)-func(xu))); % False position equation
    fx = func(root);    % Evaulates the function input for the root
    iter = iter+1;      % Counter for iterations
    if root ~= 0
        ea = abs((root-prvsroot)/root)*100;     % Calculates error for root
        prvsroot = root;    % Sets root to previous root so error can be calculated
    end
    if func(root)*func(xl) < 0
        xu = root;  % 
    elseif func(root)*func(xu) < 0
        xl = root;
    else
        ea = 0;
    end
    if ea < es || iter >= maxiter   % if error is less than input error, or the iterations are greater than max iterations, stops the code 
        break                                           
    end
end

fprintf('Root approximation: %d\n',root)
fprintf('# of iterations used: %d\n', iter)
fprintf('Calculated error: %d\n',ea)

toc

end



