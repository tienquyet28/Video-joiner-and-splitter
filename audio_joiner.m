function [wav,fs]=audio_joiner(video1,video2)
[wav1,Fs1]=audioread(video1);
[wav2,Fs2]=audioread(video2);

maxFs = max(Fs1, Fs2);

rs1 = resample(wav1, maxFs, Fs1);
rs2 = resample(wav2, maxFs, Fs2);
horizontal_wav = [rs1; rs2];
%size(horizontal_wav)
p = audioplayer(horizontal_wav, maxFs);
wav=horizontal_wav;
fs=maxFs;

end
%play(p)