% This is the code file for the Project
% Your submission file MUST run without any errors/bugs and should display
% the results in the command window.

%% For the Part I of the project
% (For part II, you can comment out the file loading and visualization codes)
% Load the transmitted signals and the received signals at both the sensors

load('Project_Part_1_signals.mat');

% Visualize first few samples from the loaded data
% The variable 't' is time in seconds, and sampling time Ts = 0.005 sec

figure;
subplot(3,1,1);
plot(t(500:2000),transmitted_signal(500:2000));
title('Transmitted signal by the source');

subplot(3,1,2);
plot(t(500:2000),received_signal1(500:2000));
title('Received signal at Sensor 1');
ylabel('Amplitude');

subplot(3,1,3);
plot(t(500:2000),received_signal2(500:2000));
title('Received signal at Sensor 2');
xlabel('time (in seconds)');

% Implement your technique here
% Denoise the signal
% You can try several methods here and compare them with each other
% Also determine the best method to denoise the signal without any loss of
% information
window=200;
N=length(transmitted_signal)-window;
power1=zeros(1,N);
power2=zeros(1,N);
powerT=zeros(1,N);
tPrime=zeros(1,N);
for i=1:N
    indices=i:i+window;
    power1(i)=log(mean(received_signal1(indices).^2));
    power2(i)=log(mean(received_signal2(indices).^2));
    powerT(i)=log(mean(transmitted_signal(indices).^2));
    tPrime(i)=mean(t(indices));
end
var1=var(power1(1:1000-window));
var2=var(power2(1:1000-window));
r1=power1-powerT;
r2=power2-powerT;
y=4.25+exp(-r1+var1/2)-exp(-r2+var2/2);
figure;
set(gcf,'color','w');
plot(tPrime, y);
title('Position y of source, unsmoothed');
xlabel('time (in seconds)');
% export_fig y-unsmoothed.pdf;

y=smoothdata(y,'movmean',50);
figure;
set(gcf,'color','w');
plot(tPrime, y);
title('Position y of source, smoothed');
xlabel('time (in seconds)');
% export_fig y-smoothed.pdf;

% Code for the algorithm that determines the parameters for the motion of
% Source
startIndex=2651;
window=1000;
N=idivide(length(y)-startIndex+1,int32(window));
A=zeros(1,N);
B=zeros(1,N);
for i=1:N
    indices=(i-1)*window+startIndex:i*window+startIndex-1;
    A(i)=(max(y(indices))-min(y(indices)))/2;
    B(i)=mean(y(indices));
end
w=zeros(1,2*(N-1));
for i=1:N-1
    indices1=(i-1)*window+startIndex:i*window+startIndex-1;
    indices2=i*window+startIndex:(i+1)*window+startIndex-1;
    tCur=tPrime(indices1);
    tNext=tPrime(indices2);
    [curMax,peakCurIndex]=max(y(indices1));
    [nextMax,peakNextIndex]=max(y(indices2));
    [curMin,troughCurIndex]=min(y(indices1));
    [nextMin,troughNextIndex]=min(y(indices2));
    period1=tNext(peakNextIndex)-tCur(peakCurIndex);
    period2=tNext(troughNextIndex)-tCur(troughNextIndex);
    w(2*i-1)=2*pi/period1;
    w(2*i)=2*pi/period2;
end
phi=zeros(1,N);
for i=1:N
    indices=(i-1)*window+startIndex:i*window+startIndex-1;
    tCur=tPrime(indices);
    [curMax,peakIndex]=max(y(indices));
    phi(i)=(2*pi*(double(i)+5/4)/mean(w)-tCur(peakIndex))/mean(w);
end

figure;
set(gcf,'color','w');
plot(tPrime, y);
hold on;
plot(tPrime, mean(A)*sin(mean(w).*tPrime+mean(phi))+mean(B));
hold off;
title('Position y of source, smoothed and fitted');
xlabel('time (in seconds)');
% export_fig y-fitted.pdf;

% Print the estimated values in the command window
disp(['The estimated value (mean) of amplitude is ' num2str(mean(A))]);
% Here 'A' is a vector that contains all the observations of the amplitude
% and we simply compute the mean of 'A'
disp(['The standard deviation of amplitude is ' num2str(std(A))]);
% Similarly we compute the standard deviation of the estimate of amplitude
disp(['The estimated value (mean) of B is ' num2str(mean(B))]);
disp(['The standard deviation of B is ' num2str(std(B))]);
disp(['The estimated value (mean) of omega is ' num2str(mean(w))]);
disp(['The standard deviation of omega is ' num2str(std(w))]);
disp(['The estimated value (mean) of intial phase is ' num2str(mean(phi))]);
disp(['The standard deviation of initial phase is ' num2str(std(phi))]);