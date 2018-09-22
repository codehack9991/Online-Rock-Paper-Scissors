for ii=1:22
name=strcat(' (',num2str(ii),').JPG');
im = imread(name);
im = imresize(im,0.05);
imtool(im);
im2 = ((im(:,:,1)>120)&(im(:,:,2)>120));
for i=1:152
    for j=1:152
        if(~im2(i,j))
            im(i,j,:)=[0,0,0];
        end
    end
end
name=strcat(num2str(ii),'.jpg');
imwrite(im,name);
end