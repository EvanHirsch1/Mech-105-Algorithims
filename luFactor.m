function [L,U,P] = luFactor(A)
% LU factorization with partial pivoting
%   Inputs:
%       Matrix of coefficients A
%   Outputs:
%       L: A matrix composed with ones on the primary diagonal, and the
%           lower triangular matrix is used to store the values used to  
%           eliminate the U matrix
%       U: The Gauss elimanated matrix 
%       P: A matrix for keeping track of the row switches

%% Error Checking
[l,m] = size(A);
if l~=m
    error('Matrix needs to be a square Matrix, make sure dimensions are the same')
end

%% Initializing Variables
[n,n] = size(A); % Sets n = size # of rows and columns, don't need two 
% variables because matrix is supposed to be a square
L = eye(n); % Sets L = an identity matrix with the length of n 
P = L; % Sets P = L Because they are the same initially
U = A; % Sets U = A Because they are the same initially

for k = 1:n
    [pivot m] = max(abs(U(k:n,k))); % Finds the value with the greatest abs
    % in the U matrix and pivots around that row
    m = m + k - 1; % Sets m = the row that is being operated on  
    if m ~= k 
        % Switch rows m and k in U
        temporary = U(k,:); % Sets temporary array = the elements of the bigger column
        U(k,:) = U(m,:); % Switches the value of the row that you want to pivot to the top with the old row
        U(m,:) = temporary; % Sets the row with the higher magnitude on top so Gauss elim. can happen  
        % Switch rows m and k in P
        temporary = P(k,:); % Does the same thing as above but with the P matrix accounting for the switching rows
        P(k,:) = P(m,:);
        P(m,:) = temporary;
        if k >= 2 % Does the same as above but with the L matrix as long as k >= 2
            temporary = L(k,1:k-1);
            L(k,1:k - 1) = L(m,1:k - 1);
            L(m,1:k - 1) = temporary;
        end
    end
    for j = k + 1:n     % This is where Gauss Elim is performed.
        L(j,k) = U(j,k) / U(k,k);   % L factor is determined after pivoting
        U(j,:) = U(j,:) - L(j,k) * U(k,:);  % U is determined element by element using the formula for elimination
    end
end

disp('Check to make sure P*A and L*U are equal to prove that luFactor worked')
disp('P*A')
P*A
disp('L*U')
L*U
disp('Upper triangular matrix')
U
disp('Lower triangular matrix')
L
disp('Pivot elements')
P