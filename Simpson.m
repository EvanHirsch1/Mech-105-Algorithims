function [I] = Simpson(x,y)
% Simpson's 1/3 rule numerical integration. Uses Trap rule if length(x) is
% even
%   Inputs:
%       x: Input an indepdant variable based vector with the range of what
%       you want to integrate, make sure they are evenly spaced and the
%       same length as the y vector
%       
%       y: Input the function values calculated based off of the x vector
%       input, make sure the vector is the same length as vector x.
%   Outputs
%       I:  The integral of the given function using the simpsons rule.


if size(x) ~= size(y) % Checks if the vectors are the same length
    error('Vectors x and y are not the same length');
end

f = rem(length(x), 2); % Calculates whether or not the vectors input have an odd or even number of elements
if f == 1
    disp('The vector input only needs the Simpsons 1/3 rule')
else
    disp('The vector input will need the trapezoidal rule to complete it')
end
    
u = diff(x);

if u ~= u(1,:) % Check to make sure that the vector input is evenly spaced.
    error('Not evenly spaced intervals for the x vector input')
end
%--------------------------------------------------------------------------
% Actual calculation of integral

lengthX = length(x);
a = min(x); % Sets bounds for integration
b = max(x); % Max(x) is upper bound, min is lower bound
C2 = 0; % Initializes variables for so the Simpsons rule can happen
C1 = 0;
C3 = 0;
C4 = 0;
for i = 1:2:(lengthX-1) % Summing up the values for the different sums within the simpsons rule before putting them into the actual equation
    C1 = (y(:,i)) + 2;
    C2 = C1 + C2;
end
for j = 2:2:(lengthX-2)
    C3 = (y(:,j));
    C4 =  C3 + C4;
end

trap1 = ((x(1,length(x)))- (x(1,length(x)-1)))*((y(1,length(x)-1)+(y(1,length(y)))))/2; % This is the trap rule for adding on the last interval left uncalculated by just Simpsons

if f == 1 % If the vector has an odd length, Simpsons rule is used
    I = (b-a).*((y(1,1)) + 4.*(C2) + 2.*(C4) + y(1,(lengthX)))/(3.*lengthX); % Simpsons rule
else
    I = ((b-a).*((y(1,1)) + 4.*(C2) + ((C4/2)) + y(1,(lengthX)))/(3.*(length(x)))) + trap1; % If the vector has an even length, Simpsons + trap is used
end
disp('The calculated integral is')
I

end

