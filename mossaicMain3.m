function [] = mossaicMain3()
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
    load('yesTheta');
    load('noTheta');
    
    
    global THETAS
    THETAS = [rockTheta paperTheta scissorsTheta lizardTheta spockTheta];
    global NAME
    NAME = ['STONE   ' ;'PAPER   ' ;'SCISSORS' ;'LIZARD  ' ;'SPOCK   '];
    
    global YESNOTHETA
    YESNOTHETA = [yesTheta noTheta];
    global COMMAND
    COMMAND = ['YES' ; 'NO '];
    
    %GLOBAL VARIABLES
    global RGBVALUES1 %For player 1
    global RGBVALUES2 %For player 2
    
    snapi = getsnapshot(vid);
    [rows, cols, ~] = size(snapi);
    
    global help
    help = imread('help.jpg');
    help = imresize(help,[rows, cols]); 
    help = help(:,:,1) > 200;
    global playerSelect
    playerSelect = imread('playerSelect.jpg');
    playerSelect = imresize(playerSelect,[rows, cols/2]);
    playerSelect = playerSelect(:,:,1) > 200;
    global start
    start = imread('start.jpg');
    start = imresize(start,[rows, cols/2]);
    start = start(:,:,1) > 200;
    
    
    global paperCPU
    paperCPU = imread('paperCPU.jpg');
    paperCPU = imresize(paperCPU,[rows, cols/2]);
    paperCPU = paperCPU(:,:,1) > 200;
    global lizardCPU
    lizardCPU = imread('lizardCPU.jpg');
    lizardCPU = imresize(lizardCPU,[rows, cols/2]);
    lizardCPU = lizardCPU(:,:,1) > 200;
    global rockCPU
    rockCPU = imread('rockCPU.jpg');
    rockCPU = imresize(rockCPU,[rows, cols/2]);
    rockCPU = rockCPU(:,:,1) > 200;
    global sciCPU
    sciCPU = imread('sciCPU.jpg');
    sciCPU = imresize(sciCPU,[rows, cols/2]);
    sciCPU = sciCPU(:,:,1) > 200;
    global spockCPU
    spockCPU = imread('spockCPU.jpg');
    spockCPU = imresize(spockCPU,[rows, cols/2]);
    spockCPU = spockCPU(:,:,1) > 200;
    
    
    global p1Wins
    p1Wins = imread('p1Wins.jpg');
    p1Wins = imresize(p1Wins,[rows, cols]);
    p1Wins = p1Wins(:,:,1) > 200;
    global p2Wins
    p2Wins = imread('p2Wins.jpg');
    p2Wins = imresize(p2Wins,[rows, cols]);
    p2Wins = p2Wins(:,:,1) > 200;
    
    
    factor = 10;
    
    global width
    width = (cols/2 - 2*factor);
    factorY = rows/2 - width/2;
    
    global UPLOC
    UPLOC = [5,5];
    global DOWNLOC1
    global DOWNLOC2
    DOWNLOC1 = [factor,factorY];
    DOWNLOC2 = [cols/2 + factor, factorY];
    
    
    
    %WORKING BOUNDING BOXES
    global WORKINGBB1 %For player 1
    global WORKINGBB2 %For player 2
    WORKINGBB1 = [factor, factorY, cols/2 - 2*factor, rows - 2*factorY];
    WORKINGBB2 = [cols/2 + factor, factorY, cols/2 - 2*factor, rows - 2*factorY];
    
    factor = 0;
    
    %WORKING BOUNDING BOXES
    global CROPBB1 %For player 1
    global CROPBB2 %For player 2
    CROPBB1 = [factor, factor, cols/2 - 2*factor, rows - 2*factor];
    CROPBB2 = [cols/2 + factor, factor, cols/2 - 2*factor, rows - 2*factor];
    
    %IMAGES STONE P S L S
    global PAPER
    PAPER = zeros(width, width);
    
    startMessage = 'WANNA START?';
    numPlayersMessage = 'ENTER NUMBER OF PLAYERS';
%     TAKE RGB
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
    
    imshow(help);
    pause(3);

    global GAMEOVER
    GAMEOVER = 0;
    %   START MENU
    if(startMenu(start, startMessage) == 2)
        GAMEOVER = 1;
    end
    
    while GAMEOVER == 0
        %   NUMBER OF PLAYERS SELECT
            numberOfPlayers = startMenu(playerSelect, numPlayersMessage);

        %   START THE GAME
        SCORES = [0 0];
        if numberOfPlayers == 1
            
            while max(SCORES) < NUMROUNDS && GAMEOVER == 0
                
                      
                for i = 1:100
                    snap = getsnapshot(vid);

                    snap1 = imcrop(snap, CROPBB1);
                    snapHand1 = seperateHand(snap1, RGBVALUES1);
% 
%                     snap2 = imcrop(snap, CROPBB2);
%                     snapHand2 = seperateHand(snap2, RGBVALUES2);

                    image1 = getFinalImage(snapHand1);
                    [rows, cols] = size(image1);
                    image2 = zeros(rows, cols);

                    image = [image1 image2];

                    image = addBoxes(image, 1);
                    
                    image = showMessage(image,'Get your hand ready', [5,5]);
                     image = showMessage(image, num2str(SCORES(1)), DOWNLOC1);
                    image = showMessage(image, num2str(SCORES(2)), DOWNLOC2);
                    
                    
        %             image = insertText(image,[0,0],'HELLO','FontSize',30, 'BoxOpacity',0, 'TextColor','white');
                    imshow(image);
                    
        %             b = now;
                    pause(0.01);
                end
                imgNum = ceil(rand(1)/0.2);
                if(imgNum == 1)
                    image2 = rockCPU;
                elseif(imgNum == 2)
                    image2 = paperCPU;
                elseif(imgNum == 3)
                    image2 = sciCPU;
                elseif(imgNum == 4)
                    image2 = lizardCPU;
                elseif(imgNum == 5)
                    image2 = spockCPU;
                end
                
                image = [image1 image2];
                imshow(image);
                pause(2);
                
                disp(strcat('CPU', num2str(imgNum)));
                image1 = imcrop(image1, WORKINGBB1);

                [~, player1] = cropImages(image1);
                player2 = imgNum;
                if(player1 * player2 ~= 0)
                    winner = getWinner(player1, player2);
                    if winner ~= 0
                        SCORES(winner) = SCORES(winner) + 1;
                        if winner == 1
                            imshow(p1Wins);
                        else
                            imshow(p2Wins);
                        end
                        pause(3);
                    end
                end
                [rows,cols] = size(image2);
                image2 = zeros(rows,cols);
                disp(strcat('SCORES:', num2str(SCORES)));

                if max(SCORES) < NUMROUNDS
                    
                    begin = 0;
                %     snap = getsnapshot(vid);
                %     [rows, cols] = size(snap);
                %     image2 = zeros(rows, cols/2);

                    while begin == 0
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
                            image = showMessage(image, 'CONTINUE OR LEAVE!',[5,5]);
                             image = showMessage(image, num2str(SCORES(1)), DOWNLOC1);
                            image = showMessage(image, num2str(SCORES(2)), DOWNLOC2);
                            imshow(image);

                            pause(0.01);
                        end

                        image1 = imcrop(image1, WORKINGBB1);
                        [~, begin] = yesOrNo(image1);
                    end

                    if begin == 2
                        GAMEOVER = 1;
                    end
                    
                    if GAMEOVER == 1
                        break
                    end
                    disp('NEXT ROUND STARTS IN ');
                    for i = 3:-1:1
                    disp(i);
                    pause(1);
                    end
                end
            end
        elseif numberOfPlayers == 2
            while max(SCORES) < NUMROUNDS && GAMEOVER == 0
        %         
        %         a = now;
        %         b = now;
        %         while b-a < 1.2270e-04
                for i = 1:100
                    snap = getsnapshot(vid);

                    snap1 = imcrop(snap, CROPBB1);
                    snapHand1 = seperateHand(snap1, RGBVALUES1);

                    snap2 = imcrop(snap, CROPBB2);
                    snapHand2 = seperateHand(snap2, RGBVALUES2);

                    image1 = getFinalImage(snapHand1);
                    image2 = getFinalImage(snapHand2);

                    image = [image1 image2];

                    image = addBoxes(image, 2);
        %             image = insertText(image,[0,0],'HELLO','FontSize',30, 'BoxOpacity',0, 'TextColor','white');
                    image = showMessage(image, 'Get Your Hands Ready!',[5,5]);
                    image = showMessage(image, num2str(SCORES(1)), DOWNLOC1);
                    image = showMessage(image, num2str(SCORES(2)), DOWNLOC2);
%                     imshow(image);
                    imshow(image);
        %             b = now;
                    pause(0.01);
                end

                image1 = imcrop(image1, WORKINGBB1);
                image2 = imcrop(image2, WORKINGBB1);
                image1 = fliplr(image1);%left hand for player 1

                [~, player1] = cropImages(image1);
                [~, player2] = cropImages(image2);

                if(player1 ~= 0 && player2 ~= 0)
                    winner = getWinner(player1, player2);
                    if winner ~= 0
                        SCORES(winner) = SCORES(winner) + 1;
                        if winner == 1
                            imshow(p1Wins);
                        else
                            imshow(p2Wins);
                        end
                        pause(3);
                    end
                    disp(strcat('SCORES:', num2str(SCORES)));
                    image = showMessage(image, num2str(SCORES(1)), DOWNLOC1);
                    image = showMessage(image, num2str(SCORES(2)), DOWNLOC2);
                    imshow(image);



                    if max(SCORES) < NUMROUNDS
                        waitForYes('CONTINUE OR LEAVE');
                        if GAMEOVER == 1
                            break
                        end
                        disp('NEXT ROUND STARTS IN ');

                        for i = 3:-1:1
                        disp(i);
                        pause(1);
                        end
                    end
                end
                
            end
        end
        %   DISPLAY WINNER
        if GAMEOVER == 0
            [~, winner] = max(SCORES);
            snap = getsnapshot(vid);
            [rows,cols,~] = size(snap);
            image = zeros(rows,cols,3);
            image = showMessage(image,'******GAME OVER!******',[30,40]);
            image = showMessage(image,strcat('PLAYER ', num2str(winner), ' WINS'),[80,80]);
            image = showMessage(image, strcat('SCORE:', num2str(SCORES(1)), '|',num2str(SCORES(2))), [95,110]);
            imshow(image);
            pause(4);
        end
        
        %   RETURN TO START MENU
        if(startMenu(start,startMessage) == 1)
            GAMEOVER = 0;
        elseif(startMenu(start,startMessage) == 2)
            GAMEOVER = 1;
        end
        

    end

    
    %   EXIT
    close all force
end