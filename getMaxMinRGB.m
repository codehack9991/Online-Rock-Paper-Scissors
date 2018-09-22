function [values] = getMaxMinRGB(image)
%Gives the max and min RGB values for the given colour
    colorRequired = imcrop(image);
    
    %Finding RGB-max and min respectively
    rmax = max(max(colorRequired(:,:,1))) + 35;
    rmin = min(min(colorRequired(:,:,1))) - 35;
    
    gmax = max(max(colorRequired(:,:,2))) + 35;
    gmin = min(min(colorRequired(:,:,2))) - 35;
    
    bmax = max(max(colorRequired(:,:,3))) + 35;
    bmin = min(min(colorRequired(:,:,3))) - 35;
    
    values = [rmax, rmin, gmax, gmin, bmax, bmin];
end



