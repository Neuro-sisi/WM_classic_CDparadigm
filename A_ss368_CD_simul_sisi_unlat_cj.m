%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHANGE DETECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CD--cj
% 2021-11-21 sisi wang, small revision
% 2019-03-27 sisi
clear;clc
%% change detection with NO distractors
% set parameters
clear;clc
pix_per_cm = 832/30;
% pix_per_cm = 1920/43;
% pix_per_cm = 1920/53.3;%change this to resolution/width of your computer 832*624
fix_length = round(2*tand(PARAMETER.deg(1)/2)*75*pix_per_cm);
squ_length = 2*tand(PARAMETER.deg(2)/2)*75*pix_per_cm;
cir_width(1) = 2*tand(PARAMETER.deg(3)/2)*75*pix_per_cm;
cir_width(2) = 2*tand(PARAMETER.deg(4)/2)*75*pix_per_cm;
cir_width(3) = 2*tand(PARAMETER.deg(5)/2)*75*pix_per_cm;

%% read configurations
% trial_number should be 12*
SubNum = input('please input Subject Number:     ','s');
BlockNum = input('please input Block Number:      ');
TrialNum = input('please input Trial Number(144):     ');


%% set setsizes
% set size = [3 6 8] 
for i = 1:TrialNum/3
    PARAMETER.setsize(3*(i-1)+1:3*i,1) = randperm(3)';
end
% change/unchange 1-change 2-unchange
INDEX_S3 = find(PARAMETER.setsize == 1);
INDEX_S6 = find(PARAMETER.setsize == 2);
INDEX_S8 = find(PARAMETER.setsize == 3);
for i3 = 1:size(INDEX_S3)/2
    PARAMETER.chanot([INDEX_S3(i3*2-1) INDEX_S3(i3*2)],1) = randperm(2)';
end
for i6 = 1:size(INDEX_S6)/2
    PARAMETER.chanot([INDEX_S6(i6*2-1) INDEX_S6(i6*2)],1) = randperm(2)';
end
for i8 = 1:size(INDEX_S8)/2
    PARAMETER.chanot([INDEX_S8(i8*2-1) INDEX_S8(i8*2)],1) = randperm(2)';
end

%% open window 
Screens = Screen('Screens');
ScreenNum = max(Screens); 
SCREEN.width =832; SCREEN.height = 624; 
% SCREEN.width =1920; SCREEN.height = 1080;
SCREEN.center = [round(SCREEN.width/2) round(SCREEN.height/2)];
% [WINDOW, WRect] = Screen('OpenWindow', ScreenNum, [125 125 125], [0,0,832,624],[], [], [], 4);
[WINDOW, WRect]=Screen(1,'OpenWindow',[125 125 125],[0,0,832,624]);
priorityLevel = MaxPriority(WINDOW);
Priority(priorityLevel);
% [WINDOW, WRect] = Screen('OpenWindow', ScreenNum, [125 125 125], [0,0,1920,1080],[], [], [], 4);
[X0,Y0] = WindowCenter(WINDOW);
SCREEN.point = [X0,Y0];

%% set break time
break_after = 48;
%% quit program
quit_key = 'q'; %% press this button at any time to quit the experiment

%%        
for trial = 1:TrialNum
    %% Break 
    if mod(trial,break_after) == 1 && trial == 1
        Screen('TextFont',WINDOW,'Arial')
        Screen('TextSize',WINDOW,20);
        Screen('FillRect',WINDOW,[192 192 192])
        DrawFormattedText(WINDOW,['Get ready to start!\n\nMake sure to ONLY blink between your button press and the next trial.\n\nPlease never move your eyes!\n\nButton J =  "change", Button F = "no change"\n\nPress SPACE to begin'],'center','center',[0,0,0]);
        Screen('Flip',WINDOW); 

        KbName('UnifyKeyNames');  
        key_continue = KbName('space');  
        reaction = 0;
        while (reaction == 0);   
            [KeyIsDown, secs, KeyCode] = KbCheck;
            if KeyCode(key_continue);
                break;
            end;
        end
        KbWait;    
        Pblank=Screen(WINDOW,'OpenOffscreenWindow',[128,128,128],[],32);
        Screen('Flip',WINDOW);
        
    elseif mod(trial,break_after) == 1 && trial > 1
        Screen('TextFont',WINDOW,'Arial')
        Screen('TextSize',WINDOW,20);
        Screen('FillRect',WINDOW,[192 192 192]);
        DrawFormattedText(WINDOW,['Take a short break.\n\n' num2str(TrialNum-trial+1) ' trials left to go in this block.\n\nYour response accuracy until now is' num2str(sum(ACC(1:trial))/length(ACC(1:trial))) '\n\n Button F =  "change", Button J = "no change"\n\nPress SPACE to resume the experient.'],'center','center',[0,0,0]);
        Screen('Flip',WINDOW);
        
        % save all results to a temporal file
        save (fullfile (['Temp_UnlaterCD368_sub' num2str(SubNum)  '_Block' num2str(BlockNum) '_miniblock' num2str((trial-1)/break_after) 'cj.mat']));

        KbName('UnifyKeyNames'); 
        key_continue = KbName('space');   
        reaction = 0;
        while (reaction == 0);   
            [KeyIsDown, secs, KeyCode] = KbCheck;
            if KeyCode(key_continue);
                break;
            end;
        end
        KbWait;    
        Pblank=Screen(WINDOW,'OpenOffscreenWindow',[128,128,128],[],32);
        Screen('Flip',WINDOW);
    end
    
    %% FIX
    HideCursor;
    Screen('FillRect',WINDOW,[192 192 192]);
    Screen('TextSize',WINDOW,fix_length);
    DrawFormattedText(WINDOW,('+'),'center','center',[0 0 0],[],[],[],[]); 
    Screen('Flip',WINDOW);
    WaitSecs(0.2);
    
    %% STIMULUS
    % % set two quandrants
%     deg_r(:,1) = [50 75 100 125];
%     deg_r(:,2) = [60 80 100 120];
%     deg_r(:,3) = [60 80 100 120];
%     deg_l(:,1) = [230 255 280 305];
%     deg_l(:,2) = [240 260 280 300];
%     deg_l(:,3) = [240 260 280 300];
    deg_r(:,1) = [30 70 110 150];
    deg_r(:,2) = [30 70 110 150];
    deg_r(:,3) = [30 70 110 150];
    deg_l(:,1) = [210 250 290 330];
    deg_l(:,2) = [210 250 290 330];
    deg_l(:,3) = [210 250 290 330];
    % Choose position degrees
    deg_loca_r = T368_CHANGE2POSITION(deg_r,cir_width,SCREEN.center);
    deg_loca_l = T368_CHANGE2POSITION(deg_l,cir_width,SCREEN.center);
    
    % Change degrees to position scale
    [T_POS{trial},NT_POS{trial},Tside{trial}] = T368_chooseLoc(PARAMETER.setsize(trial),deg_loca_r,deg_loca_l);
    
    % get rect (x,y axises)
    [positionscale_T{trial},positionscale_NT{trial}] = T368_get_rect_Cir(PARAMETER.setsize(trial),squ_length,T_POS{trial},NT_POS{trial});
    
    % Choose colors for squares
    [T_col{trial},NT_col{trial},P_col{trial}] = T368_randcolor(PARAMETER.chanot(trial),PARAMETER.setsize(trial));
    
    Screen('FillRect',WINDOW,[192 192 192]);
    Screen('TextSize',WINDOW,fix_length);
    DrawFormattedText(WINDOW,('+'),'center','center',[0 0 0],[],[],[],[]);
    
    % draw squares
    if PARAMETER.setsize(trial) == 1 % ss3
        Screen('FillRect',WINDOW,T_col{trial}(1,:),positionscale_T{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(1,:),positionscale_NT{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(2,:),positionscale_NT{trial}(:,2));
    elseif PARAMETER.setsize(trial) == 2 % ss3
        Screen('FillRect',WINDOW,T_col{trial}(1,:),positionscale_T{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(1,:),positionscale_NT{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(2,:),positionscale_NT{trial}(:,2));
        Screen('FillRect',WINDOW,NT_col{trial}(3,:),positionscale_NT{trial}(:,3));
        Screen('FillRect',WINDOW,NT_col{trial}(4,:),positionscale_NT{trial}(:,4));
        Screen('FillRect',WINDOW,NT_col{trial}(5,:),positionscale_NT{trial}(:,5));
    elseif PARAMETER.setsize(trial) == 3 % ss3
        Screen('FillRect',WINDOW,T_col{trial}(1,:),positionscale_T{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(1,:),positionscale_NT{trial}(:,1));
        Screen('FillRect',WINDOW,NT_col{trial}(2,:),positionscale_NT{trial}(:,2));
        Screen('FillRect',WINDOW,NT_col{trial}(3,:),positionscale_NT{trial}(:,3));
        Screen('FillRect',WINDOW,NT_col{trial}(4,:),positionscale_NT{trial}(:,4));
        Screen('FillRect',WINDOW,NT_col{trial}(5,:),positionscale_NT{trial}(:,5));
        Screen('FillRect',WINDOW,NT_col{trial}(6,:),positionscale_NT{trial}(:,6));
        Screen('FillRect',WINDOW,NT_col{trial}(7,:),positionscale_NT{trial}(:,7));
    end
    Screen('Flip',WINDOW);
    WaitSecs(0.25);       
    
    % DELAY
    Screen('FillRect',WINDOW,[192 192 192]);
    Screen('TextSize',WINDOW,fix_length);
    DrawFormattedText(WINDOW,('+'),'center','center',[0 0 0],[],[],[],[]); 
    Screen('Flip',WINDOW);
    WaitSecs(1); %delay 1000ms
    
    % TEST
    Screen('FillRect',WINDOW,[192 192 192]);
    Screen('TextSize',WINDOW,fix_length);
    DrawFormattedText(WINDOW,('+'),'center','center',[0 0 0],[],[],[],[]); 
    % draw squares 1-change 2-unchange
    Screen('FillRect',WINDOW,P_col{trial}(1,:),positionscale_T{trial}(:,1));
    Screen('Flip',WINDOW);
    time1 = GetSecs;   % record onset time of test array

    % % RESPONSE
    % % 'j'-change 'f'-unchange
    KbName('UnifyKeyNames');   
    key_res1 = KbName('j');
    key_res2 = KbName('f');
    key_quit = KbName('escape');
    reaction = 0;
    while (reaction == 0)  % press f/j continue
        [KeyIsDown, secs, KeyCode] = KbCheck;
        if KeyCode(key_res1)||KeyCode(key_res2)
            break
        end
        
        if KeyCode(key_quit)
            sca
        end
    end
    KbWait;    % press F/J to continue, press Q to stop the program
    Pblank=Screen(WINDOW,'OpenOffscreenWindow',[128,128,128],[],32);
    Screen('Flip',WINDOW);
    
    % % get RT
    time2 = GetSecs; % time1 the onset of test array
    RT(trial) = time2 - time1; 
    % % get ACC
    % % 'j'-change 'f'-unchange
    if KeyCode(key_res1) == 1 && PARAMETER.chanot(trial) == 1
        ACC(trial) = 1;
        ROC(trial) = 1; % hit
    elseif KeyCode(key_res2) == 1 && PARAMETER.chanot(trial) == 1
        ACC(trial) = 0;
        ROC(trial) = 2; % miss
    elseif KeyCode(key_res1) == 1 && PARAMETER.chanot(trial) == 2
        ACC(trial) = 0;
        ROC(trial) = 3; % false alarm
    elseif KeyCode(key_res2) == 1 && PARAMETER.chanot(trial) == 2
        ACC(trial) = 1;
        ROC(trial) = 4; % correct rejection
    end
    
    % % ITI
    Screen('FillRect',WINDOW,[192 192 192]); 
    Screen('Flip',WINDOW);
    b = randsample([1000:50:1500],1);
    WaitSecs(b/1000);
    
end

%% performance calculation
RT_mean = mean(RT);
ACC_rate = sum(ACC)/length(ACC);

Screen('TextFont',WINDOW,'Arial')
Screen('TextSize',WINDOW,20);
Screen('FillRect',WINDOW,[192 192 192]);
DrawFormattedText(WINDOW, ['Experiment Finished.\n\nYour Response Accuracy is ' num2str(ACC_rate) '.\n\nPlease call the experimenter!'], 'center', 'center', [0 0 0]);
Screen('Flip', WINDOW);
KbStrokeWait;
sca;

save (fullfile (['UnlaterCD368_sub' SubNum  '_' num2str(BlockNum) '_cj.mat']));
Screen('CloseAll');

disp(['Mean_response_accuracy: ',num2str(ACC_rate)]);
disp(['Mean_RT: ',num2str(RT_mean)]);
