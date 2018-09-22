function [] = cropImages()
%crops the bw images to their bounding boxes
    global RGB
    filename = 'yes';
    for i = 1:20
        name=strcat(filename,' (', num2str(i),').jpg');
            
        snap = imread(name);
%CROP
%         snapBW = seperateHand(snap, RGB);
        snapBW = snap(:,:,1) > 200;
        snapBW = bwmorph(snapBW, 'dilate', 3);
        snapBW = bwmorph(snapBW, 'erode', 3);
        [snapLabel, ~] = bwlabel(snapBW);
        
        stats = regionprops(snapLabel, 'BoundingBox');
        BB = stats(1).BoundingBox;
        
        snapBW = imcrop(snapBW, BB);
%         imwrite(snapBW, name);

% %RESIZE
%         snapBW = snap(:,:,1) > 200;
        snapBW = resize(snapBW, 30);
        imwrite(snapBW, name);
    end

end

