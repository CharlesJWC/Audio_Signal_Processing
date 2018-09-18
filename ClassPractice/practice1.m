clc; close all; clear;

myrecode = audiorecorder(48000, 16, 1);

disp('RECORD START!');

recordblocking(myrecode, 3);

disp('RECORD END!');
%%
sh_recode = audiorecorder(48000, 16, 1);

disp('RECORD START!');

recordblocking(sh_recode, 15);

disp('RECORD END!');
%%
recdata = getaudiodata(myrecode);

figure(11);
plot(recdata);

%%
p = play(myrecode);
%% 
cp_rec = recdata;

figure(11);
plot(cp_rec);

soundsc(cp_rec, 90000);
%%
recdata_sh = getaudiodata(sh_recode);
figure(22);
plot(recdata_sh);
%%
cp_rec2 = recdata_sh;

figure(22);
plot(cp_rec2);

sound(cp_rec2, 96000);

cp_rec2_16k = resample(cp_rec2, 1, 3);
sound(cp_rec2, 96000);
%%
%f=진동수, d=재생시간, fs=샘플레이트, n=총 데이터의 갯수
f=440; d=1; fs=44100; n=d*fs; 
t=(1:n)/fs; Y=tan(2*pi*f*t);
sound(Y,fs)
figure(33); plot(t,Y)
pause;
soundsc(Y,fs)
%sound(Y,fs)
%%
fc = 300;
fs = 2000;
[b, a] = butter(6, fc/(fs/2));
filtered = filter(b,a,recdata_sh);
subplot(1,2,1);
spectrogram(recdata_sh, 1024, 512,48000,'yaxis');
subplot(1,2,2);
spectrogram(filtered, 1024, 512,48000,'yaxis');
%%
freqz(b,a);

