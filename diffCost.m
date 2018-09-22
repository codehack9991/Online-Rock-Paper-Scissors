function [value] = diffCost(theta, trainingSet, yValue, featureNum)
%Gives the partial differentiation of cost funtion for all the features
%trainingSet is the row matrix of different features
%feature is the feature we are working with..
    [~, num] = size(trainingSet);
    
    value = 0;
    for i = 1:num
        feature = trainingSet(:, i);
        value = value + (getHypothesis(theta, feature) - yValue(i)) * feature(featureNum);
    end
    value = value / num;
end
