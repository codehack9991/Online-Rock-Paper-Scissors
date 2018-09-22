function [ costFunction ] = getCostFunction(theta, trainingSet, yValues)
%Gives the cost function , i.e., summation of the costs for all the
%features
    [~, num] = size(trainingSet);
    
    costFunction = 0;
    for i = 1:num
        costFunction = costFunction + getCost(theta, trainingSet(:, i), yValues(i));
    end
end

