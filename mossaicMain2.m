function [] = mossaicMain2()
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
    load('sciThetaOld');
    
    global THETAS
    THETAS = [rockTheta paperTheta scissorsTheta lizardTheta spockTheta];
    global NAME
    NAME = ['STONE   ' ;'PAPER   ' ;'SCISSORS' ;'LIZARD  ' ;'SPOCK   '];
    
    %GLOBAL VARIABLES
    global RGBVALUES1 %For player 1
    global RGBVALUES2 %For player 2
    
    snapi = getsnapshot(vid);
    
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
    pause(2);
    snap = getsnapshot(vid);
    RGBVALUES1 = getMaxMinRGB(snap);
    
    disp('GET READY PLAYER 2');
    pause(2);
    snap = getsnapshot(vid);
    RGBVALUES2 = getMaxMinRGB(snap);
    
    global SCORES
    SCORES = [0 0];
    
    global NUMROUNDS
    NUMROUNDS = 5;
    
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
    
    while max(SCORES) < NUMROUNDS
        disp('Get your hands ready');
        
        a = now;
        b = now;
%         while b-a < 1.2270e-04
        for i = 1:200
            snap = getsnapshot(vid);

            snap1 = imcrop(snap, CROPBB1);
            snapHand1 = seperateHand(snap1, RGBVALUES1);
            
            snap2 = imcrop(snap, CROPBB2);
            snapHand2 = seperateHand(snap2, RGBVALUES2);

            image1 = getFinalImage(snapHand1);
            image2 = getFinalImage(snapHand2);

            image = [image1 image2];

            image = addBoxes(image);
            imshow(image);
%             b = now;
            pause(0.01);
        end
        
        image1 = imcrop(image1, WORKINGBB1);
        image2 = imcrop(image2, WORKINGBB1);
        image1 = fliplr(image1);%left hand for player 1
        
        [finalimage1, player1] = cropImages(image1);
        [finalimage2, player2] = cropImages(image2);
        
        if(player1 * player2 ~= 0)
            winner = getWinner(player1, player2);
            if winner ~= 0
                SCORES(winner) = SCORES(winner) + 1;
            end
        end
        disp(strcat('SCORES:', num2str(SCORES)));
        
        if max(SCORES) < NUMROUNDS
            
            disp('NEXT ROUND STARTS IN ');
            for i = 5:-1:1
            disp(i);
            pause(1);
            end
        end
    end
    
    [~, winner] = max(SCORES);
    disp(strcat('GAME OVER.. CONGRATULATIONS PLAYER ', num2str(winner)));
end