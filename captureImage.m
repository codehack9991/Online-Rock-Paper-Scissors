function [] = captureImage()
%
    global vid
    global rgbValues
    
    preview(vid);
    pause(3);
    
    snap = getsnapshot(vid);
    rgbValues = getMaxMinRGB(snap);
    
    filename = 'stone';
    i = 1;
    while 1
        snap = getsnapshot(vid);
        snapBW = seperateHand(snap, rgbValues);
        
        response = input('Press 1 to Save?');
        if(response == 1)
            name=strcat(filename,' (', num2str(i),').jpg');
            imwrite(snapBW, name);
            i = i + 1;
        end
    end
    
    
end
