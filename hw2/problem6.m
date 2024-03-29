close all;
clear all;
clc;

% Load the sound track
[X, Fs] = audioread('inception_sound_track.wav');

% -------------------------------------------------------------------------------
% Please enter your code here
% Design the system as shown in the figure that performs upsampling followed by a smoother

% Upsampling
W = upsample(X,3);

% Smoother using moving average and exponential smoother
% window = 10;
% Y = smoothdata(W, 'movmean', window);
alpha = 0.3;
Y = filter(alpha, [1 alpha-1], W);


% -------------------------------------------------------------------------------
% Play the output signal Y (y[n]) from the system should be slower

ap_x = audioplayer(Y, Fs); % Play the output audio file with original sampling frequency
play(ap_x)

% Please attach/print your code to the homework submission