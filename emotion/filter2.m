Final_DATA = cell(1,3);
J = 1;
K = 1;
H = 1;
for k = 1:8
    
    %clear all
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
    end
    
    
    
    %for j = 1:2
    
    gamma_mean = zeros(18, 8);
    gamma_std = zeros(18, 8);
    gamma_var = zeros(18, 8);
    beta_mean = zeros(18, 8);
    beta_std = zeros(18, 8);
    beta_var = zeros(18, 8);
    alpha_mean = zeros(18, 8);
    alpha_var = zeros(18, 8);
    alpha_std = zeros(18, 8);
    theta_mean = zeros(18, 8);
    theta_std = zeros(18, 8);
    theta_var = zeros(18, 8);
    delta_mean = zeros(18, 8);
    delta_std = zeros(18, 8);
    delta_var = zeros(18, 8);
    
    check = 1;
    
    for j = 1:18
        
        cell = DATA{1,j};
        
        for i = 4:11
            
            x = cell(:,i);
            
            if j == 2 || j == 4 || j == 6 || j == 8 || j == 10 || j == 11 || j == 13 || j == 16
                s = x;
            elseif j == 18
                s = x;
            else
                continue;
            end
            
            %figure;
            %p=plot(s);
            %title('EEG Signal')
            
            fs = 1000;
            % Sampling frequency
            
            N=length(s);
            
            
            waveletFunction = 'db8';
            [C,L] = wavedec(s,8,waveletFunction);
            
            cD1 = detcoef(C,L,1);
            cD2 = detcoef(C,L,2);
            cD3 = detcoef(C,L,3);
            cD4 = detcoef(C,L,4);
            cD5 = detcoef(C,L,5); %GAMA
            cD6 = detcoef(C,L,6); %BETA
            cD7 = detcoef(C,L,7); %ALPHA
            cD8 = detcoef(C,L,8); %THETA
            cA8 = appcoef(C,L,waveletFunction,8); %DELTA
            D1 = wrcoef('d',C,L,waveletFunction,1);
            D2 = wrcoef('d',C,L,waveletFunction,2);
            D3 = wrcoef('d',C,L,waveletFunction,3);
            D4 = wrcoef('d',C,L,waveletFunction,4);
            D5 = wrcoef('d',C,L,waveletFunction,5); %GAMMA
            D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
            D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
            D8 = wrcoef('d',C,L,waveletFunction,8); %THETA
            A8 = wrcoef('a',C,L,waveletFunction,8); %DELTA
            
            Gamma = D5;
            %figure; subplot(5,1,1); plot(1:1:length(Gamma),Gamma);title('GAMMA');
            
            Beta = D6;
            %subplot(5,1,2); plot(1:1:length(Beta), Beta); title('BETA');
            
            
            Alpha = D7;
            %subplot(5,1,3); plot(1:1:length(Alpha),Alpha); title('ALPHA');
            
            Theta = D8;
            %subplot(5,1,4); plot(1:1:length(Theta),Theta);title('THETA');
            D8 = detrend(D8,0);
            
            Delta = A8;
            %figure, plot(0:1/fs:1,Delta);
            %subplot(5,1,5);plot(1:1:length(Delta),Delta);title('DELTA');
            
            D5 = detrend(D5,0);
            xdft = fft(D5);
            xdft = xdft(1:length(D5)/2+1);
            %ป๙วร
            freq = 0:50/length(xdft(1:end/10)):50;
            %figure;
            %subplot(511);
            gamma = abs(xdft(1:end/10+1));
            normalized_gamma = (gamma-min(gamma))/(max(gamma)-min(gamma));
            %plot(freq,normalized_gamma);
            %title('GAMMA-FREQUENCY');
            [~,I] = max(abs(xdft));
            %fprintf('Gamma:Maximum occurs at %3.2f Hz.\n',freq(I));
            
            gamma_mean(j,i-3) = mean(normalized_gamma(length(xdft)/(fs/2)*30:length(xdft)/(fs/2)*50));
            gamma_var(j,i-3) = var(normalized_gamma(length(xdft)/(fs/2)*30:length(xdft)/(fs/2)*50));
            gamma_std(j,i-3) = std(normalized_gamma(length(xdft)/(fs/2)*30:length(xdft)/(fs/2)*50));
            
            
            D6 = detrend(D6,0);
            xdft2 = fft(D6);
            %%minmax(abs(xdft2));
            xdft2 = xdft2(1:length(D6)/2+1);
            freq2 = 0:50/length(xdft2(1:end/10)):50;
            % figure;
            %subplot(512);
            beta = abs(xdft2(1:end/10+1));
            normalized_beta = (beta-min(beta))/(max(beta)-min(beta));
            %plot(freq2,normalized_beta);
            %title('BETA');
            [~,I] = max(abs(xdft2));
            %fprintf('Beta:Maximum occurs at %3.2f Hz.\n',freq2(I));
            beta_mean(j,i-3) = mean(normalized_beta(length(xdft2)/(fs/2)*13:length(xdft2)/(fs/2)*30));
            beta_var(j,i-3) = var(normalized_beta(length(xdft2)/(fs/2)*13:length(xdft2)/(fs/2)*30));
            beta_std(j,i-3) = std(normalized_beta(length(xdft2)/(fs/2)*13:length(xdft2)/(fs/2)*30));
            
            
            D7 = detrend(D7,0);
            xdft3 = fft(D7);
            xdft3 = xdft3(1:length(D7)/2+1);
            freq3 = 0:50/length(xdft3(1:end/10)):50;
            % figure;
            %subplot(513);
            alpha = abs(xdft3(1:end/10+1));
            normalized_alpha = (alpha-min(alpha))/(max(alpha)-min(alpha));
            %plot(freq3,normalized_alpha);
            %title('ALPHA');
            [~,I] = max(abs(xdft3));
            %fprintf('Alpha:Maximum occurs at %f Hz.\n',freq3(I));
            alpha_mean(j,i-3) = mean(normalized_alpha(length(xdft3)/(fs/2)*8:length(xdft3)/(fs/2)*13));
            alpha_var(j,i-3) = var(normalized_alpha(length(xdft3)/(fs/2)*8:length(xdft3)/(fs/2)*13));
            alpha_std(j,i-3) = std(normalized_alpha(length(xdft3)/(fs/2)*8:length(xdft3)/(fs/2)*13));
            
            
            
            xdft4 = fft(D8);
            xdft4 = xdft4(1:length(D8)/2+1);
            freq4 = 0:50/length(xdft4(1:end/10)):50;
            % figure;
            %subplot(514);
            theta = abs(xdft4(1:end/10+1));
            normalized_theta = (theta-min(theta))/(max(theta)-min(theta));
            %plot(freq4,normalized_theta);
            %title('THETA');
            [~,I] = max(abs(xdft4));
            %fprintf('Theta:Maximum occurs at %f Hz.\n',freq4(I));
            theta_mean(j,i-3) = mean(normalized_theta(length(xdft4)/(fs/2)*4:length(xdft4)/(fs/2)*8));
            theta_var(j,i-3) = var(normalized_theta(length(xdft4)/(fs/2)*4:length(xdft4)/(fs/2)*8));
            theta_std(j,i-3) = std(normalized_theta(length(xdft4)/(fs/2)*4:length(xdft4)/(fs/2)*8));
            
            
            A8 = detrend(A8,0);
            xdft5 = fft(A8);
            xdft5 = xdft5(1:length(A8)/2+1);
            freq5 = 0:50/length(xdft5(1:end/10)):50;
            % figure;
            %subplot(515);
            delta = abs(xdft5(1:end/10+1));
            normalized_delta = (delta-min(delta))/(max(delta)-min(delta));
            %plot(freq5,normalized_delta);
            %title('DELTA');
            [~,I] = max(abs(xdft5));
            %fprintf('Delta:Maximum occurs at %f Hz.\n',freq5(I));
            delta_mean(j,i-3) = mean(normalized_delta(1:length(xdft5)/(fs/2)*4));
            delta_var(j,i-3) = var(normalized_delta(1:length(xdft5)/(fs/2)*4));
            delta_std(j,i-3) = std(normalized_delta(1:length(xdft5)/(fs/2)*4));
            
        end
    
        
    end
    
    
    
    
    for j =1:18
        if j == 4 || j == 13 || j == 16
            T = 1;
            for m =1:8
                
                Final_DATA{1,1}(J,T) = delta_mean(j,m);
                Final_DATA{1,1}(J,T+1) = delta_std(j,m);
                Final_DATA{1,1}(J,T+2) = delta_var(j,m);
                Final_DATA{1,1}(J,T+3) = theta_mean(j,m);
                Final_DATA{1,1}(J,T+4) = theta_std(j,m);
                Final_DATA{1,1}(J,T+5) = theta_var(j,m);
                Final_DATA{1,1}(J,T+6) = alpha_mean(j,m);
                Final_DATA{1,1}(J,T+7) = alpha_std(j,m);
                Final_DATA{1,1}(J,T+8) = alpha_var(j,m);
                Final_DATA{1,1}(J,T+9) = beta_mean(j,m);
                Final_DATA{1,1}(J,T+10) = beta_std(j,m);
                Final_DATA{1,1}(J,T+11) = beta_var(j,m);
                Final_DATA{1,1}(J,T+12) = gamma_mean(j,m);
                Final_DATA{1,1}(J,T+13) = gamma_std(j,m);
                Final_DATA{1,1}(J,T+14) = gamma_var(j,m);
                Final_DATA{1,1}(J,121) = DATA{1,j}(1,12);
                Final_DATA{1,1}(J,122) = DATA{1,j}(1,13);
                Final_DATA{1,1}(J,123) = 1;
                T = T+15;
            end
            J = J + 1;
            
            %Final_Data{1,1}(H,121) =
        elseif j == 2 || j == 6 || j == 10
            T = 1;
            for m =1:8
                
                Final_DATA{1,2}(K,T) = delta_mean(j,m);
                Final_DATA{1,2}(K,T+1) = delta_std(j,m);
                Final_DATA{1,2}(K,T+2) = delta_var(j,m);
                Final_DATA{1,2}(K,T+3) = theta_mean(j,m);
                Final_DATA{1,2}(K,T+4) = theta_std(j,m);
                Final_DATA{1,2}(K,T+5) = theta_var(j,m);
                Final_DATA{1,2}(K,T+6) = alpha_mean(j,m);
                Final_DATA{1,2}(K,T+7) = alpha_std(j,m);
                Final_DATA{1,2}(K,T+8) = alpha_var(j,m);
                Final_DATA{1,2}(K,T+9) = beta_mean(j,m);
                Final_DATA{1,2}(K,T+10) = beta_std(j,m);
                Final_DATA{1,2}(K,T+11) = beta_var(j,m);
                Final_DATA{1,2}(K,T+12) = gamma_mean(j,m);
                Final_DATA{1,2}(K,T+13) = gamma_std(j,m);
                Final_DATA{1,2}(K,T+14) = gamma_var(j,m);
                Final_DATA{1,2}(K,121) = DATA{1,j}(1,12);
                Final_DATA{1,2}(K,122) = DATA{1,j}(1,13);
                Final_DATA{1,2}(K,123) = 0;
                T = T+15;
            end
            K = K + 1;
            
        elseif j == 8 || j == 11 || j == 18
            T = 1;
            for m =1:8
                Final_DATA{1,3}(H,T) = delta_mean(j,m);
                Final_DATA{1,3}(H,T+1) = delta_std(j,m);
                Final_DATA{1,3}(H,T+2) = delta_var(j,m);
                Final_DATA{1,3}(H,T+3) = theta_mean(j,m);
                Final_DATA{1,3}(H,T+4) = theta_std(j,m);
                Final_DATA{1,3}(H,T+5) = theta_var(j,m);
                Final_DATA{1,3}(H,T+6) = alpha_mean(j,m);
                Final_DATA{1,3}(H,T+7) = alpha_std(j,m);
                Final_DATA{1,3}(H,T+8) = alpha_var(j,m);
                Final_DATA{1,3}(H,T+9) = beta_mean(j,m);
                Final_DATA{1,3}(H,T+10) = beta_std(j,m);
                Final_DATA{1,3}(H,T+11) = beta_var(j,m);
                Final_DATA{1,3}(H,T+12) = gamma_mean(j,m);
                Final_DATA{1,3}(H,T+13) = gamma_std(j,m);
                Final_DATA{1,3}(H,T+14) = gamma_var(j,m);
                Final_DATA{1,3}(H,121) = DATA{1,j}(1,12);
                Final_DATA{1,3}(H,122) = DATA{1,j}(1,13);
                Final_DATA{1,3}(H,123) = -1;
                T = T+15;
            end
            H = H + 1;

        end
    end
end
