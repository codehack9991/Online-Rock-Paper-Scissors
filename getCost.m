function [ cost ] = getCost(theta, feature, yValue)
%Gives the cost of a particular theta and feature and the yValue of the
%partiular feature
%theta and features are column matrices

    cost = - (yValue) * log(getHypothesis(theta, feature)) - (1 - yValue) * log(1 - getHypothesis(theta, feature));

end

