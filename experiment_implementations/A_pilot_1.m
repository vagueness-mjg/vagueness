% [A] pilot experiment 1
% edited 2018 October 13th:
%     : to change the response keys from left and right clover to z and m.
%     : (The experiment reported in the manuscript was run on a MacBook Pro,
%     : and the CMD (clover) keys were left and right response) but I want it to be runnable on other computers too.

function A_pilot_1(participant_number)
howLongToWaitForAResponse=60; % in seconds
try
    clc;
    AssertOpenGL;
    HideCursor;
    rand('state',sum(100*clock));
    KbName('UnifyKeyNames');
    results_filename = strcat('output/subject', num2str(participant_number), '.dat');
    results_filename_practice = strcat('output/subject', num2str(participant_number),'Practice','.dat');
    % check for existing results file to prevent accidentally overwriting
    % files from a previous participant (except for participant numbers >= 100,
    % which can be used for test runs):
    if participant_number < 100 && fopen(results_filename, 'rt') ~= -1
        error('A results file for a participant with that number already exists!\nRun the experiment again with a different participant number.');
    else
        results_filename_pointer = fopen(results_filename, 'wt');
        results_filename_pointer_practice = fopen(results_filename_practice, 'wt');
    end
    % declare all the allowable dot locations
    x = 0; y = 0;
    dots = [...
        [x-90;y-90] [x-70;y-90] [x-50;y-90] [x-30;y-90] [x-10;y-90] [x+10;y-90] [x+30;y-90] [x+50;y-90] [x+70;y-90] [x+90;y-90]...
        [x-90;y-70] [x-70;y-70] [x-50;y-70] [x-30;y-70] [x-10;y-70] [x+10;y-70] [x+30;y-70] [x+50;y-70] [x+70;y-70] [x+90;y-70]...
        [x-90;y-50] [x-70;y-50] [x-50;y-50] [x-30;y-50] [x-10;y-50] [x+10;y-50] [x+30;y-50] [x+50;y-50] [x+70;y-50] [x+90;y-50]...
        [x-90;y-30] [x-70;y-30] [x-50;y-30] [x-30;y-30] [x-10;y-30] [x+10;y-30] [x+30;y-30] [x+50;y-30] [x+70;y-30] [x+90;y-30]...
        [x-90;y-10] [x-70;y-10] [x-50;y-10] [x-30;y-10] [x-10;y-10] [x+10;y-10] [x+30;y-10] [x+50;y-10] [x+70;y-10] [x+90;y-10]...
        [x-90;y+10] [x-70;y+10] [x-50;y+10] [x-30;y+10] [x-10;y+10] [x+10;y+10] [x+30;y+10] [x+50;y+10] [x+70;y+10] [x+90;y+10]...
        [x-90;y+30] [x-70;y+30] [x-50;y+30] [x-30;y+30] [x-10;y+30] [x+10;y+30] [x+30;y+30] [x+50;y+30] [x+70;y+30] [x+90;y+30]...
        [x-90;y+50] [x-70;y+50] [x-50;y+50] [x-30;y+50] [x-10;y+50] [x+10;y+50] [x+30;y+50] [x+50;y+50] [x+70;y+50] [x+90;y+50]...
        [x-90;y+70] [x-70;y+70] [x-50;y+70] [x-30;y+70] [x-10;y+70] [x+10;y+70] [x+30;y+70] [x+50;y+70] [x+70;y+70] [x+90;y+70]...
        [x-90;y+90] [x-70;y+90] [x-50;y+90] [x-30;y+90] [x-10;y+90] [x+10;y+90] [x+30;y+90] [x+50;y+90] [x+70;y+90] [x+90;y+90]...
        ];
    % supply definitions of the squares (vertices and centres for each of 2 boxes, left box and right box)
    left_box = [200 300 400 500];
    right_box = [880 300 1080 500];
    left_center = [300 400];
    right_center = [980 400];
    % supply where the message goes (on the vertical axis)
    message_y = 150;
    % Define allowable response keys including escape to quit
    left_response_key = KbName('z');
    right_response_key = KbName('m');
    quit_key = KbName('escape');
    % Get screenNumber of stimulation display:
    % (if running on a laptop with a monitor attached, this picks out the monitor).
    screens = Screen('Screens');
    screenNumber = max(screens);
    % macbookpro_rect is the screen size used in the experiments reported in this manuscript.
    macbookpro_rect = [0 0 1280 800];
    grey = GrayIndex(screenNumber);
    w = Screen('OpenWindow', max(screens), grey, macbookpro_rect);
    Screen('TextSize', w, 32);

    acclimatise_instructions_high = sprintf(strcat(...
    'You will see two squares with dots in, like the ones below.\n\n',...
    'You will be asked to choose one, like this:\n\n',...
    'Choose the square with seven dots\n\n'));
    acclimatise_instructions_low = sprintf(strcat(...
    'Press %s to choose the square on the left,\n\n',...
    'or %s to choose the square on the right\n\n',...
    'Try it when you are ready'), KbName(left_response_key), KbName(right_response_key));

    errorFeedback = sprintf('WRONG!!!');



    % Do the acclimatisation trial
    acclimatisation_status = 0;
    while acclimatisation_status == 0
        DrawFormattedText(w, acclimatise_instructions_high, 'center', 50, WhiteIndex(w));
        DrawFormattedText(w, acclimatise_instructions_low, 'center', 600, WhiteIndex(w));
        left_dots = dots(:,randperm(100)(1:3));
        Screen('FrameRect', w, 125125125, left_box, 1);
        Screen('DrawDots', w, left_dots, 9, [], left_center, 1);
        right_dots = dots(:,randperm(100)(1:7));
        Screen('FrameRect', w, 125125125, right_box, 1);
        Screen('DrawDots', w, right_dots, 9, [], right_center, 1);
        [VBLTimestamp startrt] = Screen('Flip', w);
        [KeyIsDown, endrt, keyCode] = KbCheck;
        while (GetSecs - startrt) <= 10
            if ( keyCode(left_response_key)==1 || keyCode(right_response_key)==1 || keyCode(quit_key)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode] = KbCheck;
            WaitSecs(0.001);
        end
        % Parse the response
        if keyCode(right_response_key) == 1
            feedback = ('Correct...');
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
            break;
        elseif keyCode(left_response_key) == 1
            feedback = ('Wrong... Please try again...');
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
        elseif keyCode(quit_key) == 1
            feedback = ('The quit key was pressed. Shutting down now...');
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
            error('This run exited because the escape key was pressed.')
        else
            feedback = sprintf(strcat("Trial timed out.\n\nPlease try to respond as quickly as possible while avoiding errors."));
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
        end
    end

    % Handing over from acclimatisation to practice
    okText=sprintf(strcat(...
        'OK. Next there will be 5 practice screens so you can get used to it.\n\n',...
        'Press any key when you are ready for the practice screens'));
    DrawFormattedText(w, okText, 'center', 'center', WhiteIndex(w));
    Screen('Flip', w);
    KbWait;
    Screen('Flip', w);
    KbReleaseWait;

    % Practice Block goes here
    fid = fopen('A_pilot_1_practiceList.txt');
    fin = textscan(fid,'%s%s%s%s%d%d%d%d%s%d%d');
    fclose(fid);

    gapSizeList = fin{1};
    targetSizeList = fin{2};
    targetSideList = fin{3};
    precisionLevelList = fin{4};
    pairIdList = fin{5};
    pairVersionList = fin{6};
    numDotsLeftList = fin{7};
    numDotsRightList = fin{8};
    instructionStringList = fin{9};
    conditionCodeList = fin{10};
    correctAnswerList = fin{11};

    ntrials = length(gapSizeList);

    runningOrder = randperm(ntrials);

    for t = 1:ntrials % PRACTICE
        trial = runningOrder(t);
        actualAnswer = -1;
        gapSize = gapSizeList{trial};
        targetSize = targetSizeList{trial};
        targetSide = targetSideList{trial};
        precisionLevel = precisionLevelList{trial};
        pairId = pairIdList(trial);
        pairVersion = pairVersionList(trial);
        numDotsLeft = numDotsLeftList(trial);
        numDotsRight = numDotsRightList(trial);
        instructionString = instructionStringList{trial};
        conditionCode = conditionCodeList(trial);
        correctAnswer = correctAnswerList(trial);
        trialMessage = sprintf(strcat(['Choose the square with',' ',instructionString, ' ','dots.']));
        WaitSecs(0.200);
        [KeyIsDown, endrt, keyCode]=KbCheck;
        perm=randperm(100);
        left_dots=(dots(:,perm(1:numDotsLeft)));
        perm=randperm(100);
        right_dots=(dots(:,perm(1:numDotsRight)));
        DrawFormattedText(w, trialMessage, 'center', message_y, WhiteIndex(w));
        Screen('FrameRect', w, 125125125, left_box, 1);
        Screen('DrawDots', w, left_dots, 9, [], left_center, 1);
        Screen('FrameRect', w, 125125125, right_box, 1);
        Screen('DrawDots', w, right_dots, 9, [], right_center, 1);
        WaitSecs(0.001);
        [VBLTimestamp startrt] = Screen('Flip', w);
        while (GetSecs - startrt) <= howLongToWaitForAResponse
            if ( keyCode(left_response_key)==1 || keyCode(right_response_key)==1 || keyCode(quit_key)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode] = KbCheck;
            WaitSecs(0.001);
        end
        Screen('Flip', w);
        % Calculate RT
        rt=round(1000*(endrt-startrt));
        % Calulate accuracy
        if keyCode(left_response_key)==1
            actualAnswer=left_response_key;
        elseif keyCode(right_response_key)==1
            actualAnswer=right_response_key;
        elseif keyCode(quit_key) == 1
            feedback = ('The quit key was pressed. Shutting down now...');
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
            error("Escape key was pressed so I'm quitting, from the practice block")
        end
        accurate = -1;
        if actualAnswer==correctAnswer
            accurate=1;
        elseif actualAnswer~=correctAnswer
            accurate=0;
            DrawFormattedText(w, errorFeedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(2);
        end
        % Write trial result to file:
        fprintf(results_filename_pointer_practice,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\n', ...
            gapSize,...
            targetSize,...
            targetSide,...
            precisionLevel,...
            pairId,...
            pairVersion,...
            numDotsLeft,...
            numDotsRight,...
            instructionString,...
            conditionCode,...
            correctAnswer,...
            participant_number,...
            actualAnswer, ...
            accurate,...
            rt);
        % Wait for all keys to be released before starting next trial
        KbReleaseWait;
        
    end % end of trial loop for practice block
    WaitSecs(1);
    afterPracticeMessage=sprintf(strcat(...
        'Good!\n\nPractice is over.\n\nYou may ask any questions now.\n\n',...
        'Please press any key when you are ready to start the experiment'));
    DrawFormattedText(w, afterPracticeMessage, 'center', 'center', WhiteIndex(w));
    Screen('Flip', w);
    KbWait;
    KbReleaseWait;
    WaitSecs(0.500);


    % Experimental Block goes here
    fid = fopen('A_pilot_1_experimentList.txt');
    fin = textscan(fid,'%s%s%s%s%d%d%d%d%s%d%d');
    fclose(fid);

    gapSizeList = fin{1};
    targetSizeList = fin{2};
    targetSideList = fin{3};
    precisionLevelList = fin{4};
    pairIdList = fin{5};
    pairVersionList = fin{6};
    numDotsLeftList = fin{7};
    numDotsRightList = fin{8};
    instructionStringList = fin{9};
    conditionCodeList = fin{10};
    correctAnswerList = fin{11};

    ntrials = length(gapSizeList);

    runningOrder = randperm(ntrials);

    for t = 1:ntrials % EXPERIMENTAL
        trial = runningOrder(t);
        actualAnswer = -1;
        gapSize = gapSizeList{trial};
        targetSize = targetSizeList{trial};
        targetSide = targetSideList{trial};
        precisionLevel = precisionLevelList{trial};
        pairId = pairIdList(trial);
        pairVersion = pairVersionList(trial);
        numDotsLeft = numDotsLeftList(trial);
        numDotsRight = numDotsRightList(trial);
        instructionString = instructionStringList{trial};
        conditionCode = conditionCodeList(trial);
        correctAnswer = correctAnswerList(trial);
        trialMessage = sprintf(strcat(['Choose the square with',' ',instructionString, ' ','dots.']));
        WaitSecs(0.200);
        [KeyIsDown, endrt, keyCode]=KbCheck;
        perm=randperm(100);
        left_dots=(dots(:,perm(1:numDotsLeft)));
        perm=randperm(100);
        right_dots=(dots(:,perm(1:numDotsRight)));
        DrawFormattedText(w, trialMessage, 'center', message_y, WhiteIndex(w));
        Screen('FrameRect', w, 125125125, left_box, 1);
        Screen('DrawDots', w, left_dots, 9, [], left_center, 1);
        Screen('FrameRect', w, 125125125, right_box, 1);
        Screen('DrawDots', w, right_dots, 9, [], right_center, 1);
        WaitSecs(0.001);
        [VBLTimestamp startrt] = Screen('Flip', w);
        while (GetSecs - startrt) <= howLongToWaitForAResponse
            if ( keyCode(left_response_key)==1 || keyCode(right_response_key)==1 || keyCode(quit_key)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode] = KbCheck;
            WaitSecs(0.001);
        end
        Screen('Flip', w);
        % Calculate RT
        rt=round(1000*(endrt-startrt));
        % Calulate accuracy
        if keyCode(left_response_key)==1
            actualAnswer=left_response_key;
        elseif keyCode(right_response_key)==1
            actualAnswer=right_response_key;
        elseif keyCode(quit_key) == 1
         feedback = ('The quit key was pressed. Shutting down now...');
            DrawFormattedText(w, feedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip', w);
            WaitSecs(5);
            error("Escape key was pressed so I'm quitting, from the experimental block")
        end
        accurate = -1;
        if actualAnswer==correctAnswer
            accurate=1;
        elseif actualAnswer~=correctAnswer
            accurate=0;
            DrawFormattedText(w, errorFeedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(2);
        end
        % Write trial result to file:
        fprintf(results_filename_pointer_practice,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\n', ...
            gapSize,...
            targetSize,...
            targetSide,...
            precisionLevel,...
            pairId,...
            pairVersion,...
            numDotsLeft,...
            numDotsRight,...
            instructionString,...
            conditionCode,...
            correctAnswer,...
            participant_number,...
            actualAnswer, ...
            accurate,...
            rt);
        % Wait for all keys to be released before leaving the experimental block
        KbReleaseWait;
    end
% This indent is part of the try ... catch
catch
    sca;
    ShowCursor;
    fclose('all');
    Priority(0);
    psychrethrow(psychlasterror);
end
sca;
ShowCursor;
fclose('all');
Priority(0);
