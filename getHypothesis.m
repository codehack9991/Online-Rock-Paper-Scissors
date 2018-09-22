function [hypothesis] = getHypothesis(theta, features)
%Gives the hypothesis function value or the exression in terms of theta
%theta and features are column matrices
    exponent = theta .* features;
    exponent = sum(exponent);
    exponent = -1 * exponent(1);
    hypothesis = 1.0 / (1.0 + exp(exponent));
end

