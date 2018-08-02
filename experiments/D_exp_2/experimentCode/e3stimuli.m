%%%%%%%%%%%%%%%%%%%%%%
% define stimuli
%%%%%%%%%%%%%%%%%%%%%%

% a column named _order_ in headers gives a answer to 
% 'Which square had a small quantity'? and does not give a correct response

%Condition 1 is numerical vague matching
%Condition 2 is numerical crisp matching
%Condition 3 is numerical vague comparison
%Condition 4 is numerical crisp comparison
%
%Order 1 is small number on left
%Order 2 is small number on right
%
%Quantity 1 is small
%Quantity 2 is big

e4headers={
	'Item','Condition','Order','Quantity','Left','Mid','Right','Instruction'};

e4practicestimuli = {
	0,0,0,0,6,15,24,'Choose a square with about 10 dots';               % numerical vague matching
	0,0,0,0,34,25,16,'Choose a square with 16 dots';                    % numerical crisp matching
	0,0,0,0,44,35,26,'Choose a square with far fewer than 40 dots';     % numerical vague comparison
	0,0,0,0,36,45,54,'Choose a square with more than 40 dots'} ;        % numerical crisp comparison


e4stimuli={
% item 1 
1,1,1,1,6,15,24,'Choose a square with about 10 dots'; 		% numerical vague matching, small q on left, identify small
1,1,1,2,6,15,24,'Choose a square with about 20 dots'; 		% numerical vague matching, small q on left, identify large
1,1,2,1,24,15,6,'Choose a square with about 10 dots'; 		% numerical vague matching, small q on right, identify small
1,1,2,2,24,15,6,'Choose a square with about 20 dots'; 		% numerical vague matching, small q on right, identify large
1,2,1,1,6,15,24,'Choose a square with 6 dots';            	% numerical crisp matching, small q on left, identify small
1,2,1,2,6,15,24,'Choose a square with 24 dots';           	% numerical crisp matching, small q on left, identify large
1,2,2,1,24,15,6,'Choose a square with 6 dots';            	% numerical crisp matching, small q on right, identify small
1,2,2,2,24,15,6,'Choose a square with 24 dots';           	% numerical crisp matching, small q on right, identify large
1,3,1,1,6,15,24,'Choose a square with far fewer than 20 dots';	% numerical vague comparison, small q on left, identify small
1,3,1,2,6,15,24,'Choose a square with far more than 10 dots';	% numerical vague comparison, small q on left, identify large
1,3,2,1,24,15,6,'Choose a square with far fewer than 20 dots';	% numerical vague comparison, small q on right, identify small 
1,3,2,2,24,15,6,'Choose a square with far more than 10 dots';	% numerical vague comparison, small q on right, identify large
1,4,1,1,6,15,24,'Choose a square with fewer than 20 dots';	% numerical crisp comparison, small q on left, identify small
1,4,1,2,6,15,24,'Choose a square with more than 10 dots';	% numerical crisp comparison, small q on left, identify large
1,4,2,1,24,15,6,'Choose a square with fewer than 20 dots';	% numerical crisp comparison, small q on right, identify small
1,4,2,2,24,15,6,'Choose a square with more than 10 dots';	% numerical crisp comparison, small q on right, identify large
% item 2
2,1,1,1,16,25,34,'Choose a square with about 20 dots';		% numerical vague matching, small q on left, identify small
2,1,1,2,16,25,34,'Choose a square with about 30 dots';		% numerical vague matching, small q on left, identify large
2,1,2,1,34,25,16,'Choose a square with about 20 dots';		% numerical vague matching, small q on right, identify small
2,1,2,2,34,25,16,'Choose a square with about 30 dots';		% numerical vague matching, small q on right, identify large
2,2,1,1,16,25,34,'Choose a square with 16 dots';		% numerical crisp matching, small q on left, identify small
2,2,1,2,16,25,34,'Choose a square with 34 dots';		% numerical crisp matching, small q on left, identify large
2,2,2,1,34,25,16,'Choose a square with 16 dots';		% numerical crisp matching, small q on right, identify small
2,2,2,2,34,25,16,'Choose a square with 34 dots';		% numerical crisp matching, small q on right, identify large
2,3,1,1,16,25,34,'Choose a square with far fewer than 30 dots';	% numerical vague comparison, small q on left, identify small
2,3,1,2,16,25,34,'Choose a square with far more than 20 dots';	% numerical vague comparison, small q on left, identify large
2,3,2,1,34,25,16,'Choose a square with far fewer than 30 dots';	% numerical vague comparison, small q on right, identify small 
2,3,2,2,34,25,16,'Choose a square with far more than 20 dots';	% numerical vague comparison, small q on right, identify large
2,4,1,1,16,25,34,'Choose a square with fewer than 30 dots';	% numerical crisp comparison, small q on left, identify small
2,4,1,2,16,25,34,'Choose a square with more than 20 dots';	% numerical crisp comparison, small q on left, identify large
2,4,2,1,34,25,16,'Choose a square with fewer than 30 dots';	% numerical crisp comparison, small q on right, identify small
2,4,2,2,34,25,16,'Choose a square with more than 20 dots';	% numerical crisp comparison, small q on right, identify large
% item 3
3,1,1,1,26,35,44,'Choose a square with about 30 dots';
3,1,1,2,26,35,44,'Choose a square with about 40 dots';
3,1,2,1,44,35,26,'Choose a square with about 30 dots';
3,1,2,2,44,35,26,'Choose a square with about 40 dots';
3,2,1,1,26,35,44,'Choose a square with 26 dots';
3,2,1,2,26,35,44,'Choose a square with 44 dots';
3,2,2,1,44,35,26,'Choose a square with 26 dots';
3,2,2,2,44,35,26,'Choose a square with 44 dots';
3,3,1,1,26,35,44,'Choose a square with far fewer than 40 dots';
3,3,1,2,26,35,44,'Choose a square with far more than 30 dots';
3,3,2,1,44,35,26,'Choose a square with far fewer than 40 dots';
3,3,2,2,44,35,26,'Choose a square with far more than 30 dots';
3,4,1,1,26,35,44,'Choose a square with fewer than 40 dots';
3,4,1,2,26,35,44,'Choose a square with more than 30 dots';
3,4,2,1,44,35,26,'Choose a square with fewer than 40 dots';
3,4,2,2,44,35,26,'Choose a square with more than 30 dots';
% item 4
4,1,1,1,36,45,54,'Choose a square with about 40 dots';
4,1,1,2,36,45,54,'Choose a square with about 50 dots';
4,1,2,1,54,45,36,'Choose a square with about 40 dots';
4,1,2,2,54,45,36,'Choose a square with about 50 dots';
4,2,1,1,36,45,54,'Choose a square with 36 dots';
4,2,1,2,36,45,54,'Choose a square with 54 dots';
4,2,2,1,54,45,36,'Choose a square with 36 dots';
4,2,2,2,54,45,36,'Choose a square with 54 dots';
4,3,1,1,36,45,54,'Choose a square with far fewer than 50 dots';
4,3,1,2,36,45,54,'Choose a square with far more than 40 dots';
4,3,2,1,54,45,36,'Choose a square with far fewer than 50 dots';
4,3,2,2,54,45,36,'Choose a square with far more than 40 dots';
4,4,1,1,36,45,54,'Choose a square with fewer than 50 dots';
4,4,1,2,36,45,54,'Choose a square with more than 40 dots';
4,4,2,1,54,45,36,'Choose a square with fewer than 50 dots';
4,4,2,2,54,45,36,'Choose a square with more than 40 dots'
};

