clear all

for k = 1:9
    if (k==1)
        load('PCH_0731_final.mat')
    elseif (k==2)
        load('OYK_0913_final.mat')
    elseif (k==3)
         load('KJH_0811_final.mat')
    elseif (k==4)
        load('JMW_0811_final.mat')
    elseif (k==5)
        load('JKJ_0731_final.mat')
    elseif (k==6)
        load('JCE_0907_final.mat')
    elseif (k==7)
        load('HYR_0907_final.mat')
    elseif (k==8)
        load ('CJM_0726_final.mat')
    elseif(k==9)
        load ('LJO_0622_final.mat')
    end
    
    
    a = 2;
    
    [pleasure,neutral,unpleasure] = getsignal_rms(RAW,a); %% When a =  2 , EMG // a= 1, ECG
    concat = [pleasure;neutral;unpleasure];
    emotion(1:3) = 1;
    emotion(4:6) = 2;
    emotion(7:9) = 3;
    emotion(10:12) = 4;
    emotion(13:15) = 5;
    emotion(16:18) = 6;
    
    subplot(3,3,k);
    
    scatter(concat,emotion);  hold on; grid on;
    
end

%%legend('PCH_0731_final.mat','OYK_0913_final.mat','KJH_0811_final.mat','JMW_0811_final.mat','JKJ_0731_final.mat','JCE_0907_final.mat','HYR_0907_final.mat')
%%axis([0 1 0 4])    