function [T_col,NT_col,P_col] = T368_randcolor(chanot,setsize)
load 'stimuli_color_9.mat'
col_loc = randperm(9);
switch(setsize)
    case 1 % ss3
        T_col(1,:) = stimuli_color(col_loc(1),:); % s1
        NT_col(1:2,:) = stimuli_color(col_loc(2:3),:); % s1
    case 2 % ss6
        T_col(1,:) = stimuli_color(col_loc(1),:); % s1
        NT_col(1:5,:) = stimuli_color(col_loc(2:6),:); % s1
    case 3 % ss8
        T_col(1,:) = stimuli_color(col_loc(1),:); % s1
        NT_col(1:7,:) = stimuli_color(col_loc(2:8),:); % s1
end
% test array
if chanot == 1 % change
    P_col(1,:) = stimuli_color(col_loc(9),:); % s1
elseif chanot == 2 % UNchange
    P_col(1,:) = T_col(1,:); % s1
end
end
