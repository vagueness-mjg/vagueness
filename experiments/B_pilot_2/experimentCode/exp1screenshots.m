function exp2screenshots(SUBJECT)
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

SUBJECT=1000;

howLongToWaitForAResponse = 60; % seconds. Set low for test runs
testing = 1; % 0 for real runs

% Clear Matlab/Octave window:
clc;

% check for Opengl compatibility, abort otherwise:
AssertOpenGL;

% Reseed the random-number generator for each expt.
rand('state',sum(100*clock));

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows and GNU/Linux:
KbName('UnifyKeyNames');

%     % Turn off the annoying echo to the command line
%     ListenChar(2);

% Define allowable keys
leftresp=KbName('LeftGUI'); %227
rightresp=KbName('RightGUI'); %231
spacebar=KbName('space'); %44


%%%%%%%%%%%%%%%%%%%%%%
% file handling
%%%%%%%%%%%%%%%%%%%%%%


%practice data output file to write to
practicedatafilename = strcat('output/subject',...
    num2str(SUBJECT),'Practice','.dat');

% experimental stimuli to read from
experimentalStimuliFilename = 'experimentalStimuli.txt';

% experimental data output file to write to
datafilename = strcat('output/subject',...
    num2str(SUBJECT),'.dat');

% check for existing result file to prevent accidentally overwriting
% files from a previous subject/session (except for subject  numbers >
% 99, which are reserved for testing)

if SUBJECT<99 && fopen(datafilename, 'rt')~=-1
    fclose('all');
    error(strcat('Result data file already exists!',...
        'Choose a different subject number.'));
else
    outputFilePointer = fopen(datafilename,'wt');
    outputFilePointerForPracticeTrials = ...
        fopen(practicedatafilename,'wt');
end

% Hide the cursor
% HideCursor;

try
    %%%%%%%%%%%%%%%%%%%%%
    % set up the dots   %
    %%%%%%%%%%%%%%%%%%%%%
    
    % describe allowable dot locations
    % In this experiment we need up to 45 dots to be displayed at any one
    % time in any one square. The setup allows 100 locations.
    
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
    
    errorFeedback=sprintf(strcat...
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
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initialise screen stuff  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get screenNumber of stimulation display.
    screens=Screen('Screens');
    screenNumber=max(screens);
    
    % macbookProRect=[0 0 1280 800];
    leftBox = [200 300 400 500];
    rightBox = [880 300 1080 500];
    leftCenter = [300 400];
    rightCenter = [980 400];
    messagey = 150; % y location for message
    
    % Returns as default the mean gray value of screen:
    gray=GrayIndex(screenNumber);
    
    % Open a double buffered fullscreen window on the stimulation screen
    [w, rect]=Screen('OpenWindow',screenNumber, gray);
    
    % get the center for the fixation point
    xc = rect(3)/2;
    yc = rect(4)/2;
    
    % Set text size
    Screen('TextSize', w, 32);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initialise variables to reduce lag
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    startrt=0;   % initialise start rt variable
    endrt=0;     % initialise end rt variable
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Other prep
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Set priority for script execution to realtime priority:
    priorityLevel=MaxPriority(w);
    Priority(priorityLevel);
    
    %%%%%%%%%%%%%%%%%%
    % Instructions
    %%%%%%%%%%%%%%%%%%
    
    % Text to back buffer
    DrawFormattedText(w, instructionText, 50, messagey, WhiteIndex(w));
    
    % Flip to screen
    Screen('Flip',w);
     imageArray = Screen('GetImage', w, [0 0 1280 800]);
	 imwrite(imageArray, 'screenshots/screenshot1_introductory_instructions.jpg');    
    % Wait for key press to dismiss
    KbWait();
    
    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    
    %%%%%%%%%%%%%%%%%%
    % Practice Block %
    %%%%%%%%%%%%%%%%%%
    
    % This should include a feedback on accuracy.
    % This should be 10 trials.
    
    % Block structure for practice
    
    numberOfBlocks = 1;
    numberOfPresentations = 1;
    numberOfTrials = 8;
    numberOfColumns = 6;
    
fin={
1,	5,	25,	"V",	"L",	"few";
5,	30,	25,	"V",	"L",	"many";
2,	10,	25,	"P",	"L",	"10";
8,	45,	25,	"P",	"L",	"45";
3,	25,	15,	"V",	"R",	"few";
8,	25,	45,	"V",	"R",	"many";
7,	25,	40,	"P",	"R",	"40";
6,	25,	35,	"P",	"R",	"35"};

    % do randomisation
    IN = fin;
    OUT = cell(numberOfTrials, numberOfColumns);
    rndrows = randperm(numberOfTrials);

    for nrows = 1:numberOfTrials
        rows = rndrows(nrows);
    	for cols = 1:numberOfColumns
    	    OUT{nrows,cols}=IN{rows,cols};
    	end
    end

    runningOrder=OUT;
    
    sequenceCounter = 0;
    
    % declare trial variables
    pairId = cell(numberOfTrials,1);
    leftN = cell(numberOfTrials,1);
    rightN = cell(numberOfTrials,1);
    vagueness = cell(numberOfTrials,1);
    side = cell(numberOfTrials,1);
    instructionString = cell(numberOfTrials,1);

        for Presentation = 1:numberOfPresentations
            presentationSequence = runningOrder;

            for Trial = 1:numberOfTrials              

            % extract trial level variables
            
            pairId = presentationSequence{Trial,1};
            leftN = presentationSequence{Trial,2};
            rightN = presentationSequence{Trial,3};
            vagueness = presentationSequence{Trial,4};
            side = presentationSequence{Trial,5};
            instructionString = presentationSequence{Trial,6};
                           
                % Get variables at trial level
                
                leftNTrial = leftN;
                rightNTrial = rightN;
                instructionStringForThisTrial = instructionString;
                correctAnswerSide = side;
                if correctAnswerSide == 'L'
                    correctAnswer = 227;
                elseif correctAnswerSide == 'R'
                    correctAnswer = 231;
                end % endif
            
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
        		  	imageArray = Screen('GetImage', w, [0 0 1280 800]);
			 		imwrite(imageArray, 'screenshots/screenshot2_trial_instructions.jpg');    
           
                % Wait for all keys to be released and then for any key to
                % be pressed. If the key is the escape key then abort the
                % experiment. Wait for all keys to be released and then go
                % on.
                
                KbReleaseWait;
                
                if testing == 0
                    [secs, keyCode] = KbWait();
                    if keyCode(41) == 1 % escape
                        sca;
                        return
                    end
                elseif testing == 1
                    [secs, keyCode] = KbWait();
                    if keyCode(41) == 1 % escape
                        sca;
                        return
                    end
                end
                
                KbReleaseWait;
                
                % Show a white fixation circle in the center of the screen
                % for 1 second
                
                Screen('glPoint', w, [255 255 255], xc, yc, 10);
                Screen('Flip', w);
        		  	imageArray = Screen('GetImage', w, [0 0 1280 800]);
			 		imwrite(imageArray, 'screenshots/screenshot3_fixation_point.jpg');    
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
        		  	imageArray = Screen('GetImage', w, [0 0 1280 800]);
			 		imwrite(imageArray, 'screenshots/screenshot4_trial_response_screen.jpg');                    
                % Wait for a key  press
                
                while (GetSecs - startrt) <= howLongToWaitForAResponse
                    [keyIsDown, endrt, keyCode] = KbCheck;
                    if ( keyCode(leftresp)==1 || keyCode(rightresp)==1 )
                        break;
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
                    DrawFormattedText(w, errorFeedback, 'center', 'center', WhiteIndex(w));
                    Screen('Flip',w);
                    imageArray = Screen('GetImage', w, [0 0 1280 800]);
			 		imwrite(imageArray, 'screenshots/screenshot5_error_feedback.jpg');    
                    WaitSecs(.5);
                end
                
                % Write trial result to file
                
                fprintf(outputFilePointerForPracticeTrials, ...
                    '%d\t%d\t%d\t%s\t%s\t%s\t%d\t%d\t%d\n', ...
                    pairId, ...
                    leftN, ...
                    rightN, ...
                    vagueness, ...
                    side, ...
                    instructionString, ...
                    SUBJECT, ...
                    RT, ...
                    ACCURACY)
                
                % Introduce an ISI
                
                WaitSecs(1.5) % seconds ISI. There is already .5 second built in at feedback
             
            
            
            
            
            
            
            
            end % end for Trial
		end % end for Presentation
		Screen('CloseAll');
		fclose('all');
catch
    Screen('CloseAll');
fclose('all');

    % Output the error message that describes the error:
    psychrethrow(psychlasterror);
end_try_catch