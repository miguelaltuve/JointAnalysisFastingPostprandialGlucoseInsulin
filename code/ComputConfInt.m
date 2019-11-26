function output = ComputConfInt(variable)
%COMPUTCONFINT compute the 95% confidence interval of the data
%   OUTPUT = COMPUTCONFINT(VARIABLE) computes the 95% confidence interval
%   of the data contained in VARIABLE, and returns an array OUTPUT
%   representing the lower and upper bound of the CI.
%
%   VARIABLE is a cell array of the variables to compute the CI
%
%   Confidence intervals is computed only if a variable has at least ten
%   samples
%
%   Author: Miguel Altuve
%   Email: miguelaltuve@gmail.com
%   Date: December, 2018

N = length(variable); % number of variables
output = zeros(2,N); % Array of 2xN zeros

for i=1:N
    % variable{i} has at least 10 samples?
    if length(variable{i})>=10
        % Fit a Normal probability distribution to data
        pd = fitdist(variable{i},'Normal');
        % Confidence intervals for probability distribution parameters
        ci = paramci(pd);
        output(:,i) = ci(:,1);
    end
end

end