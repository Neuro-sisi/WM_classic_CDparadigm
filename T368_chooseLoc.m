function [T_POS,NT_POS,Tside] = T368_chooseLoc(setsize,deg_loca_r,deg_loca_l)
switch(setsize)
    case 1 % ss3
        loc_seqr = randperm(12);
        loc_seql = randperm(12);
        Tside = randsample(2,1); % Tside=1--target right; Tside=2--target left
        LorR = randsample(2,1);
        if Tside == 1 && LorR == 1
            T = loc_seqr(1);
            NT = loc_seql(1:2);
            T_POS = deg_loca_r(T,:);
            NT_POS = deg_loca_l(NT,:);
        elseif Tside == 1 && LorR == 2
            T = loc_seqr(1);
            NT(1) = loc_seqr(2);
            NT(2) = loc_seql(1);
            T_POS = deg_loca_r(T,:);
            NT_POS(1,:) = deg_loca_r(NT(1),:);
            NT_POS(2,:) = deg_loca_l(NT(2),:);
        elseif Tside == 2 && LorR == 1
            T = loc_seql(1);
            NT = loc_seqr(1:2);
            T_POS = deg_loca_l(T,:);
            NT_POS = deg_loca_r(NT,:);
        elseif Tside == 2 && LorR == 2
            T = loc_seql(1);
            NT(1) = loc_seql(2);
            NT(2) = loc_seqr(1);
            T_POS = deg_loca_l(T,:);
            NT_POS(1,:) = deg_loca_l(NT(1),:);
            NT_POS(2,:) = deg_loca_r(NT(2),:);
        end
    case 2 % ss6
        loc_seqr = randperm(12);
        loc_seql = randperm(12);
        Tside = randsample(2,1);
        if Tside == 1
            T = loc_seqr(1);
            NT(1:2) = loc_seqr(2:3);
            NT(3:5) = loc_seql(1:3);
            T_POS = deg_loca_r(T,:);
            NT_POS(1:2,:) = deg_loca_r(NT(1:2),:);
            NT_POS(3:5,:) = deg_loca_l(NT(3:5),:);
        elseif Tside == 2
            T = loc_seql(1);
            NT(1:2) = loc_seql(2:3);
            NT(3:5) = loc_seqr(1:3);
            T_POS = deg_loca_l(T,:);
            NT_POS(1:2,:) = deg_loca_l(NT(1:2),:);
            NT_POS(3:5,:) = deg_loca_r(NT(3:5),:);
        end
    case 3 % ss8
        loc_seqr = randperm(12);
        loc_seql = randperm(12);
        Tside = randsample(2,1);
        if Tside == 1
            T = loc_seqr(1);
            NT(1:3) = loc_seqr(2:4);
            NT(4:7) = loc_seql(1:4);
            T_POS = deg_loca_r(T,:);
            NT_POS(1:3,:) = deg_loca_r(NT(1:3),:);
            NT_POS(4:7,:) = deg_loca_l(NT(4:7),:);
        elseif Tside == 2
            T = loc_seql(1);
            NT(1:3) = loc_seql(2:4);
            NT(4:7) = loc_seqr(1:4);
            T_POS = deg_loca_l(T,:);
            NT_POS(1:3,:) = deg_loca_l(NT(1:3),:);
            NT_POS(4:7,:) = deg_loca_r(NT(4:7),:);
        end
end
end