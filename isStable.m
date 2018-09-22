function [Stable] = isStable(image1,image2)
   [~,n1] = bwlabel(image2);
   
    image = xor(image1, image2);
    image = bwmorph(image,'erode',1);
    
    Stable = 0;
    
    [~,n] = bwlabel(image);
    if( n==0 )
        Stable = 1;
    end 
    
    if (n1 == 0)
       
        Stable =0;
        
    end
end