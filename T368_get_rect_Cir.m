function [positionscale_T,positionscale_NT] = T368_get_rect_Cir(setsize,squ_length,T_POS,NT_POS) 
switch(setsize)
    case 1 % ss3
        positionscale_T(:,1)  = T368_simul_get_position(squ_length/2,[T_POS(1,1) T_POS(1,2)]);
        positionscale_NT(:,1)  = T368_simul_get_position(squ_length/2,[NT_POS(1,1) NT_POS(1,2)]);
        positionscale_NT(:,2)  = T368_simul_get_position(squ_length/2,[NT_POS(2,1) NT_POS(2,2)]);
    case 2 % ss6
        positionscale_T(:,1)  = T368_simul_get_position(squ_length/2,[T_POS(1,1) T_POS(1,2)]);
        positionscale_NT(:,1)  = T368_simul_get_position(squ_length/2,[NT_POS(1,1) NT_POS(1,2)]);
        positionscale_NT(:,2)  = T368_simul_get_position(squ_length/2,[NT_POS(2,1) NT_POS(2,2)]);
        positionscale_NT(:,3)  = T368_simul_get_position(squ_length/2,[NT_POS(3,1) NT_POS(3,2)]);
        positionscale_NT(:,4)  = T368_simul_get_position(squ_length/2,[NT_POS(4,1) NT_POS(4,2)]);
        positionscale_NT(:,5)  = T368_simul_get_position(squ_length/2,[NT_POS(5,1) NT_POS(5,2)]);
    case 3 % ss8
        positionscale_T(:,1)  = T368_simul_get_position(squ_length/2,[T_POS(1,1) T_POS(1,2)]);
        positionscale_NT(:,1)  = T368_simul_get_position(squ_length/2,[NT_POS(1,1) NT_POS(1,2)]);
        positionscale_NT(:,2)  = T368_simul_get_position(squ_length/2,[NT_POS(2,1) NT_POS(2,2)]);
        positionscale_NT(:,3)  = T368_simul_get_position(squ_length/2,[NT_POS(3,1) NT_POS(3,2)]);
        positionscale_NT(:,4)  = T368_simul_get_position(squ_length/2,[NT_POS(4,1) NT_POS(4,2)]);
        positionscale_NT(:,5)  = T368_simul_get_position(squ_length/2,[NT_POS(5,1) NT_POS(5,2)]);
        positionscale_NT(:,6)  = T368_simul_get_position(squ_length/2,[NT_POS(6,1) NT_POS(6,2)]);
        positionscale_NT(:,7)  = T368_simul_get_position(squ_length/2,[NT_POS(7,1) NT_POS(7,2)]);
end
end