% This second study has the following structure: practice block followed by:4 blocks with a rest in
% between. Each block has 2 presentations of 32 trials. The 32 trial are
% composed of 8 pairs of quantities presented once with vague instructions
% and once with precise instructions, with then element of the pair that is
% being picked out presented on the left and on the right (8 pairs * 2
% sides * 2 instructions types * sides = 32 trials, presented twice per
% block = 64 trials; each block presented 4 times = 256 trials).
%
% A trial consists of the instruction on screen while participants read it
% for as long as they like; a button press on SPACEBAR to dismiss the
% instruction; a blank screen of 100ms duration; a fixation cross of 100ms
% duration; a blank of 100ms duration; a screen with the pair presented
% (currently for unlimited duration terminated by a key press from a
% restricted set (left cmd, right cmd) ); 1000ms ISI.
%
% Participant id > 100 is used for testing and can be overwritten
function B_pilot_2(SUBJECT)
howLongToWaitForAResponse = 60; % seconds. Set low for test runs
try
    testing = 0; % 0 for real runs
    clc;
    AssertOpenGL;
    HideCursor;
    rand('state',sum(100*clock));
    KbName('UnifyKeyNames');
    datafilename = strcat('results/B_pilot_2/experimental/subject', num2str(SUBJECT),'.dat');
    practicedatafilename = strcat('results/B_pilot_2/practice/subject', num2str(SUBJECT), '.dat');
    % ensure that results directories exist
    if exist('results/B_pilot_2/practice', 'dir') == 0
        mkdir('results/B_pilot_2/practice');
    end
    if exist('results/B_pilot_2/experimental', 'dir') == 0
        mkdir('results/B_pilot_2/experimental');
    end
    % check for existing results file to prevent accidentally overwriting
    % files from a previous participant (except for participant numbers >= 100,
    % which can be used for test runs):
    if SUBJECT<100 && fopen(datafilename, 'rt')~=-1
        error(strcat('Result data file already exists! ', 'Choose a different subject number.'));
    else
        resultsFilePointer = fopen(datafilename,'wt');
        resultsFilePointerForPracticeTrials = fopen(practicedatafilename,'wt');
    end
    practiceStimuliFilename = 'B_pilot_2_practiceList.txt';
    experimentalStimuliFilename = 'B_pilot_2_experimentList.txt';
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
    error_feedback=sprintf(strcat...
        ('WRONG!!!'));
    instructionText = sprintf(strcat...
        ('You will see an instruction. For example: \n\n', ...
        '"Please choose the square with 5 dots."\n\n', ...
        'Then you press any key to continue.\n', ...
        'Then you see a small circle\n\n', ...
        'Then you will see two squares with some dots in them.\n\n', ...
        'You choose the one that the instruction told you to, \n',...
        'by using the left and right cmd keys, which are either side of the space bar.\n\n', ...
        'Try to answer as quickly as possible while avoiding errors. \n\n',...
        'There will be some practice trials first:\n',...
        'when you are ready, press any key to start the practice trials.'));
    handoverText = sprintf(strcat(...
        'The practice trials are now over.\n',...
        'The experimenter will leave the room:\n',...
        'then press any key to start the experiment.'));
    breakText = sprintf(strcat(...
        'Please take a short break between blocks of trials.\n\n',...
        'Press any key when you are ready for the next block.'));
    goodbyeText = sprintf(strcat(...
        'The experiment is now finished.\n\n',...
        'Thank you very much for participating\n\n',...
        'Please tell the experimenter that you have finished.'));
    oopsText = sprintf(strcat(...
        'Ooops... Something went wrong.\n\n',...
        'Please tell the experimenter.'));
    % Define allowable keys
    leftresp=KbName('z'); % 53
    rightresp=KbName('m'); % 59
    spacebar=KbName('space'); % 44
    quit_key = KbName('escape'); % 10
    % supply definitions of the squares (vertices and centres for each of 2 boxes, left box and right box)
    macbookpro_rect=[0 0 1280 800];
    leftBox = [200 300 400 500];
    rightBox = [880 300 1080 500];
    leftCenter = [300 400];
    rightCenter = [980 400];
    messagey = 150; % y location for message
    % Get screenNumber of stimulation display.
    screens=Screen('Screens');
    screenNumber=max(screens);
    % Returns as default the mean gray value of screen:
    gray=GrayIndex(screenNumber);
    % Open a double buffered fullscreen window on the stimulation screen
    [w, rect]=Screen('OpenWindow', screenNumber, gray, macbookpro_rect);
    Screen('TextSize', w, 32);
    % get the center for the fixation point
    xc = rect(3)/2;
    yc = rect(4)/2;
    % init some vars to reduce lag
    startrt=0;
    endrt=0;
    % set machine working hard
    Priority(MaxPriority(w));
    % Instructions
    DrawFormattedText(w, instructionText, 50, messagey, WhiteIndex(w));
    Screen('Flip',w);
    KbWait();
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    %%%%%%%%%%%%%%%%%%
    % Practice Block %
    %%%%%%%%%%%%%%%%%%
    % This should include feedback on accuracy.
    % This should be 10 trials.
    % Block structure for practice
    numberOfBlocks = 1;
    numberOfPresentations = 1;
    numberOfTrials = 8;
    % Get block trial list
    fid = fopen(practiceStimuliFilename);
    fin = textscan(fid,'%d%d%d%s%s%s');
    fclose(fid);
    % do randomisation
    for sequence = 1:(numberOfBlocks * numberOfPresentations)
        rndrows = randperm(numberOfTrials);
        for i = 1:numberOfTrials
            rowindex = rndrows(i);
            for columnid = 1:3 % (i) for doubles
                seq{sequence}{columnid}(i) = fin{columnid}(rowindex);
            end
            for columnid = 4:6 % {i} for strings
                seq{sequence}{columnid}{i} = fin{columnid}{rowindex};
            end
        end
    end
    sequenceCounter = 0;
    % loop through blocks (outer blocks, 1:4)
    for Block = 1:numberOfBlocks % PRACTICE
        % loop through presentations (inner blocks, 1:2)
        for Presentation = 1:numberOfPresentations
            sequenceCounter = sequenceCounter + 1;
            presentationSequence = seq{sequenceCounter};
            % extract presentation level variables
            pairId = presentationSequence{1};
            leftN = presentationSequence{2};
            rightN = presentationSequence{3};
            vagueness = presentationSequence{4};
            side = presentationSequence{5};
            instructionString = presentationSequence{6};
            for Trial = 1:numberOfTrials
                % Get variables at trial level
                leftNTrial = leftN(Trial);
                rightNTrial = rightN(Trial);
                instructionStringForThisTrial = instructionString{Trial};
                correctAnswerSide = side{Trial};
                if correctAnswerSide == 'L'
                    correctAnswer = 53; % z
                elseif correctAnswerSide == 'R'
                    correctAnswer = 59; % m
                end
                % Get the instruction ready
                trialMessage = sprintf(strcat([...
                    'Choose the square with ',...
                    instructionStringForThisTrial,...
                    ' dots']));
                % Get the right selection of dot positions ready
                perm = randperm(100);
                leftdots = dots(:,perm(1:leftNTrial));
                perm = randperm(100);
                rightdots = dots(:,perm(1:rightNTrial));
                % Draw the instruction to the back buffer
                DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
                % Flip the back buffer forwards to show instruction
                Screen('Flip',w);
                % Wait for all keys to be released and then for any key to
                % be pressed. If the key is the escape key then abort the
                % experiment. Wait for all keys to be released and then go
                % on.
                KbReleaseWait;
                [secs, keyCode] = KbWait();
                if keyCode(quit_key) == 1 % escape
                    error('escape key was pressed')
                end
                KbReleaseWait;
                % Show a white fixation circle in the center of the screen
                % for 1 second
                Screen('glPoint', w, [255 255 255], xc, yc, 10);
                Screen('Flip', w);
                WaitSecs(1);
                % Show a blank grey screen for 1/2 second
                Screen(w,'FillRect',gray);
                Screen('Flip', w);
                WaitSecs(.5);
                % Show the dots
                Screen('FrameRect', w, 125125125, leftBox, 1);
                Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);
                Screen('FrameRect', w, 125125125, rightBox, 1);
                Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);
                [VBLTimestamp startrt] = Screen('Flip', w);
                % Wait for a key  press
                while (GetSecs - startrt) <= howLongToWaitForAResponse
                    [keyIsDown, endrt, keyCode] = KbCheck;
                    if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                        break;
                    end
                    if ( keyCode(quit_key)==1 )
                        error('escape key was pressed')
                    end
                    WaitSecs(0.001);
                end
                % set arbitrary actualAnswer in case of no response
                actualAnswer = -1;
                % Evaluate the key press for error and for RT
                RT=round(1000*(endrt-startrt));
                % Get actual answer
                if keyCode(leftresp)==1
                    actualAnswer=leftresp;
                elseif keyCode(rightresp)==1
                    actualAnswer=rightresp;
                end
                % check for accuracy
                ACCURACY=-1;
                if actualAnswer==correctAnswer
                    ACCURACY=1;
                    Screen('Flip',w);
                    WaitSecs(.5);
                elseif actualAnswer~=correctAnswer
                    % give error feedback
                    ACCURACY=0;
                    DrawFormattedText(w, error_feedback, 'center', 'center', WhiteIndex(w));
                    Screen('Flip',w);
                    WaitSecs(.5);
                end
                % Write trial result to file
                fprintf(resultsFilePointerForPracticeTrials, ...
                    '%d\t%d\t%d\t%s\t%s\t%s\t%d\t%d\t%d\n', ...
                    pairId(Trial), ...
                    leftN(Trial), ...
                    rightN(Trial), ...
                    vagueness{Trial}, ...
                    side{Trial}, ...
                    instructionString{Trial}, ...
                    SUBJECT, ...
                    RT, ...
                    ACCURACY)
                % Introduce an ISI
                WaitSecs(1.5) % seconds ISI. There is already .5 second built in at feedback
            end % of Trials
            % Don't take a break between presentations
        end % Presentation
        % take a break between Blocks
    end % Block PRACTICE BLOCK
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Post practice handover
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % Some text about press any key to start the real thing
    DrawFormattedText(w, handoverText, 50, messagey, WhiteIndex(w));
    Screen('Flip',w);
    KbWait();
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    %%%%%%%%%%%%%%%%%%%%%%
    % Experimental Block %
    %%%%%%%%%%%%%%%%%%%%%%
    % Block structure
    numberOfBlocks = 4;
    numberOfPresentations = 2;
    numberOfTrials = 32;
    % read whole stimuli list at block level into vectors
    % the stimuli list is tab delimited, but this is just treated as
    % multiple spaces
    fid = fopen(experimentalStimuliFilename);
    fin = textscan(fid,'%d%d%d%s%s%s');
    fclose(fid);
    % do randomisation
    for sequence = 1:(numberOfBlocks * numberOfPresentations)
        rndrows = randperm(numberOfTrials);
        for i = 1:numberOfTrials
            rowindex = rndrows(i);
            for columnid = 1:3 % (i) for doubles
                seq{sequence}{columnid}(i) = fin{columnid}(rowindex);
            end
            for columnid = 4:6 % {i} for strings
                seq{sequence}{columnid}{i} = fin{columnid}{rowindex};
            end
        end
    end
    sequenceCounter = 0;
    % loop through blocks (outer blocks, 1:4)
    for Block = 1:numberOfBlocks
        % loop through presentations (inner blocks, 1:2)
        for Presentation = 1:numberOfPresentations
            sequenceCounter = sequenceCounter + 1;
            presentationSequence = seq{sequenceCounter};
            % extract presentation level variables
            pairId = presentationSequence{1};
            leftN = presentationSequence{2};
            rightN = presentationSequence{3};
            vagueness = presentationSequence{4};
            side = presentationSequence{5};
            instructionString = presentationSequence{6};
            for Trial = 1:numberOfTrials
                % Get variables at trial level
                leftNTrial = leftN(Trial);
                rightNTrial = rightN(Trial);
                instructionStringForThisTrial = instructionString{Trial};
                correctAnswerSide = side{Trial};
                if correctAnswerSide == 'L'
                    correctAnswer = 53; % z
                elseif correctAnswerSide == 'R'
                    correctAnswer = 59; % m
                end
                % Get the instruction ready
                trialMessage = sprintf(strcat([...
                    'Choose the square with ',...
                    instructionStringForThisTrial,...
                    ' dots']));
                % Get the right selection of dot positions ready
                perm = randperm(100);
                leftdots = dots(:,perm(1:leftNTrial));
                perm = randperm(100);
                rightdots = dots(:,perm(1:rightNTrial));
                % Draw the instruction to the back buffer
                DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
                Screen('Flip',w);
                % Wait for all keys to be released and then for any key to
                % be pressed. If the key is the escape key then abort the
                % experiment. Wait for all keys to be released and then go
                % on.
                KbReleaseWait;
                [secs, keyCode] = KbWait();
                if keyCode(quit_key) == 1 % escape
                    sca;
                    return
                end
                KbReleaseWait;
                % Show a white fixation circle in the center of the screen
                % for 1 second
                Screen('glPoint', w, [255 255 255], xc, yc, 10);
                Screen('Flip', w);
                WaitSecs(1);
                % Show a blank grey screen for 1/2 second
                Screen(w,'FillRect',gray);
                Screen('Flip', w);
                WaitSecs(.5);
                % Show the dots
                % Put left square to backbuffer
                Screen('FrameRect', w, 125125125, leftBox, 1);
                % Put some dots in left square in backbuffer
                Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);
                % Put right square to backbuffer
                Screen('FrameRect', w, 125125125, rightBox, 1);
                % Put some dots in right square in backbuffer
                Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);
                % Flip the display
                [VBLTimestamp startrt] = Screen('Flip', w);
                % Wait for a key  press
                while (GetSecs - startrt) <= howLongToWaitForAResponse
                    [keyIsDown, endrt, keyCode] = KbCheck;
                    if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                        break;
                    end
                    if ( keyCode(quit_key)==1 )
                        error('escape key was pressed')
                    end
                    % Wait 1 ms before checking the keyboard again to prevent
                    % overload of the machine at elevated Priority():
                    WaitSecs(0.001);
                end
                % set arbitrary actualAnswer in case of no response
                actualAnswer = -1;
                % Evaluate the key press for error and for RT
                RT=round(1000*(endrt-startrt));
                % Get actual answer
                if keyCode(leftresp)==1
                    actualAnswer=leftresp;
                elseif keyCode(rightresp)==1
                    actualAnswer=rightresp;
                end
                % check for accuracy
                ACCURACY=-1;
                if actualAnswer==correctAnswer
                    ACCURACY=1;
                    Screen('Flip',w);
                    WaitSecs(.5);
                elseif actualAnswer~=correctAnswer
                    % give error feedback
                    ACCURACY=0;
                    DrawFormattedText(w, error_feedback, 'center', 'center', WhiteIndex(w));
                    Screen('Flip',w);
                    WaitSecs(.5);
                end
                % Write trial result to file
                fprintf(resultsFilePointer, ...
                    '%d\t%d\t%d\t%s\t%s\t%s\t%d\t%d\t%d\n', ...
                    pairId(Trial), ...
                    leftN(Trial), ...
                    rightN(Trial), ...
                    vagueness{Trial}, ...
                    side{Trial}, ...
                    instructionString{Trial}, ...
                    SUBJECT, ...
                    RT, ...
                    ACCURACY)
                % Introduce an ISI
                WaitSecs(1.5) % seconds ISI. There is already .5 second built in at feedback
            end % of Trials
            % Don't take a break between presentations
        end % Presentation
        % take a break between Blocks
        % Text to back buffer
        DrawFormattedText(w, breakText, 50, messagey, WhiteIndex(w));
        % Flip to screen
        Screen('Flip',w);
        % Wait for key press to dismiss
        KbWait();
        % Go to grey screen
        Screen(w,'FillRect',gray);
        Screen('Flip', w);
    end % Block
catch
    sca;
    ShowCursor;
    fclose('all');
    Priority(0);
    psychrethrow(psychlasterror);

end
    % say goodbye
    % Text to back buffer
    DrawFormattedText(w, goodbyeText, 50, messagey, WhiteIndex(w));
    % Flip to screen
    Screen('Flip',w);
    % Wait for key press to dismiss
    KbWait();
    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    sca;
    ShowCursor;
    fclose('all');
    Priority(0);
    psychrethrow(psychlasterror);
end
