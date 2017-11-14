clc;
clear all;
close all;
%%
%preprocessing
load('final_data');
data_r = [Final_DATA{1};Final_DATA{2};Final_DATA{3}];
label_r = data_r(:,end);
lk = cell(72,1);
lk(label_r==1) = {'pleased'};
lk(label_r==0) = {'neutral'};
lk(label_r==-1) = {'unpleased'};
data = data_r(:,1:end-3);
miss_k = 100;
iter = 0;
his = [];
%%
%Get Optimal Decision Tree
while(miss_k>30)
    iter = iter+1;
    idxt = false(72,1);
    idxt(randsample(72,round(0.7*72))) = true;
    idxv = idxt == false;
    t = fitctree(data(idxt,:),lk(idxt));
    label = predict(t,data(idxv,:));
    miss_k = (sum(~strcmp(lk(idxv),label))/length(label))*100;
    his = [his;miss_k];
    disp({'Iteration -',iter});
end
%%
%%Draw important factor
disp({'Accuracy -',100-miss_k});
view(t,'Mode','graph');
imp = predictorImportance(t);
figure;
bar(imp);
ylabel('Estimates');
xlabel('Predictors');
h = gca;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';