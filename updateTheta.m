function [newTheta] = updateTheta(oldTheta, trainingSet, yValues )
%Simultaneously updates values of theta
    global ALPHA
    
    [numFeatures, ~] = size(trainingSet);
    diffCostMatrix = zeros(numFeatures, 1);
    
    for i = 1:numFeatures
        diffCostMatrix(i) = diffCost(oldTheta, trainingSet, yValues, i);
    end
    
    newTheta = oldTheta - ALPHA * diffCostMatrix;
    
end

