% Audio Signal Processing Term Project
% 12131448 최중원
clc; close all; clear;

[C3_h, Fs] = audioread('C3.wav', [42000 100000]);  % C3 불러오기
disp("Sampling rate : "+Fs)
C3_h = pvoc(C3_h, 6/5); % 기준음 Time Scaling
%plot(C3_h)
soundsc(C3_h, Fs)
%% Problem 1 : Generate D3, E3, F3 ,G3 nodes and save as .wav format 

% Half note 
D3_h = resample(pvoc(C3_h, 8/9), 8, 9); % ★
E3_h = resample(pvoc(C3_h, 4/5), 4, 5); % ★
F3_h = resample(pvoc(C3_h, 3/4), 3, 4); % ★
G3_h = resample(pvoc(C3_h, 2/3), 2, 3); % ★
A3_h = resample(pvoc(C3_h, 3/5), 3, 5);
B3_h = resample(pvoc(C3_h, 8/15), 8, 15);

C4_h = resample(pvoc(C3_h, 1/2), 1, 2); 
D4_h = resample(pvoc(C4_h, 8/9), 8, 9); 
E4_h = resample(pvoc(C4_h, 4/5), 4, 5); 
F4_h = resample(pvoc(C4_h, 3/4), 3, 4); 
G4_h = resample(pvoc(C4_h, 2/3), 2, 3); 
A4_h = resample(pvoc(C4_h, 3/5), 3, 5);
B4_h = resample(pvoc(C4_h, 8/15), 8, 15);

% Quatar note 
C3_q = pvoc(C3_h, 2); 
D3_q = pvoc(D3_h, 2); 
E3_q = pvoc(E3_h, 2); 
F3_q = pvoc(F3_h, 2); 
G3_q = pvoc(G3_h, 2); 
A3_q = pvoc(A3_h, 2); 
B3_q = pvoc(B3_h, 2); 

C4_q = pvoc(C4_h, 2); 
D4_q = pvoc(D4_h, 2); 
E4_q = pvoc(E4_h, 2); 
F4_q = pvoc(F4_h, 2); 
G4_q = pvoc(G4_h, 2); 
A4_q = pvoc(A4_h, 2); 
B4_q = pvoc(B4_h, 2); 

% series = [C3_q; D3_q; E3_q ;F3_q; G3_q; A3_q; B3_q; C4_q];
% soundsc(series, Fs)

% Eeighth note 
C3_e = pvoc(C3_q, 2); 
D3_e = pvoc(D3_q, 2); 
E3_e = pvoc(E3_q, 2); 
F3_e = pvoc(F3_q, 2); 
G3_e = pvoc(G3_q, 2); 
A3_e = pvoc(A3_q, 2); 
B3_e = pvoc(B3_q, 2); 

C4_e = pvoc(C4_q, 2); 
D4_e = pvoc(D4_q, 2); 
E4_e = pvoc(E4_q, 2); 
F4_e = pvoc(F4_q, 2); 
G4_e = pvoc(G4_q, 2); 
A4_e = pvoc(A4_q, 2); 
B4_e = pvoc(B4_q, 2); 

audiowrite('D3.wav', D3_h, Fs);
audiowrite('E3.wav', E3_h, Fs);
audiowrite('F3.wav', F3_h, Fs);
audiowrite('G3.wav', G3_h, Fs);

disp("Notes generation complete!")
%% Bonus comparison : direct vs bypass 
C4_direct = resample(pvoc(C3_h, 1/2), 1, 2); % ★
C4_bypass = resample(pvoc(G3_h, 3/4), 3, 4); % ★

D4_fromC4 = resample(pvoc(C4_h, 8/9), 8, 9); % ★
D4_fromD3 = resample(pvoc(D3_h, 1/2), 1, 2); % ★

soundsc(C3_h, Fs) % reference
pause(3);
soundsc(C4_direct, Fs)  % << better (in my opinion)
pause(1.5);
soundsc(C4_bypass, Fs)
pause(3);
soundsc(D4_fromC4, Fs)  % << better (in my opinion)
pause(1.5);
soundsc(D4_fromD3, Fs)

%% Problem 2 : Generate Twinkle Twinkle Little Star

% 도 레 미 파 솔 라 시 도
%  C  D  E  F  G  A  B  C

TTLS = [nodesum(C4_q,C3_h); nodesum(G4_q,E3_h);
           nodesum(A4_q,F3_h); nodesum(G4_h,E3_h);
           nodesum(F4_q,D3_h); nodesum(E4_q,C3_h);
           nodesum(D4_q,F3_q); nodesum(D4_q,G3_q);
           nodesum(E3_q,C3_q,C4_h); 
           
           nodesum(G4_q,E3_h); nodesum(F4_q,F3_h);
           nodesum(E4_q,G3_h); nodesum(D4_h,G3_h);
           nodesum(G4_q,E3_h); nodesum(F4_q,F3_h);
           nodesum(E4_q,G3_h); nodesum(D4_h,G3_h);
           
           nodesum(C4_q,C3_h); nodesum(G4_q,E3_h);
           nodesum(A4_q,F3_h); nodesum(G4_h,E3_h);
           nodesum(F4_q,D3_h); nodesum(E4_q,C3_h);
           nodesum(D4_q,F3_q); nodesum(D4_q,G3_q);
           nodesum(C4_h,C3_h); 
        ];
   
disp("Now playing : ""Twinkle Twinkle Little Star""")
soundsc(TTLS,Fs)
% clear sound

%% Problem 3 : Generated music in .wav format
audiowrite('TheMusic(JWC).wav', TTLS, Fs);
disp("Music save complete!")