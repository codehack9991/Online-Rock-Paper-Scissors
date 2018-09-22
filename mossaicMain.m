function [] = mossaicMain()
%THE MAIN FUNCTION TO RUN AT THE EVENT: MOSSAIC
    %CLOSING EVERYTHING
    close all force
    clc

    %VIDEO DETECTION
    global vid
    defineVid();
    preview(vid);
    pause(2);
    
    %LOADING THETAS
    load('rockTheta');
    load('paperTheta');
    load('spockTheta');
    load('lizardTheta');
    load('scissorsTheta');
    
    global THETAS
    THETAS = [rockTheta paperTheta scissorsTheta lizardTheta spockTheta];
    global NAME
    NAME = ['STONE   ' ;'PAPER   ' ;'SCISSORS' ;'LIZARD  ' ;'SPOCK   '];
    
    %GLOBAL VARIABLES
    global RGBVALUES1 %For player 1
%     global RGBVALUES2 %For player 2
    
    snapi = getsnapshot(vid);
    pause(1);
    
    
    [rows, cols, ~] = size(snapi);
    factor = 20;
    
    %WORKING BOUNDING BOXES
    global WORKINGBB1 %For player 1
    global WORKINGBB2 %For player 2
    WORKINGBB1 = [factor, factor, cols/2 - 2*factor, rows - 2*factor];
    WORKINGBB2 = [cols/2 + factor, factor, cols/2 - 2*factor, rows - 2*factor];
    
    
    factor = 0;
    
    %WORKING BOUNDING BOXES
    global CROPBB1 %For player 1
    global CROPBB2 %For player 2
    CROPBB1 = [factor, factor, cols/2 - 2*factor, rows - 2*factor];
    CROPBB2 = [cols/2 + factor, factor, cols/2 - 2*factor, rows - 2*factor];
    
    
%     [~, WORKINGBB1] = imcrop(snapi);

    disp('GET READY PLAYER 1');
    pause(3);
    snap = getsnapshot(vid);
    RGBVALUES1 = getMaxMinRGB(snap);
    
%     global ALPHA
%     ALPHA = 0.001;
    
    
%     initSnap = seperateHand(snapi, RGBVALUES1);
%     [rows, cols, ~] = size(initSnap);
%     imageArea = rows*cols;
%     handArea = floor(imageArea/20);
% 
%     initSnap = bwareaopen(initSnap,handArea);
    
%     initSnap = imcrop(initSnap, WORKINGBB1);
%     imtool(initSnap);
    
    while 1
%         snap = getsnapshot(vid);
% %         snap = imcrop(snap, WORKINGBB1);
%         
%         snapHand = seperateHand(snap, RGBVALUES1);
% 
% %         image = snapHand + initSnap;
% %         image = mod(image,2);
% %         image = snapHand.*image;
%         image = snapHand;
% 
%         [rows, cols, ~] = size(image);
%         imageArea = rows*cols;
%         handArea = floor(imageArea/70);
%     
%         image = bwareaopen(image,handArea);
% %         image = imfill(image,'holes');
%         image = bwmorph(image, 'dilate', 1);
%       
        
        for i = 1:50
            snap = getsnapshot(vid);

            snap1 = imcrop(snap, CROPBB1);
%             snap1 = snap;
            snapHand1 = seperateHand(snap1, RGBVALUES1);
% 
%             snap2 = imcrop(snap, CROPBB2);
%             snapHand2 = seperateHand(snap2, RGBVALUES2);

            image1 = getFinalImage(snapHand1);
%             image2 = getFinalImage(snapHand2);

%             image = [image1 image2];
            image = image1;
            image = addBoxes(image, 1);
%             image = imcrop(image, CROPBB1);
            imshow(image);
%             b = now;
            pause(0.01);
        end
        
        image1 = imcrop(image1, WORKINGBB1);
        [finalimage, ~] = cropImages(image1);
        
%         imshow(seperateHand(snap, RGBVALUES1));
%         imshow(snapHand);
    end
    
end