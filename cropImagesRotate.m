function [snapBW, index] = cropImagesRotate(snapBW)
%crops the bw images to their bounding boxes
    global THETAS
    global NAME
%     filename = 'spock';
%     for i = 1:20
%         name=strcat(filename,' (', num2str(i),').jpg');
%             
%         snap = imread(name);
%CROP
%         snapBW = seperateHand(snap, RGBVALUES1);
%         snapBW = snap(:,:,1) > 200;
    snapBW = bwmorph(snapBW, 'dilate', 3);
    snapBW = bwmorph(snapBW, 'erode', 3);
    [snapLabel, n] = bwlabel(snapBW);

    labelNum = 1;
    maxArea = 0;
    index = 0;
    if n > 0
        stats = regionprops(snapLabel, 'BoundingBox', 'Area');
        
        for i = 1:n
            if stats(i).Area > maxArea
                labelNum = i;
                maxArea = stats(i).Area;
            end
        end
        
        BB = stats(labelNum).BoundingBox;
        snapBW = imcrop(snapBW, BB);
        snapBW = resize(snapBW, 30);
        features = snapBW(:);
        features = [1 ; features];
        hypValues = [0 0 0 0 0];
        for j = 1:5
            hypValues(j) = getHypothesis(THETAS(:, j), features);
        end

        [maxVal, index] = max(hypValues);
        finalMax = maxVal;
        finalIndex = index;
        for i = 1 : 20 : 360
            image = imrotate(snapBW, i);
            [imLabel, ~] = bwlabel(image);
            stats1 = regionprops(imLabel, 'BoundingBox', 'Area');
            BB1 = stats1(1).BoundingBox;
            image = imcrop(image, BB1);
            image = resize(image, 30);
            
            features = image(:);
            features = [1 ; features];
            hypValues = [0 0 0 0 0];
            for j = 1:5
                hypValues(j) = getHypothesis(THETAS(:, j), features);
            end
            
            [maxVal, index] = max(hypValues);
            if maxVal > finalMax
                finalMax = maxVal;
                finalIndex = index;
            end
        end
%         imtool(minImage);
%         imwrite(snapBW, name);

% %RESIZE
% %         snapBW = snap(:,:,1) > 200;
%         snapBW = resize(snapBW, 30);
%         imwrite(snapBW, name);

%PRINT
        disp('=============');
        disp(finalIndex);
        disp(NAME(finalIndex, :));
        disp(maxVal);
        
    end
end

