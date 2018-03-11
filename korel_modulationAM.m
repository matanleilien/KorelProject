close all; clear all; clc;
Fs = 100e6;
simTime=50*0.2e-3; %0.0002 mSec
%%
Fc = 10e6; 
filename='music2_mono48kHz.wav';
[y,audioFs] = audioread(filename);
%cut 0.2ms off song and resample
y=y(1:ceil(simTime*audioFs));
y=resample(y,Fs,audioFs);
y=y(1:ceil(simTime*Fs));

yDSB = ammodComplex(y,Fc,Fs);

norm = dsp.Normalizer;
yDSB=step(norm,yDSB);

sa = dsp.SpectrumAnalyzer('SampleRate',Fs);
step(sa,yDSB)
%sanity check
[bw,Fst,Ffin,power]=obw(yDSB,Fs);
%bw should be ~2*audioBW (audioBW<=half of audioFs)
sanity=bw/audioFs %should be about 1
