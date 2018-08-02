% In this experiment 5 numbers are avoided throughout.

%%%%%%%%%%%%%%%%%%%%%%
% define stimuli
%%%%%%%%%%%%%%%%%%%%%%

% a column named _order_ in headers gives a answer to 
% 'Which square had a small quantity'? and does not give a correct response

% Condition 1 is vague matching: Choose a square with about the same number of dots as the target
% Condition 2 is crisp matching: Choose a square with the same number of dots as the target
% Condition 3 is vague comparison: Choose a square with far more/fewer dots than the target
% Condition 4 is crisp comparison: Choose a square with more/fewer dots than the target
%
% Order 1 is small number on left
% Order 2 is small number on right
%
% Quantity 1 is small
% Quantity 2 is big

% Column headers
% Item,ConditionID,Order,Quantity,Left,Mid,Right,Instruction,Prime

e5practicestimuli = {
0,0,0,0,6,15,24, 'Choose a square with about the same number of dots as the target',10;     % vague matching
0,0,0,0,34,25,16,'Choose a square with the same number of dots as the target',16;           % crisp matching
0,0,0,0,44,35,26,'Choose a square with far fewer dots than the target',40;                  % vague comparison
0,0,0,0,36,45,54,'Choose a square with more dots than the target',40};                      % crisp comparison

e5stimuli={
% item 1 
1,1,1,1,6,15,24,'Choose a square with about the same number of dots as the target',10;
1,1,1,2,6,15,24,'Choose a square with about the same number of dots as the target',20;
1,1,2,1,24,15,6,'Choose a square with about the same number of dots as the target',10;
1,1,2,2,24,15,6,'Choose a square with about the same number of dots as the target',20;
1,2,1,1,6,15,24,'Choose a square with the same number of dots as the target',6;
1,2,1,2,6,15,24,'Choose a square with the same number of dots as the target',24;
1,2,2,1,24,15,6,'Choose a square with the same number of dots as the target',6;
1,2,2,2,24,15,6,'Choose a square with the same number of dots as the target',24;
1,3,1,1,6,15,24,'Choose a square with far fewer dots than the target',20;
1,3,1,2,6,15,24,'Choose a square with far more dots than the target',10;
1,3,2,1,24,15,6,'Choose a square with far fewer dots than the target',20;
1,3,2,2,24,15,6,'Choose a square with far more dots than the target',10;
1,4,1,1,6,15,24,'Choose a square with fewer dots than the target',20;
1,4,1,2,6,15,24,'Choose a square with more dots than the target',10;
1,4,2,1,24,15,6,'Choose a square with fewer dots than the target',20;
1,4,2,2,24,15,6,'Choose a square with more dots than the target',10;
% item 2
2,1,1,1,16,25,34,'Choose a square with about the same number of dots as the target',20;
2,1,1,2,16,25,34,'Choose a square with about the same number of dots as the target',30;
2,1,2,1,34,25,16,'Choose a square with about the same number of dots as the target',20;
2,1,2,2,34,25,16,'Choose a square with about the same number of dots as the target',30;
2,2,1,1,16,25,34,'Choose a square with the same number of dots as the target',16;
2,2,1,2,16,25,34,'Choose a square with the same number of dots as the target',34;
2,2,2,1,34,25,16,'Choose a square with the same number of dots as the target',16;
2,2,2,2,34,25,16,'Choose a square with the same number of dots as the target',34;
2,3,1,1,16,25,34,'Choose a square with far fewer dots than the target',30;
2,3,1,2,16,25,34,'Choose a square with far more dots than the target',20;
2,3,2,1,34,25,16,'Choose a square with far fewer dots than the target',30;
2,3,2,2,34,25,16,'Choose a square with far more dots than the target',20;
2,4,1,1,16,25,34,'Choose a square with fewer dots than the target',30;
2,4,1,2,16,25,34,'Choose a square with more dots than the target',20;
2,4,2,1,34,25,16,'Choose a square with fewer dots than the target',30;
2,4,2,2,34,25,16,'Choose a square with more dots than the target',20;
% item 3
3,1,1,1,26,35,44,'Choose a square with about the same number of dots as the target',30;
3,1,1,2,26,35,44,'Choose a square with about the same number of dots as the target',40;
3,1,2,1,44,35,26,'Choose a square with about the same number of dots as the target',30;
3,1,2,2,44,35,26,'Choose a square with about the same number of dots as the target',40;
3,2,1,1,26,35,44,'Choose a square with the same number of dots as the target',26;
3,2,1,2,26,35,44,'Choose a square with the same number of dots as the target',44;
3,2,2,1,44,35,26,'Choose a square with the same number of dots as the target',26;
3,2,2,2,44,35,26,'Choose a square with the same number of dots as the target',44;
3,3,1,1,26,35,44,'Choose a square with far fewer dots than the target',40;
3,3,1,2,26,35,44,'Choose a square with far more dots than the target',30;
3,3,2,1,44,35,26,'Choose a square with far fewer dots than the target',40;
3,3,2,2,44,35,26,'Choose a square with far more dots than the target',30;
3,4,1,1,26,35,44,'Choose a square with fewer dots than the target',40;
3,4,1,2,26,35,44,'Choose a square with more dots than the target',30;
3,4,2,1,44,35,26,'Choose a square with fewer dots than the target',40;
3,4,2,2,44,35,26,'Choose a square with more dots than the target',30;
% item 4
4,1,1,1,36,45,54,'Choose a square with about the same number of dots as the target',40;
4,1,1,2,36,45,54,'Choose a square with about the same number of dots as the target',50;
4,1,2,1,54,45,36,'Choose a square with about the same number of dots as the target',40;
4,1,2,2,54,45,36,'Choose a square with about the same number of dots as the target',50;
4,2,1,1,36,45,54,'Choose a square with the same number of dots as the target',36;
4,2,1,2,36,45,54,'Choose a square with the same number of dots as the target',54;
4,2,2,1,54,45,36,'Choose a square with the same number of dots as the target',36;
4,2,2,2,54,45,36,'Choose a square with the same number of dots as the target',54;
4,3,1,1,36,45,54,'Choose a square with far fewer dots than the target',50;
4,3,1,2,36,45,54,'Choose a square with far more dots than the target',40;
4,3,2,1,54,45,36,'Choose a square with far fewer dots than the target',50;
4,3,2,2,54,45,36,'Choose a square with far more dots than the target',40;
4,4,1,1,36,45,54,'Choose a square with fewer dots than the target',50;
4,4,1,2,36,45,54,'Choose a square with more dots than the target',40;
4,4,2,1,54,45,36,'Choose a square with fewer dots than the target',50;
4,4,2,2,54,45,36,'Choose a square with more dots than the target',40};

