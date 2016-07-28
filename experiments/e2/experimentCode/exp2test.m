function exp3test(SUBJECT)
SUBJECT=1001;

% Clear Matlab/Octave window:
clc;

% check for Opengl compatibility, abort otherwise:
AssertOpenGL;

screenNumber = 0;

% Returns as default the mean gray value of screen:
gray=GrayIndex(screenNumber);

% [windowPtr,rect]=SCREEN(windowPtrOrScreenNumber,'OpenWindow',[color],[rect],[pixelSize]);
% [w, rect] = Screen(screenNumber, 'OpenWindow', gray, [1,1,801,601],[]);
[w, rect] = Screen(screenNumber, 'OpenWindow', gray, [],[]);
    
% Set text size
Screen('TextSize', w, 32);

try

instructionText = sprintf(strcat...
         ('You will see 3 squares with dots in them, and an instruction\n',...
         'to choose one of them, as in the picture above.\n\n',...
         'First you see the instruction, then press space to see the squares.\n\n',...
         'Use the keys C, B, or M to choose the square that you think matches\n',...
         'the instruction best. There will be some practice trials so you\n',...
         'can get used to the routine.'));
         
instructionY = 200;
instructionX = 100;

% Text of introductory instructions to back buffer
DrawFormattedText(w, instructionText, instructionX, instructionY, WhiteIndex(w));

% Flip introductory instructions to screen
Screen('Flip', w);

% Wait for key press
KbWait();

% Go to grey screen
Screen(w,'FillRect',gray);
Screen('Flip', w);
Screen('CloseAll');

catch

Screen('CloseAll');

end_try_catch