function [pleasure,neutral,unpleasure]  = getsignal(RAW,a)


%%% Without Rest

%%% Get data
emg = RAW(:,a);

%%% Removing DC offset of the EMG Signal
emg2 = detrend(emg);

%%% Rectification of the EMG signal
emg2 = abs(emg2);

%%% Sort the data with emotion
Pleasant_Experience(:,1) = emg(305100-60000+1:305100);
Pleasant_Experience(:,2) = emg(1087130-60000+1:1087130);
Pleasant_Experience(:,3) = emg(1338000-60000+1:1338000);

Pleasant_Observation(:,1) = emg(39630-30000+1:39630);
Pleasant_Observation(:,2) = emg(714200-30000+1:714200);
Pleasant_Observation(:,3) = emg(994870-30000+1:994870);


Neutral_Experience(:,1) = emg(131970-60000+1:131970);
Neutral_Experience(:,2) = emg(464030-60000+1:464030);
Neutral_Experience(:,3) = emg(806270-60000+1:806270);

Neutral_Observation(:,1) = emg(530430-30000+1:530430);
Neutral_Observation(:,2) = emg(1181300-30000+1:1181300);
Neutral_Observation(:,3) = emg(1405100-30000+1:1405100);



Unpleasant_Experience(:,1) = emg(622370-60000+1:622370);
Unpleasant_Experience(:,2) = emg(903330-60000+1:903330);
Unpleasant_Experience(:,3) = emg(1486470-60000+1:1486470);

Unpleasant_Observation(:,1) = emg(198300-30000+1:198300);
Unpleasant_Observation(:,2) = emg(372270-30000+1:372270);
Unpleasant_Observation(:,3) = emg(1242900-30000+1:1242900);



%%% Initialize emotion vector
pleasure = zeros(6,1);
neutral = zeros(6,1);
unpleasure = zeros(6,1);


%%% Calculate RMS of signals
for k = 1:3
    
    pleasure(k) =(sum(Pleasant_Experience(:,k).^2)/length(Pleasant_Experience(:,k)))^(1/2);
end

for k = 1:3
    
    pleasure(k+3) =(sum(Pleasant_Observation(:,k).^2)/length(Pleasant_Observation(:,k)))^(1/2);
end


for k = 1:3
    
    unpleasure(k) =(sum(Unpleasant_Experience(:,k).^2)/length(Unpleasant_Experience(:,k)))^(1/2);
end

for k = 1:3
    
    unpleasure(k+3) =(sum(Unpleasant_Observation(:,k).^2)/length(Unpleasant_Observation(:,k)))^(1/2);
end


for k = 1:3
    
    neutral(k) =(sum(Neutral_Experience(:,k).^2)/length(Neutral_Experience(:,k)))^(1/2);
end

for k = 1:3
    
    neutral(k+3) =(sum(Neutral_Observation(:,k).^2)/length(Neutral_Observation(:,k)))^(1/2);
end


end