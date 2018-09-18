% Audio Signal Processing HW3
% 12131448 최중원
clc; close all; clear;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HW3-Problem1 : Audio Recoding & Resampling to 16kHz

myrecObj = audiorecorder(48000, 16, 1);
% 48kHz의 샘플링 주파수로 오디오 신호를 녹음할 객체 생성

disp('RECORD START!');
recordblocking(myrecObj, 11); % 10초간 오디오 신호 녹음 (초반 1초 보정위해 11초 설정)
disp('RECORD END!');

% P1 continue : Resampling to 16kHz
audioData_raw = getaudiodata(myrecObj); % 객체에서 오디오데이터 추출
audioData = audioData_raw(length(audioData_raw)*(1/11)+1:end); 
% 초반 1초 부분 제거 (노트북에서 처음 1초가 녹음되지 않았기 때문)
%%
figure(100); set(100, 'name', 'Audio Data','units','normalized','outerposition', [0 0.5 1 0.5]);
subplot(2,1,1); plot(audioData); title(['Original Audio Data',' (',num2str(length(audioData)),' samples)']); 
xlim([0, length(audioData)]); ylim([-1.5,1.5]); 

audioData_16k = resample(audioData, 1, 3); %% 16kHz로 resampling (48000 * 1/3)
subplot(2,1,2); plot(audioData_16k); title(['16kHz resampled Audio Data',' (',num2str(length(audioData_16k)),' samples)']); 
xlim([0, length(audioData_16k)]); ylim([-1.5,1.5]); 
%%
% 녹음된 음성 재생 
%p = play(myrecObj);
%sound(audioData, 48000);
sound(audioData_16k, 16000);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HW3-Problem2 : Make LPF filter & audio filtering

n = 7; % 필터 차수;
fc = 4000; % cut-off frequency
fs = 16000; % sampling frequency

% Butterworth 필터 (IIR)
[b1, a1] = butter(n, fc/(fs/2));
filtered_bw = filter(b1,a1,audioData_16k);

% Chebyshev Type1 필터 (IIR)
Rp = 0.5; % 리플 허용 dB
[b2, a2] = cheby1(n, Rp, fc/(fs/2));
filtered_cb = filter(b2,a2,audioData_16k);

% Parks-McClellan 필터 (FIR)
f = [0 0.2 0.3 0.4 fc/(fs/2) 0.6 0.7 1]; % pairs of normalized frequency
a = [1 1 1 1 0.5 0 0 0]; % pairs of desired amplitudes
% parameter를 위와 같이 설정할 때 리플의 폭이 더 감소 
%f = [0:0.05:0.45, 0.55:0.05:1]; % pairs of normalized frequency
%a = [ones(1,length(0:0.05:0.45)),zeros(1,length(0.55:0.05:1))]; % pairs of desired amplitudes
b3 = firpm(n, f, a);
filtered_pm = filter(b3,1,audioData_16k);

% P2 continue : Spectrogram analysis
figure(200); set(200, 'name', 'Filtered Data Spectrogram','units','normalized','outerposition', [0 0 1 1]);

subplot(2,3,1);
spectrogram(audioData, 1024, 512,48000,48000,'yaxis'); title('Original Audio Data');
subplot(2,3,2);
spectrogram(audioData_16k, 1024, 512,48000,16000,'yaxis'); title('16kHz Resampled Audio Data');

subplot(2,3,4);
spectrogram(filtered_bw, 1024, 512,48000,16000,'yaxis'); title('Butterworth Filtered  Audio Data');
subplot(2,3,5);
spectrogram(filtered_cb, 1024, 512,48000,16000,'yaxis'); title('Chebyshev Filtered  Audio Data');
subplot(2,3,6);
spectrogram(filtered_pm, 1024, 512,48000,16000,'yaxis'); title('Parks-McClellan Filtered  Audio Data');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HW3-Problem3 : Find characteristics of filters

% Ideal Filter
id_w = [0 0.499 0.501 1];
id_h = [1, 1, 0, 0];

figure(300); set(300, 'name', 'LPF Filter Design','units','normalized','outerposition', [0 0.5 1 0.5]);

[h1,w1] = freqz(b1,a1, 1024);
subplot(1,3,1); plot(w1/pi, abs(h1), id_w, id_h);
title('Butterworth Filter Design'); legend('butter', 'Ideal');
xlabel 'Radian Frequency (\omega/\pi)', ylabel('Magnitude');

[h2,w2] = freqz(b2,a2, 1024);
subplot(1,3,2); plot(w2/pi, abs(h2), id_w, id_h);
title('Chebyshev Filter Design'); legend('cheby1', 'Ideal'); ylim([0, 1.2]);
xlabel 'Radian Frequency (\omega/\pi)', ylabel('Magnitude');

[h3,w3] = freqz(b3,1,1024);
subplot(1,3,3); plot(w3/pi, abs(h3), id_w, id_h);
title('Parks-McClellan Design'); legend('firpm', 'Ideal');
xlabel 'Radian Frequency (\omega/\pi)', ylabel('Magnitude');

% Each of Filter Characteristics
figure(401); freqz(b1,a1, 1024); title('Butterworth'); ylim([-400, 50]);
figure(402); freqz(b2,a2, 1024); title('Chebyshev'); ylim([-400, 50]);
figure(403); freqz(b3, 1, 1024); title('Parks-McClellan'); ylim([-200, 50]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 오디오데이터 저장
audiowrite('original.wav', audioData, 48000);
audiowrite('resampled_16kHz.wav', audioData_16k, 16000);
audiowrite('butter_filtered.wav', filtered_bw, 16000);
audiowrite('cheby1_filtered.wav', filtered_cb, 16000);
audiowrite('firpm_filtered.wav', filtered_pm, 16000);

%% 음성데이터 reverse Ver. (for fun)
rev_audioData = flipud(audioData);
figure(500); plot(rev_audioData);
sound(rev_audioData, 48000);
%audiowrite('original_reverse.wav', rev_audioData, 48000);