function exp3fakescreenshots(SUBJECT)
% This third study has the following structure:
% Practice, Rest, Block1 Block 2 Block 3, Block 4
% There are 256 trials
% There are 64 unique trials
% There are 4 Blocks
% Each trial consists of 3 squares each with a number of dots.
%
% A trial consists of:
% the instruction on screen while participants read it for as long as they like;
% a button press on SPACEBAR to bring up
% a screen with the instruction and the dots presented
%
% Participant id > 100 is used for testing and can be overwritten

howLongToWaitForAResponse = 60; % seconds. Set low for test runs
testing = 1; % 0 for real runs, 1 for testing
takescreenshot=1;
SUBJECT=1001;


% Clear Matlab/Octave window:
clc;

% check for Opengl compatibility, abort otherwise:
AssertOpenGL;

% Reseed the random-number generator for each expt.
rand('state',sum(100*clock));

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows and GNU/Linux:
KbName('UnifyKeyNames');

% Define keys by ID
leftresp=KbName('c'); % is 6
middleresp=KbName('b'); % is 5
rightresp=KbName('m'); % is 16
escapekey=KbName('ESCAPE'); % is 41
spacebar=KbName('space'); % is 44
returnkey=KbName('return'); % is 40

%%%%%%%%%%%%%%%%%%%%%%
% define stimuli
%%%%%%%%%%%%%%%%%%%%%%

% order in headers gives the answer to "Which square had the small quantity"? and does not give the correct response

%Condition 1 is numerical vague
%Condition 2 is numerical precise
%Condition 3 is visual vague
%Condition 4 is visual precise
%
%Order 1 is small number on left
%Order 2 is small number on right
%
%Quantity 1 is small
%Quantity 2 is big


exp3headers={
	"Item","Condition","Order","Quantity","Left","Mid","Right","Instruction"};

exp3practicestimuli = {
	0,0,0,0,6,15,24,"Choose a square with about 10 dots";
	0,0,0,0,34,25,16,"Choose the square with 16 dots";
	0,0,0,0,44,35,26,"Choose a square with many dots";
	0,0,0,0,36,45,54,"Choose the square with the fewest dots";
	0,0,0,0,36,45,54,"Choose the square with 54 dots"};
	
%%%%%%%%%%%%%%%%%%%%%
% set up output files
%%%%%%%%%%%%%%%%%%%%%

% practice data output file to write to
practicedatafilename = strcat('output/subject',...
    num2str(SUBJECT),'Practice','.data');

% experimental data output file to write to
datafilename = strcat('output/subject',...
    num2str(SUBJECT),'.data');

% check for existing result file to prevent accidentally overwriting
% files from a previous subject/session (except for subject  numbers >
% 99, which are reserved for testing)

if SUBJECT<99 && fopen(datafilename, 'rt')~=-1
    fclose('all');
    error(strcat('Result data file already exists!',...
        'Choose a different subject number.'));
else
    outputFilePointer = fopen(datafilename,'wt');
        fprintf(outputFilePointer,...
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
            "Item","Condition","Order","Quantity","Left","Mid","Right","Instruction","Subject","RT","RESPONSE")

    outputFilePointerForPracticeTrials = ...
        fopen(practicedatafilename,'wt');
        fprintf(outputFilePointerForPracticeTrials,...
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
            "Item","Condition","Order","Quantity","Left","Mid","Right","Instruction","Subject","RT","RESPONSE")

end

% Hide the cursor
HideCursor;

try
    %%%%%%%%%%%%%%%%%%%
    % set up the dots %
    %%%%%%%%%%%%%%%%%%%

    % describe allowable dot locations
    % In this experiment we need up to 74 dots to be displayed at any one
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

    %%%%%%%%%%%%%%%%%%%%%%%
    % define text strings %
    %%%%%%%%%%%%%%%%%%%%%%%

    errorFeedback=sprintf(strcat...
        ('WRONG!!!'));

%    instructionText = sprintf(strcat...
%        ('You will see an instruction. For example: \n\n', ...
%        '"Please choose a square with few dots."\n\n', ...
%        'Then you press "Spacebar" to continue.\n', ...
%        'Then you will see three squares with some dots in them.\n\n', ...
%        '"c" to choose the square on the left; \n',...
%        '"b" to choose the square in the middle, \n',...
%        '"m" to choose the square on the right.\n\n', ...
%        'Try to answer accurately but as quickly as possible. \n\n',...
%        'There will be some practice trials first:\n',...
%        'when you are ready, press Return to start the practice trials.'));

%    instructionText = sprintf(strcat...
%         ('You will see 3 squares with dots in them, and an instruction to choose one of them, as in the picture below.\n\n',...
%         'Use the keys C,B, or M to choose the square that you think matches the instruction best.'));

    instructionText = sprintf(strcat...
         ('You will see 3 squares with dots in them, and an instruction\n',...
         'to choose one of them, as in the picture above.\n\n',...
         'First you see the instruction, then press space to see the squares.\n\n',...
         'Use the keys C, B, or M to choose the square that you think matches\n',...
         'the instruction best. There will be some practice trials so you\n',...
         'can get used to the routine.'));

    screenshotForInstructions=imread('fakescreenshots/static.jpg', 'jpg');

    handoverText = sprintf(strcat(...
        'The practice trials are now over.\n',...
        'The experimenter will leave the room:\n',...
        'then press Return to start the experiment.'));

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
        
    endOfBlock1Text = sprintf(strcat(...
        'Please take a short break before the next block\n\n',...
        'You have 3 blocks left to do.\n\n',...
        'Press Return to continue'));
        
    endOfBlock2Text = sprintf(strcat(...
        'Please take a short break before the next block\n\n',...
        'You have 2 block left to do.\n\n',...
        'Press Return to continue'));
    
    endOfBlock3Text = sprintf(strcat(...
        'Please take a short break before the next block\n\n',...
        'You have 1 block left to do.\n\n',...
        'Press Return to continue'));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initialise screen stuff  %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Get screenNumber of stimulation display.
    screens=Screen('Screens');
    screenNumber=max(screens);

    % macbookProRect=[0 0 1280 800];
    % order is [left top right bottom];
    leftBox  = [170 300 370 500];
    midBox   = [540 300 740 500];
    rightBox = [910 300 1110 500];
    % state centers
    leftCenter  = [270 400];
    midCenter   = [640 400];
    rightCenter = [1010 400];
    messagey = 150; % y location for message
    instructionY = 400;
    instructionX = 100;

    % Returns as default the mean gray value of screen:
    gray=GrayIndex(screenNumber);
    gray=255; % gray is white
    
    % Open a double buffered fullscreen window on the stimulation screen
    [w, rect]=Screen('OpenWindow',screenNumber, gray);

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

    % Text of introductory instructions to back buffer
    % DrawFormattedText(w, instructionText, instructionX, instructionY, WhiteIndex(w));
    DrawFormattedText(w, instructionText, instructionX, instructionY, BlackIndex(w));
    
%    Screen('PutImage', w, screenshotForInstructions,[0 0 756 560]); % put image on screen
    Screen('PutImage', w, screenshotForInstructions,[340 0 980 375]); % put image on screen
    
%    Screen(windowPtr,'PutImage',imageArray,[rect],[copyMode])

    % Flip introductory instructions to screen
    Screen('Flip', w);

    if takescreenshot == 1
     imageArray = Screen('GetImage', w, [0 0 1280 800]);
	 imwrite(imageArray, 'fakescreenshots/screenshot1_introductory_instructions.bmp');
	end

    % Wait for key press (Return) to dismiss
    RestrictKeysForKbCheck([returnkey]);
    KbWait();

    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);

    if takescreenshot == 1
     imageArray = Screen('GetImage', w, [0 0 1280 800]);
	 imwrite(imageArray, 'fakescreenshots/screenshot2_greyscreen.bmp');
	end    
    

    %%%%%%%%%%%%%%%%%%
    %  Practice Session %
    %%%%%%%%%%%%%%%%%%

    % This should be 4 trials.

    % Block structure for practice

    numberOfBlocks = 1;
    if testing == 1
     numberOfBlocks = 1;
    end
    numberOfTrials = 5;
    numberOfColumns = 8;

    % do randomisation
    IN = exp3practicestimuli;
    OUT = cell(numberOfTrials, numberOfColumns);
    rndrows = randperm(numberOfTrials);

    for nrows = 1:numberOfTrials
        rows = rndrows(nrows);
    	for cols = 1:numberOfColumns
    	    OUT{nrows,cols}=IN{rows,cols};
    	end
    end

    runningOrder=OUT;

    % declare trial variables
    Item = cell(numberOfTrials,1);
    ConditionID = cell(numberOfTrials,1);
    Order = cell(numberOfTrials,1);
    Quantity = cell(numberOfTrials,1);
    Left = cell(numberOfTrials,1);
    Mid = cell(numberOfTrials,1);
    Right = cell(numberOfTrials,1);
    Instruction = cell(numberOfTrials,1);

  	% fill, extract trial variables
    for trial = 1:numberOfTrials
        Item(trial)         = runningOrder{trial,1};
        ConditionID(trial)  = runningOrder{trial,2};
        Order(trial)        = runningOrder{trial,3};
        Quantity(trial)     = runningOrder{trial,4};
        Left(trial)         = runningOrder{trial,5};
        Mid(trial)          = runningOrder{trial,6};
        Right(trial)        = runningOrder{trial,7};
        Instruction(trial)  = runningOrder{trial,8};
    end

    for trial = 1:numberOfTrials

        % Get the instruction ready
        trialMessage = Instruction(trial){};

	    % Get the selection of dot positions ready
	    perm = randperm(100);
	    leftdots = dots(:,perm(1:Left(trial){}));
	    perm = randperm(100);
	    middots = dots(:,perm(1:Mid(trial){}));
	    perm = randperm(100);
	    rightdots = dots(:,perm(1:Right(trial){}));

	    % Draw the instruction to the back buffer
	    DrawFormattedText(w, trialMessage, 'center', messagey, BlackIndex(w));

	    % Flip to show the trialMessage
	    Screen('Flip',w);
	    if takescreenshot==1
	       imageArray = Screen('GetImage', w, [0 0 1280 800]);
	       imwrite(imageArray, 'fakescreenshots/screenshot3_practice_TrialMessage.bmp');
	    end
	    % Wait for keypress on Spacebar and release
	    KbReleaseWait;

        foo=GetSecs;
	    RestrictKeysForKbCheck([spacebar,escapekey]) % only allow spacebar to dismiss trialmessage or escapekey to abort
	    while (GetSecs - foo) <= 10000
	         [keyIsDown, xxx, keyCode] = KbCheck;
	         if keyCode(spacebar)==1
	            break;
	         end
	         if keyCode(escapekey)==1
	            error("aborted");
	         end
	    % Wait 1 ms before checking the keyboard again to prevent
	    % overload of the machine at elevated Priority():
	         WaitSecs(0.001);
	    end %endwhile

	    KbReleaseWait;

	    % Show the dots, repeating the instructions

	    % Put left square to backbuffer
	    Screen('FrameRect', w, 000000000, leftBox, 1);

	    % Put some dots in left square in backbuffer
	    Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);

	    % Put mid square to backbuffer
	    Screen('FrameRect', w, 000000000, midBox, 1);

	    % Put some dots in right square in backbuffer
	    Screen('DrawDots', w, middots, 9, [], midCenter, 1);

	    % Put right square to backbuffer
	    Screen('FrameRect', w, 000000000, rightBox, 1);

	    % Put some dots in right square in backbuffer
	    Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);

	    % repeat the instruction

	    % Draw the instruction to the back buffer
	    DrawFormattedText(w, trialMessage, 'center', messagey, BlackIndex(w));

	    % Flip the display
	    [VBLTimestamp startrt] = Screen('Flip', w);
	    
	    if takescreenshot==1
	       imageArray = Screen('GetImage', w, [0 0 1280 800]);
	       imwrite(imageArray, 'fakescreenshots/screenshot4_practice_responseScreen.bmp');
	    end

	    % Wait for a key  press

%	    RestrictKeysForKbCheck([leftresp,middleresp,rightresp,escapekey])
        RestrictKeysForKbCheck([]); % can press any key with this line
	    while (GetSecs - startrt) <= howLongToWaitForAResponse
	         [keyIsDown, endrt, keyCode] = KbCheck;
	         if ( keyCode(leftresp)==1 || keyCode(middleresp)==1 || keyCode(rightresp)==1 )
	             break;
	         end
	         if  keyCode(escapekey)==1
	             error("aborted");
	         end
	         % Wait 1 ms before checking the keyboard again to prevent overload of the machine at elevated Priority():
	         WaitSecs(0.001);
	    end %endwhile

	    % Evaluate the key press for RT
        RT = round(1000*(endrt-startrt)); % RT in ms

        % Evaluate key press for which key was pressed
        actualAnswer="NOANSWER";
        if keyCode(leftresp)==1
            actualAnswer="LEFT";
        elseif keyCode(middleresp)==1
            actualAnswer="MIDDLE";
        elseif keyCode(rightresp)==1
            actualAnswer="RIGHT";
        elseif keyCode(escapekey)==1
            actualAnswer="ESCAPE";
        end

        % Write trial result to file

        fprintf(outputFilePointerForPracticeTrials, ...
                '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%s\n', ...
                Item(trial){} ,...
                ConditionID(trial){},...
                Order(trial){}    ,...
                Quantity(trial){}     ,...
                Left(trial){}         ,...
                Mid(trial){}          ,...
                Right(trial){}        ,...
                strcat('"',Instruction(trial){},'"')  ,...
                SUBJECT, ...
                RT, ...
                actualAnswer)
end %endfor trials

fclose(outputFilePointerForPracticeTrials)

    % show handover text

    % Text to back buffer
    DrawFormattedText(w, handoverText, 50, messagey, BlackIndex(w));
    % Flip to screen
    Screen('Flip',w);
	    if takescreenshot==1
	       imageArray = Screen('GetImage', w, [0 0 1280 800]);
	       imwrite(imageArray, 'fakescreenshots/screenshot5_handover.bmp');
	    end

        foo=GetSecs;
	    RestrictKeysForKbCheck(40,escapekey)
	    while (GetSecs - foo) <= 10000
	         [keyIsDown, xxx, keyCode] = KbCheck;
	         if keyCode(escapekey)==1
	            error("aborted");
	         end	         
	         if keyCode(40)==1 % 40 is keycode for return
	            break;
	         end
	    % Wait 1 ms before checking the keyboard again to prevent
	    % overload of the machine at elevated Priority():
	         WaitSecs(0.001);
	    end %endwhile
	    
    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    
    
    

%%%%%%%%%%%%%%%%%%%%
% EXPERIMENTAL SESSION
%%%%%%%%%%%%%%%%%%%%

exp3stimuli={
1,1,1,1,6,15,24,"Choose a square with about 10 dots";
1,1,1,2,6,15,24,"Choose a square with about 20 dots";
1,1,2,1,24,15,6,"Choose a square with about 10 dots";
1,1,2,2,24,15,6,"Choose a square with about 20 dots";
1,2,1,1,6,15,24,"Choose the square with 6 dots";
1,2,1,2,6,15,24,"Choose the square with 24 dots";
1,2,2,1,24,15,6,"Choose the square with 6 dots";
1,2,2,2,24,15,6,"Choose the square with 24 dots";
1,3,1,1,6,15,24,"Choose a square with few dots";
1,3,1,2,6,15,24,"Choose a square with many dots";
1,3,2,1,24,15,6,"Choose a square with few dots";
1,3,2,2,24,15,6,"Choose a square with many dots";
1,4,1,1,6,15,24,"Choose the square with the fewest dots";
1,4,1,2,6,15,24,"Choose the square with the most dots";
1,4,2,1,24,15,6,"Choose the square with the fewest dots";
1,4,2,2,24,15,6,"Choose the square with the most dots";
2,1,1,1,16,25,34,"Choose a square with about 20 dots";
2,1,1,2,16,25,34,"Choose a square with about 30 dots";
2,1,2,1,34,25,16,"Choose a square with about 20 dots";
2,1,2,2,34,25,16,"Choose a square with about 30 dots";
2,2,1,1,16,25,34,"Choose the square with 16 dots";
2,2,1,2,16,25,34,"Choose the square with 34 dots";
2,2,2,1,34,25,16,"Choose the square with 16 dots";
2,2,2,2,34,25,16,"Choose the square with 34 dots";
2,3,1,1,16,25,34,"Choose a square with few dots";
2,3,1,2,16,25,34,"Choose a square with many dots";
2,3,2,1,34,25,16,"Choose a square with few dots";
2,3,2,2,34,25,16,"Choose a square with many dots";
2,4,1,1,16,25,34,"Choose the square with the fewest dots";
2,4,1,2,16,25,34,"Choose the square with the most dots";
2,4,2,1,34,25,16,"Choose the square with the fewest dots";
2,4,2,2,34,25,16,"Choose the square with the most dots";
3,1,1,1,26,35,44,"Choose a square with about 30 dots";
3,1,1,2,26,35,44,"Choose a square with about 40 dots";
3,1,2,1,44,35,26,"Choose a square with about 30 dots";
3,1,2,2,44,35,26,"Choose a square with about 40 dots";
3,2,1,1,26,35,44,"Choose the square with 26 dots";
3,2,1,2,26,35,44,"Choose the square with 44 dots";
3,2,2,1,44,35,26,"Choose the square with 26 dots";
3,2,2,2,44,35,26,"Choose the square with 44 dots";
3,3,1,1,26,35,44,"Choose a square with few dots";
3,3,1,2,26,35,44,"Choose a square with many dots";
3,3,2,1,44,35,26,"Choose a square with few dots";
3,3,2,2,44,35,26,"Choose a square with many dots";
3,4,1,1,26,35,44,"Choose the square with the fewest dots";
3,4,1,2,26,35,44,"Choose the square with the most dots";
3,4,2,1,44,35,26,"Choose the square with the fewest dots";
3,4,2,2,44,35,26,"Choose the square with the most dots";
4,1,1,1,36,45,54,"Choose a square with about 40 dots";
4,1,1,2,36,45,54,"Choose a square with about 50 dots";
4,1,2,1,54,45,36,"Choose a square with about 40 dots";
4,1,2,2,54,45,36,"Choose a square with about 50 dots";
4,2,1,1,36,45,54,"Choose the square with 36 dots";
4,2,1,2,36,45,54,"Choose the square with 54 dots";
4,2,2,1,54,45,36,"Choose the square with 36 dots";
4,2,2,2,54,45,36,"Choose the square with 54 dots";
4,3,1,1,36,45,54,"Choose a square with few dots";
4,3,1,2,36,45,54,"Choose a square with many dots";
4,3,2,1,54,45,36,"Choose a square with few dots";
4,3,2,2,54,45,36,"Choose a square with many dots";
4,4,1,1,36,45,54,"Choose the square with the fewest dots";
4,4,1,2,36,45,54,"Choose the square with the most dots";
4,4,2,1,54,45,36,"Choose the square with the fewest dots";
4,4,2,2,54,45,36,"Choose the square with the most dots"
};

numberOfBlocks = 4;
if testing ==1 
 numberOfBlocks=1;
 end
numberOfTrials = 64;
if testing == 1
 numberOfTrials = 4;
 end
numberOfColumns = 8;

for iterateBlocks = 1:numberOfBlocks

	% do randomisation
	% alternate a version of item 1 with a version of item 2 with a version of item 3 with a version of item 4
	IN = exp3stimuli;
	OUT = cell(numberOfTrials, numberOfColumns);
	A = randperm((numberOfTrials/4));
	B = randperm(numberOfTrials/4)+(numberOfTrials/4);
	C = randperm(numberOfTrials/4)+(2*numberOfTrials/4);
	D = randperm(numberOfTrials/4)+(3*numberOfTrials/4);
	nrows=0;
	for iterations=1:(numberOfTrials/4)
	    nrows=nrows+1;
	    rowFromA = A(iterations);
	        for cols=1:numberOfColumns
	            OUT{nrows,cols}=IN{rowFromA,cols};
	        end
	    nrows=nrows+1;
	    rowFromB = B(iterations);
	        for cols=1:numberOfColumns
	            OUT{nrows,cols}=IN{rowFromB,cols};
	        end
	    nrows=nrows+1;
	    rowFromC = C(iterations);
	        for cols=1:numberOfColumns
	            OUT{nrows,cols}=IN{rowFromC,cols};
	        end
	    nrows=nrows+1;
	    rowFromD = D(iterations);
	        for cols=1:numberOfColumns
	            OUT{nrows,cols}=IN{rowFromD,cols};
	        end
	end
	runningOrder=OUT;

	% declare trial variables
    Item = cell(numberOfTrials,1);
    ConditionID = cell(numberOfTrials,1);
    Order = cell(numberOfTrials,1);
    Quantity = cell(numberOfTrials,1);
    Left = cell(numberOfTrials,1);
    Mid = cell(numberOfTrials,1);
    Right = cell(numberOfTrials,1);
    Instruction = cell(numberOfTrials,1);

  	% fill, extract trial variables
    for trial = 1:numberOfTrials
        Item(trial)         = runningOrder{trial,1};
        ConditionID(trial)  = runningOrder{trial,2};
        Order(trial)        = runningOrder{trial,3};
        Quantity(trial)     = runningOrder{trial,4};
        Left(trial)         = runningOrder{trial,5};
        Mid(trial)          = runningOrder{trial,6};
        Right(trial)        = runningOrder{trial,7};
        Instruction(trial)  = runningOrder{trial,8};
    end

		for trial=1:numberOfTrials
	        % Get the instruction ready
	        trialMessage = Instruction(trial){};

		    % Get the selection of dot positions ready
		    perm = randperm(100);
		    leftdots = dots(:,perm(1:Left(trial){}));
		    perm = randperm(100);
		    middots = dots(:,perm(1:Mid(trial){}));
		    perm = randperm(100);
		    rightdots = dots(:,perm(1:Right(trial){}));

		    % Draw the instruction to the back buffer
		    DrawFormattedText(w, trialMessage, 'center', messagey, BlackIndex(w));

		    % Flip to show the trialMessage
		    Screen('Flip',w);
		    
	    if takescreenshot==1
	       imageArray = Screen('GetImage', w, [0 0 1280 800]);
	       imwrite(imageArray, 'fakescreenshots/screenshot6_TrialMessage.bmp');
	    end


		    % Wait for keypress on Spacebar and release
		    KbReleaseWait;
		    RestrictKeysForKbCheck([spacebar,escapekey]); % only allow spacebar to dismiss trialmessage or escapekey to abort
		    KbWait();
		    KbReleaseWait;

		    % Show the dots, repeating the instructions

		    % Put left square to backbuffer
		    Screen('FrameRect', w, 000000000, leftBox, 1);

		    % Put some dots in left square in backbuffer
		    Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);

		    % Put mid square to backbuffer
		    Screen('FrameRect', w, 000000000, midBox, 1);

		    % Put some dots in right square in backbuffer
		    Screen('DrawDots', w, middots, 9, [], midCenter, 1);

		    % Put right square to backbuffer
		    Screen('FrameRect', w, 000000000, rightBox, 1);

		    % Put some dots in right square in backbuffer
		    Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1);

		    % repeat the instruction

		    % Draw the instruction to the back buffer
		    DrawFormattedText(w, trialMessage, 'center', messagey, BlackIndex(w));

		    % Flip the display
		    [VBLTimestamp startrt] = Screen('Flip', w);
	    if takescreenshot==1
	       imageArray = Screen('GetImage', w, [0 0 1280 800]);
	       imwrite(imageArray, 'fakescreenshots/screenshot7_TrialResponseScreen.bmp');
	    end
		    % Wait for a key  press

		    RestrictKeysForKbCheck([leftresp,middleresp,rightresp,escapekey]);
		    while (GetSecs - startrt) <= howLongToWaitForAResponse
		         [keyIsDown, endrt, keyCode] = KbCheck;
		         if ( keyCode(leftresp)==1 || keyCode(middleresp)==1 || keyCode(rightresp)==1 )
		             break;
		         end
		         if keyCode(escapekey)==1
		             error("aborted");
		         end
		         % Wait 1 ms before checking the keyboard again to prevent overload of the machine at elevated Priority():
		         WaitSecs(0.001);
		    end %endwhile

		    % Evaluate the key press for RT
	        RT = round(1000*(endrt-startrt)); % RT in ms

	        % Evaluate key press for which key was pressed
            actualAnswer="NOANSWER";	        
	        if keyCode(leftresp)==1
	            actualAnswer="LEFT";
	        elseif keyCode(middleresp)==1
	            actualAnswer="MIDDLE";
	        elseif keyCode(rightresp)==1
	            actualAnswer="RIGHT";
	        end

        % Write trial result to file

        fprintf(outputFilePointer, ...
                '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%s\n', ...
                Item(trial){} ,...
                ConditionID(trial){},...
                Order(trial){}    ,...
                Quantity(trial){}     ,...
                Left(trial){}         ,...
                Mid(trial){}          ,...
                Right(trial){}        ,...
                strcat('"',Instruction(trial){},'"')  ,...
                SUBJECT, ...
                RT, ...
                actualAnswer)

	end % end of trials
	
	% Instructions for end of block
	
	if iterateBlocks==1
		% Text to back buffer
	    DrawFormattedText(w, endOfBlock1Text, 50, messagey, BlackIndex(w));
	    % Flip to screen
	    Screen('Flip',w);
	    % Wait for key press on Return to dismiss
	    RestrictKeysForKbCheck([returnkey])
	    KbWait();
	    % Go to grey screen
	    Screen(w,'FillRect',gray);
	    Screen('Flip', w);
	elseif iterateBlocks==2
		% Text to back buffer
	    DrawFormattedText(w, endOfBlock2Text, 50, messagey, BlackIndex(w));
	    % Flip to screen
	    Screen('Flip',w);
	    % Wait for key press on Return to dismiss
	    RestrictKeysForKbCheck([returnkey])
	    KbWait();
	    % Go to grey screen
	    Screen(w,'FillRect',gray);
	    Screen('Flip', w);
    elseif iterateBlocks==3
		% Text to back buffer
	    DrawFormattedText(w, endOfBlock3Text, 50, messagey, BlackIndex(w));
	    % Flip to screen
	    Screen('Flip',w);
	    % Wait for key press on Return to dismiss
	    RestrictKeysForKbCheck([returnkey])
	    KbWait();
	    % Go to grey screen
	    Screen(w,'FillRect',gray);
	    Screen('Flip', w);
	end

end % end of blocks

    %%%%%%%%%%%%%%%%%%%%
    % GOODBYE
    %%%%%%%%%%%%%%%%%%%%

    % Text to back buffer
    DrawFormattedText(w, goodbyeText, 50, messagey, BlackIndex(w));
    % Flip to screen
    Screen('Flip',w);
    % Wait for key press to dismiss
    RestrictKeysForKbCheck([escapekey]);
    KbWait();
    KbReleaseWait;

    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    Screen('CloseAll');
    fclose('all');

catch
	% oops stuff here
	% show oops text
	%
    % Text to back buffer
    DrawFormattedText(w, oopsText, 50, messagey, BlackIndex(w));

    % Flip to screen
    Screen('Flip',w);

    % Wait for key press to dismiss
    RestrictKeysForKbCheck([spacebar,escapekey]);
    KbReleaseWait;
    KbWait();
    KbReleaseWait;

    % Go to grey screen
    Screen(w,'FillRect',gray);
    Screen('Flip', w);

    Screen('CloseAll');
    fclose('all');

    % Output the error message that describes the error:
    psychrethrow(psychlasterror);
end_try_catch

