function [trainingSet] = getTrainingSet()
%
    numPics = 20;
    filename = 'no';
    trainingSet = [];
    
    for i = 1:numPics
        name = strcat(filename,' (', num2str(i),').jpg');
            
        snap = imread(name);
        snap = snap(:) > 200;
        snapColMatrix = snap(:);
        trainingSet(:, i) = snapColMatrix;
    end
    
    trainingSet = [ones(1,numPics); trainingSet];

end

