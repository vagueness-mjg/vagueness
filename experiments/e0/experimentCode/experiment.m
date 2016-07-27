function experiment(subNo)

howLongToWaitForAResponse=60; % in seconds

try
    
    % Clear Matlab/Octave window:
    clc;
    
    % check for Opengl compatibility, abort otherwise:
    AssertOpenGL;
    
    % Hide the cursor
    HideCursor;
    
    % Reseed the random-number generator for each expt.
    rand('state',sum(100*clock));
    
    % Make sure keyboard mapping is the same on all supported operating systems
    % Apple MacOS/X, MS-Windows and GNU/Linux:
    KbName('UnifyKeyNames');
    
    % Turn off the annoying echo to the command line
    ListenChar(2);
    
    % Define allowable keys
    leftresp=KbName('LeftGUI'); %227
    rightresp=KbName('RightGUI'); %231
    RestrictKeysForKbCheck([leftresp,rightresp]);
    
    %%%%%%%%%%%%%%%%%%%%%%
    % file handling
    %%%%%%%%%%%%%%%%%%%%%%
    
    % experimental data
    datafilename = strcat('output/subject',...
        num2str(subNo),'.dat');  % name of data file to write to
    
    % practice data
    practicedatafilename = strcat('output/subject',...
        num2str(subNo),'Practice','.dat');  % name of practice data file to write to
    
    % check for existing result file to prevent accidentally overwriting
    % files from a previous subject/session (except for subject numbers > 99):
    if subNo<99 && fopen(datafilename, 'rt')~=-1
        fclose('all');
        error(strcat('Result data file already exists!',...
            'Choose a different subject number.'));
    else
        outputFilePointer = fopen(datafilename,'wt');...
            outputFilePointerForPracticeTrials = fopen(practicedatafilename,'wt');
    end
    
    %%%%%%%%%%%%%%%%%%%%%
    % set up the dots   %
    %%%%%%%%%%%%%%%%%%%%%
    
    % describe allowable dot locations
    x=0;y=0;
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
    
    %%%%%%%%%%%%%%%%%%%%%
    % define text strings
    %%%%%%%%%%%%%%%%%%%%%
    
    practiceInstructionsAbove=sprintf(strcat...
        ('You will see two squares with dots in, like the ones below.\n\n',...
        'You will be asked to choose one, like this:\n\n',...
        'Choose the square with seven dots\n\n'));
    
    practiceInstructionsUnderneath=sprintf(strcat...
        ('Press left cmd to choose the square on the left,\n\n',...
        'or right cmd to choose the square on the right\n\n',...
        'Try it when you are ready'));
    
    errorFeedback=sprintf(strcat...
        ('WRONG!!!'));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initialise screen stuff  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % initialise variables to avoid timing errors
    startrt=0;   % initialise start rt variable
    endrt=0;     % initialise end rt variable
    
    % Get screenNumber of stimulation display.
    screens=Screen('Screens');
    screenNumber=max(screens);
    
    % macbookProRect=[0 0 1280 800];
    
    leftBox=[200 300 400 500];
    rightBox=[880 300 1080 500];
    leftCenter=[300 400];
    rightCenter=[980 400];
    messagey=150;
    
    % Returns as default the mean gray value of screen:
    gray=GrayIndex(screenNumber);
    
    % Open a double buffered fullscreen window on the stimulation screen
    [w]=Screen('OpenWindow',screenNumber, gray);
    
    % Set priority for script execution to realtime priority:
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    
    % Set text size
    Screen('TextSize', w, 32);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Participant acclimatisation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    acclimatised = 0;
    
    while acclimatised==0 % ACCLIMATISATION
        
        % Do dummy calls to GetSecs, WaitSecs, KbCheck
        [KeyIsDown, endrt, keyCode]=KbCheck;
        WaitSecs(0.1);
        GetSecs;
        
        % Write practice instructions to back buffer
        DrawFormattedText(w, practiceInstructionsAbove, 'center', 50, WhiteIndex(w));
        DrawFormattedText(w, practiceInstructionsUnderneath, 'center', 600, WhiteIndex(w));
        
        % Draw two dummy squares with dots to the back buffer
        perm=randperm(100);
        practiceLeftdots=(dots(:,perm(1:3)));
        perm=randperm(100);
        practiceRightdots=(dots(:,perm(1:7)));
        
        % Put left square to backbuffer
        Screen('FrameRect', w, 125125125, leftBox, 1);
        
        % Put some dots in left square in backbuffer
        Screen('DrawDots', w, practiceLeftdots, 9, [], leftCenter, 1);
        
        % Put right square to backbuffer
        Screen('FrameRect', w, 125125125, rightBox, 1);
        
        % Put some dots in right square in backbuffer
        Screen('DrawDots', w, practiceRightdots, 9, [], rightCenter, 1);
        
        % Update the display
        Screen('Flip', w);
        
        % collect participants keyb resp
        while (GetSecs - startrt) <= 10000
            if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode]=KbCheck;
            % Wait 1 ms before checking the keyboard again to prevent
            % overload of the machine at elevated Priority():
            WaitSecs(0.001);
        end
        
        % check they got it right
        if keyCode(rightresp)==1
            acclimatised=1;
            acclimatisedText=('Correct...');
            DrawFormattedText(w, acclimatisedText, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(3);
        else
            notacclimatisedText=('Wrong... Try again...');
            DrawFormattedText(w, notacclimatisedText, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(3);
        end
        
    end % of acclimatisation
    
    okText=sprintf(strcat(...
        'OK. Next there will be 5 practice screens so you can get used to it.\n\n',...
        'Press either cmd key when you are ready for the practice screens'));
    DrawFormattedText(w, okText, 'center', 'center', WhiteIndex(w));
    Screen('Flip', w);
    
    RestrictKeysForKbCheck([leftresp,rightresp]);
    KbWait;
    Screen('Flip', w);
    
    % Wait for all keys to be released before continuing
    KbReleaseWait;
    
    %%%%%%%%%%%%%%%%%%
    % Practice Block %
    %%%%%%%%%%%%%%%%%%
    
    % read whole practiceList.txt into fin variable
    fid=fopen('practiceList.txt');
    fin = textscan(fid,'%s%s%s%s%d%d%d%d%s%d%d');
    fclose(fid);
    
    % extract vectors
    gapSizeList=fin{1};
    targetSizeList=fin{2};
    targetSideList=fin{3};
    precisionLevelList=fin{4};
    pairIdList=fin{5};
    pairVersionList=fin{6};
    numDotsLeftList=fin{7};
    numDotsRightList=fin{8};
    instructionStringList=fin{9};
    conditionCodeList=fin{10};
    correctAnswerList=fin{11};
    
    % get number of trials
    ntrials = length(gapSizeList);
    
    % randomise the running order
    runningOrder = randperm(ntrials);
    
    % loop through trials
    for t=1:ntrials % PRACTICE
        
        % pick the ntrial_th element of the random runningOrder
        trial=runningOrder(t);
        
        % set arbitrary actualAnswer in case of progression with no
        % response;
        actualAnswer=-1;
        
        % get variables at trial level
        gapSize=gapSizeList{trial};
        targetSize=targetSizeList{trial};
        targetSide=targetSideList{trial};
        precisionLevel=precisionLevelList{trial};
        pairId=pairIdList(trial);
        pairVersion=pairVersionList(trial);
        numDotsLeft=numDotsLeftList(trial);
        numDotsRight=numDotsRightList(trial);
        instructionString=instructionStringList{trial};
        conditionCode=conditionCodeList(trial);
        correctAnswer=correctAnswerList(trial);
        
        trialMessage=sprintf(strcat(['Choose the square with',' ',instructionString, ' ','dots.']));
        
        % Wait a bit between trials
        WaitSecs(0.200);
        
        % initialize KbCheck
        [KeyIsDown, endrt, keyCode]=KbCheck;
        
        % get coordinates of dots for left and right squares for this trial
        % There are 100 places a dot can go in each screen. Permute 1 to 100 then choose n positions
        perm=randperm(100);
        leftdots=(dots(:,perm(1:numDotsLeft)));
        perm=randperm(100);
        rightdots=(dots(:,perm(1:numDotsRight)));
        
        % Prep backbuffer
        
        % Draw instruction to backbuffer
        DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
        % Put left square to backbuffer
        Screen('FrameRect', w, 125125125, leftBox, 1);
        % Put some dots in left square in backbuffer
        Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);
        % Put right square to backbuffer
        Screen('FrameRect', w, 125125125, rightBox, 1);
        % Put some dots in right square in backbuffer
        Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);
        
        WaitSecs(0.001);
        
        % Show stimulus on screen at next possible display refresh cycle,
        % and record stimulus onset time in 'startrt':
        [VBLTimestamp startrt] = Screen('Flip', w);
        
        % collect participants keyb resp
        %         [endrt, keyCode, deltaSecs] = KbPressWait();
        while (GetSecs - startrt) <= howLongToWaitForAResponse
            if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode]=KbCheck;
            %             [endrt, keyCode, deltaSecs] = KbCheck();
            % Wait 1 ms before checking the keyboard again to prevent
            % overload of the machine at elevated Priority():
            WaitSecs(0.001);
        end
        
        % clear screen
        Screen('Flip', w);
        
        % compute response time
        rt=round(1000*(endrt-startrt));
        
        % compute accuracy
        
        % get keycode of actual answer
        if keyCode(leftresp)==1
            actualAnswer=leftresp;
        elseif keyCode(rightresp)==1
            actualAnswer=rightresp;
        end
        
        % compare actualAnswer with correctAnswer
        accurate=-1;
        if actualAnswer==correctAnswer
            accurate=1;
        elseif actualAnswer~=correctAnswer
            accurate=0;
            DrawFormattedText(w, errorFeedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(2);
        end
        % Write trial result to file:
        fprintf(outputFilePointerForPracticeTrials,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\n', ...
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
            subNo,...
            actualAnswer, ...
            accurate,...
            rt);
        
        % Wait for all keys to be released before starting next trial
        KbReleaseWait;
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Post-Practice handover %
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    WaitSecs(1);
    afterPracticeMessage=sprintf(strcat(...
        'Good!\n\nPractice is over.\n\nYou may ask any questions now.\n\n',...
        'Please press either cmd key when you are ready to start the experiment'));
    DrawFormattedText(w, afterPracticeMessage, 'center', 'center', WhiteIndex(w));
    Screen('Flip', w);
    
    RestrictKeysForKbCheck([leftresp,rightresp]);
    KbWait;
    KbReleaseWait;
    
    %%%%%%%%%%%%%%%%%%%%%%
    % Experimental Block %
    %%%%%%%%%%%%%%%%%%%%%%
    
    % Only allow experimental answer keys in the experimental block
    RestrictKeysForKbCheck([leftresp,rightresp]);
    
    % Wait a bit
    WaitSecs(0.500);
    
    % Clear screen to background color
    Screen('Flip', w);
    
    % read whole experimentList.txt at block level into vectors
    fid = fopen('experimentList.txt');
    fin = textscan(fid,'%s%s%s%s%d%d%d%d%s%d%d');
    fclose(fid);
    
    % assign variables
    gapSizeList=fin{1};
    targetSizeList=fin{2};
    targetSideList=fin{3};
    precisionLevelList=fin{4};
    pairIdList=fin{5};
    pairVersionList=fin{6};
    numDotsLeftList=fin{7};
    numDotsRightList=fin{8};
    instructionStringList=fin{9};
    conditionCodeList=fin{10};
    correctAnswerList=fin{11};
    
    % get number of trials
    ntrials = length(gapSizeList);
    
    % randomise the running order
    runningOrder = randperm(ntrials);
    
    % loop through trials
    
    for t=1:ntrials % EXPERIMENTAL BLOCK
        
        % pick the ntrial_th element of the random runningOrder
        trial=runningOrder(t);
        
        % set arbitrary actualAnswer in case of progression with no
        % response;
        actualAnswer=-1;
        
        % get variables at trial level
        gapSize=gapSizeList{trial};
        targetSize=targetSizeList{trial};
        targetSide=targetSideList{trial};
        precisionLevel=precisionLevelList{trial};
        pairId=pairIdList(trial);
        pairVersion=pairVersionList(trial);
        numDotsLeft=numDotsLeftList(trial);
        numDotsRight=numDotsRightList(trial);
        instructionString=instructionStringList{trial};
        conditionCode=conditionCodeList(trial);
        correctAnswer=correctAnswerList(trial);
        
        trialMessage=sprintf(strcat(['Choose the square with',' ',instructionString, ' ','dots.']));
        
        % Wait a bit between trials
        WaitSecs(0.200);
        
        % initialize KbCheck
        [KeyIsDown, endrt, keyCode]=KbCheck;
        
        % get coordinates of dots for left and right squares for this trial
        % There are 100 places a dot can go in each screen. Permute 1 to 100 then choose n positions
        perm=randperm(100);
        leftdots=(dots(:,perm(1:numDotsLeft)));
        perm=randperm(100);
        rightdots=(dots(:,perm(1:numDotsRight)));
        
        % Prep backbuffer
        
        % Draw instruction to backbuffer
        DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
        % Put left square to backbuffer
        Screen('FrameRect', w, 125125125, leftBox, 1);
        % Put some dots in left square in backbuffer
        Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);
        % Put right square to backbuffer
        Screen('FrameRect', w, 125125125, rightBox, 1);
        % Put some dots in right square in backbuffer
        Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);
        
        WaitSecs(0.001);
        
        % Show stimulus on screen at next possible display refresh cycle,
        % and record stimulus onset time in 'startrt':
        [VBLTimestamp startrt] = Screen('Flip', w);
        
        % collect participants keyb resp
        %         [endrt, keyCode, deltaSecs] = KbPressWait();
        while (GetSecs - startrt) <= howLongToWaitForAResponse
            if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                break;
            end
            [KeyIsDown, endrt, keyCode]=KbCheck;
            %             [endrt, keyCode, deltaSecs] = KbCheck();
            % Wait 1 ms before checking the keyboard again to prevent
            % overload of the machine at elevated Priority():
            WaitSecs(0.001);
        end
        
        WaitSecs(0.001);
        
        % clear screen
        Screen('Flip', w);
        
        % compute response time
        rt=round(1000*(endrt-startrt));
        
        % compute accuracy
        
        % get keycode of actual answer
        if keyCode(leftresp)==1
            actualAnswer=leftresp;
        elseif keyCode(rightresp)==1
            actualAnswer=rightresp;
        end
        
        % compare actualAnswer with correctAnswer
        accurate=-1;
        if actualAnswer==correctAnswer
            accurate=1;
        elseif actualAnswer~=correctAnswer
            accurate=0;
            DrawFormattedText(w, errorFeedback, 'center', 'center', WhiteIndex(w));
            Screen('Flip',w);
            WaitSecs(2);
        end
        
        % Write trial result to file:
        fprintf(outputFilePointer,'%s\t%s\t%s\t%s\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%d\t%d\t%d\t%d\n', ...
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
            subNo,...
            actualAnswer, ...
            accurate,...
            rt);
        
        % Wait for all keys to be released before starting next trial
        KbReleaseWait;
        
    end % of trials
    
    % Say goodbye
    message = 'Thank you. You have finished now.';
    DrawFormattedText(w, message, 'center', 'center', WhiteIndex(w));
    Screen('Flip', w);
    
    % Wait for 3 secs before exit
    WaitSecs(3);
    
    % Do same cleanup as at the end of a regular session...
    
    % Re-enable the annoying echo to the command line
    ListenChar(0);
    
    % Re-allow all keys
    RestrictKeysForKbCheck([]);
    
    % Re-show cursor
    ShowCursor;
    
    % Close screens
    Screen('CloseAll');
    
    % Close files
    fclose('all');
    
    % Lower priority
    Priority(0);
    
catch
    
    % Do same cleanup as at the end of a regular session...
    
    % Re-enable the annoying echo to the command line
    ListenChar(0);
    
    % Re-allow all keys
    RestrictKeysForKbCheck([]);
    
    % Re-show cursor
    ShowCursor;
    
    % Close screens
    Screen('CloseAll');
    
    % Close files
    fclose('all');
    
    % Lower priority
    Priority(0);
    
    % Output the error message that describes the error:
    psychrethrow(psychlasterror);
    
end
