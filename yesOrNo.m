function [snapBW, index] = yesOrNo(snapBW)
%crops the bw images to their bounding boxes
    global YESNOTHETA
    global COMMAND
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
%         
%         [rows, cols] = size(snapBW);
%         minArea = rows*cols;
%         minImage = snapBW;
%         for i = 1 : 5 : 180
%             image = imrotate(snapBW, i);
%             [imLabel, ~] = bwlabel(image);
%             stats1 = regionprops(imLabel, 'BoundingBox', 'Area');
%             BB1 = stats1(1).BoundingBox;
%             rows = BB1(3);
%             cols = BB1(4);
%             area = rows*cols;
%             
%             if area < minArea
%                 minImage = image;
%                 minArea = area;
%             end            
%             
%         end
%         snapBW = minImage;
%         imtool(minImage);
%         imwrite(snapBW, name);

% %RESIZE
%         snapBW = snap(:,:,1) > 200;
        snapBW = resize(snapBW, 30);
%         imwrite(snapBW, name);

%PRINT
        features = snapBW(:);
        features = [1 ; features];
        hypValues = [0 0 0 0 0];
        for i = 1:2
            hypValues(i) = getHypothesis(YESNOTHETA(:, i), features);
        end
        disp('=============');
        [maxVal, index] = max(hypValues);
        disp(index);
        disp(COMMAND(index, :));
        disp(maxVal);
        
    end
end

