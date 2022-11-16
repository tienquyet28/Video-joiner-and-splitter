function video=ghepvideo(video1,video2)
vid1 = VideoReader(video1);
vid2 = VideoReader(video2);
videoPlayer = vision.VideoPlayer;
% new video
outputVideo = VideoWriter('newvideo');
outputVideo.FrameRate = vid1.FrameRate;
open(outputVideo);
while hasFrame(vid1)
    img1 = readFrame(vid1);
    [rows1, columns1, numColors1] = size(img1);
    step(videoPlayer, img1);
    writeVideo(outputVideo, img1);
end

while hasFrame(vid2)
    img2 = readFrame(vid2);
    [rows2, columns2, numColors2] = size(img1);
    img2 = imresize(img2, [rows1, columns1]); 
    step(videoPlayer, img2);
    writeVideo(outputVideo, img2);
end
%while hasFrame(vid1) && hasFrame(vid2)
    %img1 = readFrame(vid1);
    %img2 = readFrame(vid2);
    %imgt = horzcat(img1, img2);
    % play video
    %step(videoPlayer, imgt);
    % record new video
    %writeVideo(outputVideo, imgt);
%end

release(videoPlayer);
close(outputVideo);
video=VideoReader('newvideo.avi');
end