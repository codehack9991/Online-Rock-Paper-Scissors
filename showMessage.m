function [ image ] = showMessage(image, message, location)
%
    image = insertText(image,location,message,'FontSize',20, 'BoxColor','black', 'TextColor','red');
end

