function [image] = resize(image, dim)
%resizes to dimension dim x dim
    [rows, cols] = size(image);
    
    if rows == cols
        image = imresize(image, [dim dim]);
    elseif rows > cols
        image = imresize(image, [dim NaN]);
        [~, cols] = size(image);
        temp = zeros(dim, dim/2 - cols/2);
        image = [temp image];
        
        [~, cols] = size(image);
        temp = zeros(dim, dim - cols);
        image = [image temp];
    else
        image = imresize(image, [NaN dim]);
        [rows, ~] = size(image);
        temp = zeros(dim/2 - rows/2, dim);
        image = [temp; image];
        
        [rows, ~] = size(image);
        temp = zeros(dim - rows, dim);
        image = [image; temp];
    end
    
end

