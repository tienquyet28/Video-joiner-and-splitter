function video_split(video,batdau,ketthuc)
vid = VideoReader(video);
[audio]=audioread(video);
%videoPlayer = vision.VideoPlayer;
numFrames = 0;
iwant = cell([],1) ;   % to save FRames 
while hasFrame(vid)
    F = readFrame(vid);    
    numFrames = numFrames + 1;   
    iwant{numFrames} = F ;
end

% new video
outputVideo = vision.VideoFileWriter('video_da_cat.avi','FrameRate',vid.FrameRate,'AudioInputPort',true);
outputVideo.VideoCompressor="DV Video Encoder";
frames= floor(vid.Duration*vid.FrameRate);
numAudio = size(audio,1);
numRep = floor(numAudio/frames);
numDiff = numAudio - numRep*frames;

if numDiff
    selector = round(linspace(1, numAudio, numRep*frames)); 
    subSignal = audio(selector, :);
end
assert(numRep*frames == size(subSignal,1));

for i = floor(batdau*vid.FrameRate+1): floor(ketthuc*vid.FrameRate)
    step(outputVideo, iwant{i}, subSignal(numRep*(i-1)+1:numRep*i,:));
end

%release(videoPlayer);
release(outputVideo);
end