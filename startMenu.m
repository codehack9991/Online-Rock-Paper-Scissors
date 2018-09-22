function [start] = startMenu(image2, message)
    global vid
    global CROPBB1
    global CROPBB2
    global WORKINGBB1
    global WORKINGBB2
    global RGBVALUES1
    global RGBVALUES2


    start = 0;
%     snap = getsnapshot(vid);
%     [rows, cols] = size(snap);
%     image2 = zeros(rows, cols/2);
    
    while start == 0
        for i = 1:100
            snap = getsnapshot(vid);

            snap1 = imcrop(snap, CROPBB1);
            snapHand1 = seperateHand(snap1, RGBVALUES1);
% 
%             snap2 = imcrop(snap, CROPBB2);
%             snapHand2 = seperateHand(snap2, RGBVALUES2);

            image1 = getFinalImage(snapHand1);
%             image2 = getFinalImage(snapHand2);
            
            image = [image1 image2];
            
%             image = image1;

            image = addBoxes(image, 1);
            image = showMessage(image,message,[5,5]);
            imshow(image);

            pause(0.01);
        end
        
        image1 = imcrop(image1, WORKINGBB1);
        [~, start] = yesOrNo(image1);
    end

end

