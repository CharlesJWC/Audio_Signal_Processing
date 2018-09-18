clear all;
t = linspace(0,10,1024);
dialtone = sin(480*2*pi*t) + sin(620*2*pi*t);
TVsound = sin(1000*2*pi*t);
%%
sound(dialtone,1024)

%%
sound(TVsound,1024)