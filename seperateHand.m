function [handBWImage] = seperateHand(handImage, rgbValues)
%Converts it into a black and white image

    handBWImage = handImage(:, :, 1) <= rgbValues(1) & handImage(:, :, 1) >= rgbValues(2) & handImage(:, :, 2) <= rgbValues(3) & handImage(:, :, 2) >= rgbValues(4) & handImage(:, :, 3) <= rgbValues(5) & handImage(:, :, 3) >= rgbValues(6);
    
    [rows, cols, ~] = size(handImage);
    imageArea = rows*cols;
    handArea = floor(imageArea/50);
    
    
%     handBWImage = bwmorph(handBWImage, 'majority', 2);
    
    handBWImage = bwmorph(handBWImage, 'dilate', 3);
    handBWImage = bwmorph(handBWImage, 'erode', 3);
    
    handBWImage = imfill(handBWImage, 'holes');
    
    handBWImage = bwmorph(handBWImage, 'erode', 3);
    handBWImage = bwmorph(handBWImage, 'dilate', 3);
    
    handBWImage = bwareaopen(handBWImage, handArea);
    
end

