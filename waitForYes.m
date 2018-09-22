function [] = waitForYes(message)
    global vid
    global CROPBB1
    global CROPBB2
    global RGBVALUES1
    global RGBVALUES2
    global WORKINGBB1
    global WORKINGBB2
    global GAMEOVER
    global SCORES
    global DOWNLOC1
    global DOWNLOC2
    
%     print1 = 1;
%     print2 = 1;
%     player1 = 2;
%     player2 = 2;
    start = 0;
    while start == 0
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
            image = showMessage(image, message,[5,5]);
             image = showMessage(image, num2str(SCORES(1)), DOWNLOC1);
            image = showMessage(image, num2str(SCORES(2)), DOWNLOC2);
            imshow(image);
%             b = now;
            pause(0.01);
        end
        
        image1 = imcrop(image1, WORKINGBB1);
        image2 = imcrop(image2, WORKINGBB1);
        image1 = fliplr(image1);%left hand for player 1
        
%         if(player1 == 2)
            [finalimage1, player1] = yesOrNo(image1);
%         end
%         if (player2 == 2)
            [finalimage2, player2] = yesOrNo(image2);
%         end
        
%         
%         if(player1 == 1 && print1 == 1)
%             disp('PLAYER1 READY!');
%             print1 = 0;
%         end
%         if(player2 == 1 && print2 == 1)
%             disp('PLAYER2 READY!');
%             print2 = 0;
%         end
        
        if player1 == 1 && player2 == 1
            start = 1;
        end
        if player1 == 2 && player2 == 2
            start = 1;
            GAMEOVER = 1;
        end
    end

end

