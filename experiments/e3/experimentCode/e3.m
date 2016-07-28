function e4(SUBJECT)
ListenChar(2); % disable keyboard input to octave while running experiment (no echo to terminal)
Screen('Preference', 'SkipSyncTests', 0); % 0 = do run sync tests; 1 = do not run sync tests
% variables
howLongToWaitForAResponse = 60; % seconds. Set low for test runs
% Clear Matlab/Octave window:
clc;
% check for Opengl compatibility, abort otherwise:
AssertOpenGL;
% Reseed the random-number generator for each expt.
rand('state',sum(100*clock));
% Make sure keyboard mapping is the same on all supported operating systems
KbName('UnifyKeyNames');
% Define keys by ID
leftresp=KbName('c'); % is 6
middleresp=KbName('b'); % is 5
rightresp=KbName('m'); % is 16
escapekey=KbName('ESCAPE'); % is 41
spacebar=KbName('space'); % is 44
returnkey=KbName('return'); % is 40
% read separate files containing dotlocations, stimuli, and strings 
source('e4stimuli.m');
source('e4strings.m');
source('e4dotlocations.m');

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
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
            'Item','Condition','Order','Quantity','Left','Mid','Right','Instruction','Subject','Instruction_RT','RESPONSE','RT')
    outputFilePointerForPracticeTrials = ...
        fopen(practicedatafilename,'wt');
        fprintf(outputFilePointerForPracticeTrials,...
            '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n',...
            'Item','Condition','Order','Quantity','Left','Mid','Right','Instruction','Subject','Instruction_RT','RESPONSE','RT')
end

% initialise screen stuff  %
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
% set other variables
messagey = 150; % y location for message
instructionY = 400;
instructionX = 100;
gray=127.5;

% Introductory instructions
try % wrap the whole experiment including introductory text in try catch
% Open a double buffered fullscreen window on the stimulation screen
%[w,rect] = Screen('OpenWindow', 0, gray, [0 0 1280 800]);
[w,rect]=Screen('OpenWindow',0,gray,[0 0 1280 800]);
HideCursor;
% Set text size
Screen('TextSize', w, 32);
% initialise variables to reduce lag
startrt=0;   % initialise start rt variable
endrt=0;     % initialise end rt variable
instruction_on_time=0;
instruction_off_time=0;
% Text of introductory instructions to back buffer
DrawFormattedText(w, instructionText, instructionX, instructionY, WhiteIndex(w));
% Flip backbuffer containing the introductory instructions to screen
Screen('Flip', w);

% Wait for key press on (Return) to dismiss the introductory instructions
RestrictKeysForKbCheck([returnkey]); % says which keypresses are allowed
KbWait(); % waits for a permissible keypress to dismiss the introductory instructions
% Go to grey screen
Screen(w,'FillRect',127.5);
Screen('Flip', w);

% EXPERIMENTAL SESSION
% Declare block structure
numberOfBlocks = 4; % 1 is practice, 2=block1, 3=block2, 4=block3
numberOfColumns = 8; % there are always 8 columns in the output
% Start iterating through the blocks
for iterateBlocks = 1:numberOfBlocks
	% determine whether we are in a practice block or not and 
	% set variables for stimuli and output file pointer accordingly
	switch (iterateBlocks)
		case 1
			IN=e4practicestimuli;
			xFilePointer=outputFilePointerForPracticeTrials;
			numberOfTrials=4;
		otherwise
			IN=e4stimuli;
			xFilePointer=outputFilePointer;
			numberOfTrials=64;
	endswitch
	% do randomisation
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
		DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
    		% Flip to show the trialMessage
		WaitSecs(0.1);
		% Set priority for script execution to realtime priority:
		priorityLevel=MaxPriority(w);
		Priority(priorityLevel);			
		[VBLTimestamp instruction_on_time]=Screen('Flip',w); % start a timer for instruction_reading_time
    		% Wait for keypress on Spacebar and release
		KbReleaseWait;
	    	RestrictKeysForKbCheck([spacebar,escapekey]); % only allow spacebar to dismiss trialmessage or escapekey to abort
		while (GetSecs - instruction_on_time) <= howLongToWaitForAResponse
			[keyIsDown, instruction_off_time, keyCode] = KbCheck;
			if keyCode(spacebar)==1
		        	break;
			end
		        if keyCode(escapekey)==1
		        	error('aborted');
		        end
			% Wait 1 ms before checking the keyboard again to prevent overload of the machine at elevated Priority():
			WaitSecs(0.001);
		end % endwhile
		% Show the dots, repeating the instructions
		% Evaluate the key press for RT
	        instruction_RT = round(1000*(instruction_off_time-instruction_on_time)); % compute RT in ms by subtraction
	    	% Put left square to backbuffer
		Screen('FrameRect', w, 125125125, leftBox, 1);
		% Put some dots in left square in backbuffer
		Screen('DrawDots', w, leftdots, 9, [], leftCenter, 1);
	    	% Put mid square to backbuffer
		Screen('FrameRect', w, 125125125, midBox, 1);
    		% Put some dots in right square in backbuffer
		Screen('DrawDots', w, middots, 9, [], midCenter, 1);
		% Put right square to backbuffer
		Screen('FrameRect', w, 125125125, rightBox, 1);
		% Put some dots in right square in backbuffer
		Screen('DrawDots', w, rightdots, 9, [], rightCenter, 1); 
		% Draw the instruction to the back buffer
		DrawFormattedText(w, trialMessage, 'center', messagey, WhiteIndex(w));
		% Flip the display and start RT timer
                % Wait for a key  press
		[VBLTimestamp startrt] = Screen('Flip', w);
		RestrictKeysForKbCheck([leftresp,middleresp,rightresp,escapekey]);
		while (GetSecs - startrt) <= howLongToWaitForAResponse
			[keyIsDown, endrt, keyCode] = KbCheck; % stop RT timer on keypress
			if ( keyCode(leftresp)==1 || keyCode(middleresp)==1 || keyCode(rightresp)==1 )
		        	break;
			end
		        if keyCode(escapekey)==1
		        	error('aborted');
		        end
		        % Wait 1 ms before checking the keyboard again to prevent overload of the machine at elevated Priority():
		        WaitSecs(0.001);
		end %endwhile
		% Evaluate the key press for RT
	        RT = round(1000*(endrt-startrt)); % compute RT in ms by subtraction
	        % Evaluate key press for which key was pressed
		actualAnswer='NOANSWER';	        
	        if keyCode(leftresp)==1
	            actualAnswer='LEFT';
	        elseif keyCode(middleresp)==1
	            actualAnswer='MIDDLE';
	        elseif keyCode(rightresp)==1
	            actualAnswer='RIGHT';
	        end % endif
        	% Write trial result to file
		fprintf(xFilePointer, ...
                	'%d\t%d\t%d\t%d\t%d\t%d\t%d\t%s\t%d\t%d\t%s\t%d\n', ...
                	Item(trial){} ,...
                	ConditionID(trial){},...
                	Order(trial){}    ,...
                	Quantity(trial){}     ,...
                	Left(trial){}         ,...
                	Mid(trial){}          ,...
                	Right(trial){}        ,...
                	strcat("\'",Instruction(trial){},"\'")  ,...
                	SUBJECT, ...
                	instruction_RT, ...
                	actualAnswer, ...
			RT);
		% go to gray screen and wait a sec between trials
		Screen(w,'FillRect',gray);
		Screen('Flip', w);
		WaitSecs(.7); % introduce a small delay between trials
	end % end of trials
	% Switch selects instructions for end of block
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
	% draw the selected handover text	
	DrawFormattedText(w, handovertext, 50, messagey, WhiteIndex(w));
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
	end
end % end of blocks

% error handling by catch
catch
	DrawFormattedText(w, oopsText, 50, 400, 255);
	Screen('Flip',w);
	RestrictKeysForKbCheck([escapekey, returnkey]);
    	KbReleaseWait;
    	KbWait();
    	KbReleaseWait;
    	Screen(w,'FillRect',gray);
    	Screen('Flip', w);
	ListenChar(1); % re-enables echo to terminal. Must be put before the screen closes
    	Screen('CloseAll');
    	fclose('all');
	Priority(0);
    	% Output the error message that describes the error:
    	psychrethrow(psychlasterror);
end_try_catch

