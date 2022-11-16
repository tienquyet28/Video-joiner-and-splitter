vid1 = VideoReader('video1.mp4');
vid2 = VideoReader('video3.mp4');

[wav1,Fs1]=audioread('video1.mp4');
[wav2,Fs2]=audioread('video3.mp4');
maxFs = max(Fs1, Fs2);
rs1 = resample(wav1, maxFs, Fs1);
rs2 = resample(wav2, maxFs, Fs2);
videoPlayer = vision.VideoPlayer;
% ch?nh s?a audio video 1
frames= floor(vid1.Duration*vid1.FrameRate);
numAudio = size(wav1,1);
numRep = floor(numAudio/frames);
numDiff = numAudio - numRep*frames; % mismatch

if numDiff
    % if length(frames) does not evenly divide nAudioSamples, then 
    % subsample audio to match numRep*length(frames)
    selector = round(linspace(1, numAudio, numRep*frames)); 
    subSignal = wav1(selector, :);
end
assert(numRep*frames == size(subSignal,1));
% k?t thúc

% ch?nh s?a audio video 2
frames1= floor(vid2.Duration*vid2.FrameRate);
numAudio1 = size(wav2,1);
numRep1 = floor(numAudio/frames1);
numDiff1 = numAudio1 - numRep1*frames1; % mismatch

if numDiff1
    % if length(frames) does not evenly divide nAudioSamples, then 
    % subsample audio to match numRep*length(frames)
    selector1 = round(linspace(1, numAudio1, numRep1*frames1)); 
    subSignal1 = wav2(selector1, :);
end
assert(numRep1*frames1 == size(subSignal1,1));
% k?t thúc

% new video
outputVideo = vision.VideoFileWriter('newvideo.avi','FrameRate',vid1.FrameRate,'AudioInputPort',true);
%outputVideo.FrameRate = vid1.FrameRate;
%open(outputVideo);
%while hasFrame(vid1)
for i = 1:frames
    if hasFrame(vid1)
    img1 = readFrame(vid1);
    [rows1, columns1, numColors1] = size(img1);
    step(videoPlayer, img1);
    %step(outputVideo, img1, subSignal(numRep*(i-1)+1:numRep*i,:));
    outputVideo(img1,subSignal(numRep*(i-1)+1:numRep*i,:));
    end
end
%end
release(outputVideo);
for i = 1:frames1
    if hasFrame(vid2)
    img2 = readFrame(vid2);
    [rows2, columns2, numColors2] = size(img1);
    img2 = imresize(img2, [rows1, columns1]); 
    step(videoPlayer, img2);
    %step(outputVideo, img2, subSignal1(numRep1*(i-1)+1:numRep1*i,:));
    outputVideo(img2,subSignal(numRep1*(i-1)+1:numRep1*i,:));
    end
    %outputVideo(img2,wav2);
end
release(videoPlayer);
release(outputVideo);
%while hasFrame(vid1) && hasFrame(vid2)
    %img1 = readFrame(vid1); 
    %img2 = readFrame(vid2);
    %imgt = horzcat(img1, img2);
    % play video
    %step(videoPlayer, imgt);
    % record new video
    %writeVideo(outputVideo, imgt);
%end
