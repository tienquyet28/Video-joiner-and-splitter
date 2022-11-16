function join_video_audio(video1,video2)
[wav,fs]= audio_joiner(video1,video2);
video = ghepvideo(video1,video2);
frames= floor(video.Duration*video.FrameRate);
numAudio = size(wav,1);
numRep = floor(numAudio/frames);
numDiff = numAudio - numRep*frames; % mismatch
%videoPlayer = vision.VideoPlayer
if numDiff
    % if length(frames) does not evenly divide nAudioSamples, then 
    % subsample audio to match numRep*length(frames)
    selector = round(linspace(1, numAudio, numRep*frames)); 
    subSignal = wav(selector, :);
end
assert(numRep*frames == size(subSignal,1));
outputVideo = vision.VideoFileWriter('video_ghep_thanhcong.avi','FrameRate',video.FrameRate,'AudioInputPort',true);
outputVideo.VideoCompressor="DV Video Encoder";
for i = 1:frames
    if hasFrame(video)
    img = readFrame(video);  
    %step(videoPlayer, img);
    outputVideo(img,subSignal(numRep*(i-1)+1:numRep*i,:));
    end
end
%end
release(outputVideo);
end