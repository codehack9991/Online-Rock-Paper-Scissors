function [ image ] = addBoxes(imageBW, num)
%adds 2 rectangles for the two players
    global WORKINGBB1
    global WORKINGBB2
    
    [rows, cols] = size(imageBW);
    image = zeros(rows, cols, 3);
    
    image(:,:,1) = imageBW * 255;
    image(:,:,2) = imageBW * 255;
    image(:,:,3) = imageBW * 255;
    
    image = insertShape(image, 'Rectangle', WORKINGBB1);
    if num == 2
        image = insertShape(image, 'Rectangle', WORKINGBB2);
    end
end

