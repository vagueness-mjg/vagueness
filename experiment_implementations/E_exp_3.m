function experiment_e(SUBJECT)

diary on;
more off;
newLevel=3; % adjust verbosity
oldLevel = Screen('Preference', 'Verbosity', [newLevel]);
ListenChar(2); % disable keyboard input to octave while running experiment (no echo to terminal)
% If we are in testing mode then do skip synch tests, If we are in real mode don't skip synch tests
skipTestValue=0
if SUBJECT >99
	skipTestValue=1
end


Screen('Preference', 'SkipSyncTests', skipTestValue); % 0 = don't skip sync tests; 1 = do skip run sync tests

% VARIABLES
howLongToWaitForAResponse = 10; % in seconds. Set low for test runs
timeOutTime = 2; % in seconds.
maskDuration = 1; % in seconds
interTrialDelay = 1; % in seconds
leftBox  = [170 300 370 500];
midBox   = [540 300 740 500];
rightBox = [910 300 1110 500];
leftCenter  = [270 400];
midCenter   = [640 400];
rightCenter = [1010 400];
messagey = 150; 
instructionY = 400;
instructionX = 100;
gray=127.5;
white=225;
black=0;
startrt=0;   % initialise start rt variable
endrt=0;     % initialise end rt variable
instruction_on_time=0;
instruction_off_time=0;
numberOfBlocks = 4; % 1 is practice, 2 is block1, 3 is block2, 4 is block3
numberOfColumns = 9; % there are always 9 columns in the input
rand('state',sum(100*clock));

% COMMANDS
% Clear Matlab/Octave window:
clc;
% check for Opengl compatibility, abort otherwise:
AssertOpenGL;
% Make sure keyboard mapping is the same on all supported operating systems
KbName('UnifyKeyNames');
% Define keys by ID
leftresp=KbName('c'); 
middleresp=KbName('b'); 
rightresp=KbName('m'); 
escapekey=KbName('ESCAPE'); 
spacebar=KbName('space'); 
returnkey=KbName('return'); 
% read separate files containing dotlocations, stimuli, and strings 
source('e5stimuli.m');
source('e5strings.m');
source('e5dotlocations.m');

% set up output files
% practice data output file to write to
practicedatafilename = strcat('output/practice/subject',...
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
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
'Sub',...
'Trl',...
'Itm',...
'Cnd',...
'Ord',...
'Qty',...
'Prm',...
'Lft',...
'Mid',...
'Rgt',...
'key',...
'rt',...
'Ins');
    outputFilePointerForPracticeTrials = ...
        fopen(practicedatafilename,'wt');
        fprintf(outputFilePointerForPracticeTrials,...
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
'Sub',...
'Trl',...
'Itm',...
'Cnd',...
'Ord',...
'Qty',...
'Prm',...
'Lft',...
'Mid',...
'Rgt',...
'key',...
'rt',...
'Ins');
end

% Get screenNumber of stimulation display.
screens=Screen('Screens');
screenNumber=max(screens);

% OPEN THE SCREEN
[w,rect]=Screen('OpenWindow',screenNumber,gray,[],[],[],[],2,[],[],[]);
HideCursor;

% State your text property preferences
Screen('TextFont',w, 'Helvetica');
Screen('TextSize',w, 32);
Screen('TextStyle', w, 1);

try % wrap the whole experiment including introductory text in try catch

% Show experiment-wide instructions 
DrawFormattedText(w, instructionText, 0, 0, white);
Screen('Flip', w);

% Wait for key press on (Return) to dismiss the experiment-wide instructions
KbReleaseWait();
RestrictKeysForKbCheck([returnkey]);
KbWait();
RestrictKeysForKbCheck();
Screen('FillRect',w,gray,[]);
Screen('Flip', w);

% Start iterating through the blocks
for iterateBlocks = 1:numberOfBlocks
	% determine whether we are in a practice block or not and 
	% set variables for stimuli and output file pointer accordingly
	switch (iterateBlocks)
		case 1
			IN=e5practicestimuli;
			xFilePointer=outputFilePointerForPracticeTrials;
			numberOfTrials=4;
		otherwise
			IN=e5stimuli;
			xFilePointer=outputFilePointer;
			numberOfTrials=64;
	endswitch
	
	% do randomisation for each block separately
	% alternate a version of item 1 with a version of item 2 with a version of item 3 with a version of item 4
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

    % Initialise trial variables
	Item = cell(numberOfTrials,1);
	ConditionID = cell(numberOfTrials,1);
	Order = cell(numberOfTrials,1);
	Quantity = cell(numberOfTrials,1);
    	Left = cell(numberOfTrials,1);
    	Mid = cell(numberOfTrials,1);
    	Right = cell(numberOfTrials,1);
    	Instruction = cell(numberOfTrials,1);
    	Prime = cell(numberOfTrials,1);
    

    % Set values of trial variables
    	for trial = 1:numberOfTrials
        	Item(trial)         = runningOrder{trial,1};
        	ConditionID(trial)  = runningOrder{trial,2};
        	Order(trial)        = runningOrder{trial,3};
        	Quantity(trial)     = runningOrder{trial,4};
        	Left(trial)         = runningOrder{trial,5};
        	Mid(trial)          = runningOrder{trial,6};
        	Right(trial)        = runningOrder{trial,7};
        	Instruction(trial)  = runningOrder{trial,8};
            Prime(trial)        = runningOrder{trial,9};
    	end

    
	for trial=1:numberOfTrials

        % Elevate priority while inside the trial loop
        Priority(1);

        % Get ready for the trial
        trialMessage = Instruction(trial){};
		primeperm = randperm(100);
        	primedots = dots(:,primeperm(1:Prime(trial){}));

		perm = randperm(100);
		leftdots = dots(:,perm(1:Left(trial){}));
		perm = randperm(100);
		middots = dots(:,perm(1:Mid(trial){}));
		perm = randperm(100);
		rightdots = dots(:,perm(1:Right(trial){}));
		
		% Present the instruction. Subject presses space key to dismiss the instruction.
       		DrawFormattedText(w, trialMessage, 'center', 'center', white);
		Screen('Flip',w); 
        	KbReleaseWait;
        	RestrictKeysForKbCheck([spacebar]);
        	KbWait();

		% Present a mask for a specified duration
		Screen('FillRect',w,gray,[]);
		Screen('Flip', w);
		WaitSecs(maskDuration);
                
		% Present the prime for a specified duration.
 		Screen('FrameRect',w, 125125125, midBox,2);
		Screen('DrawDots', w, primedots, 9, [], midCenter, 2); 
		Screen('Flip', w);
		WaitSecs(timeOutTime);
		
		% Present a mask for a specified duration
		Screen('FillRect',w,gray,[]);
		Screen('Flip', w);
		WaitSecs(maskDuration);

        % Elevate priority for the important part of the trial.
        priorityLevel=MaxPriority(w);
        Priority(priorityLevel);

        % Prepare the 3square stimulus in the backbuffer
		Screen('FrameRect', w, 125125125, leftBox, 2);
		Screen('DrawDots', w, leftdots, 9, [], leftCenter, 2);
		Screen('FrameRect', w, 125125125, midBox, 2);
		Screen('DrawDots', w, middots, 9, [], midCenter, 2);
		Screen('FrameRect', w, 125125125, rightBox, 2);
		Screen('DrawDots', w, rightdots, 9, [], rightCenter, 2); 

        % Show the stimulus and start the recording of rt
		[VBLTimestamp startrt] = Screen('Flip', w);

        % Record the response inside a while loop that times out
        KbReleaseWait; % prevent keyboard repeat
		RestrictKeysForKbCheck([leftresp,middleresp,rightresp,escapekey]);
		while (GetSecs - startrt) <= howLongToWaitForAResponse
			[keyIsDown, endrt, keyCode] = KbCheck; % stop RT timer on keypress
			if ( keyCode(leftresp)==1 || keyCode(middleresp)==1 || keyCode(rightresp)==1 )
		        	break;
			end
            if keyCode(escapekey)==1
		        	error('I quitted because you aborted by pressing escape');
            end
		    % Wait 1 ms before checking the keyboard again to prevent overload of the machine at elevated Priority():
		    WaitSecs(0.001);
		end % end while loop for response collection

		% Compute the response time
        rt = round(1000*(endrt-startrt));

        % Convert keypress to response
		actualAnswer='NA';	        
	    if keyCode(leftresp)==1
            actualAnswer='L';
        elseif keyCode(middleresp)==1
            actualAnswer='M';
	    elseif keyCode(rightresp)==1
	        actualAnswer='R';
        end

        % Write trial result to file
		fprintf(xFilePointer, ...
                '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\t%d\t%s\n', ...
                SUBJECT, ...
                trial+100, ...
                Item(trial){} ,...
                ConditionID(trial){},...
                Order(trial){}    ,...
                Quantity(trial){}     ,...
                Prime(trial){}      ,...
                Left(trial){}         ,...
                Mid(trial){}          ,...
                Right(trial){}        ,...
                actualAnswer, ...
                rt,...
                trialMessage);

        % Take priority level down
        Priority(0);

		% go to gray screen and wait a specified time between trials
		Screen(w,'FillRect',gray);
		Screen('Flip', w);
		WaitSecs(interTrialDelay); % introduce a small delay between trials

    end % end of trials
	
	% Select handover text
	switch (iterateBlocks)
		case 1 % 1 is end of practice block 1/4
			handovertext=sprintf(strcat(...
        			'The practice trials are now over.\n',...
        			'The experimenter will leave the room.\n',...
        			'Press Return to start the experiment.'));
		case 2 % is end of 2/4
	    		handovertext=sprintf(strcat(...
       				'Please take a short break before the next block\n\n',...
       				'You have completed 1 of 3 blocks.\n\n',...
        			'Press Return to continue with the second block'));
		case 3 % is end of 3/4
	    		handovertext=sprintf(strcat(...
       				'Please take a short break before the next block\n\n',...
       				'You have completed 2 of 3 blocks.\n\n',...
        			'Press Return to continue with the last block'));
		case 4 % 4 is end of 4/4 so GOODBYE
			handovertext=sprintf(strcat(...
        			'The experiment is now finished.\n\n',...
       				'Thank you very much for participating\n\n',...
        			'Please tell the experimenter that you have finished.'));
		% else there is no end of block instruction after block4, because that is the end and the end text is shown instead
	endswitch % end of loop to select handover text between blocks

	% Draw the selected handover text and wait for return to be pressed
	DrawFormattedText(w, handovertext, 'center','center', white);
	Screen('Flip',w);
	RestrictKeysForKbCheck([returnkey]);
	KbWait();

	Screen(w,'FillRect',gray);
	Screen('Flip', w);

	% Add a proper close for standard goodbye in the case that this is the last block
	if iterateBlocks==4
		ListenChar(1); % re-enables echo to terminal
		Screen('CloseAll');
		fclose('all');	
		Priority(0);
		diary off;
		Screen('Preference', 'Verbosity', oldLevel);
	end

end % end of blocks

catch
	Screen(w,'FillRect',gray);
	DrawFormattedText(w, oopsText, 'center', 'center', white);
	Screen('Flip',w);
	RestrictKeysForKbCheck([escapekey, returnkey]);
   	KbReleaseWait;
    KbWait();
    KbReleaseWait;
    Screen(w,'FillRect',gray);
    Screen('Flip', w);
    Screen('CloseAll');
    fclose('all');
	Priority(0);
    ListenChar(1); % re-enables echo to terminal. Must be put before the screen closes
	% Output the error message that describes the error:
    psychrethrow(psychlasterror);
	Screen('Preference', 'Verbosity', oldLevel);
	diary off;

end_try_catch

