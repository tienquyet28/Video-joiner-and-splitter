# Video-joiner-and-splitter
ghepvideo.m là hàm để ghép 2 video đồng bộ khung hình , mặc định xuất ra 30fps, đuôi .avi
audio_joiner.m: là hàm ghép đồng bộ audio của 2 video, fs là Fs cao nhất của hai audio
chạy ghép hai video:
nhập: >>video1='video1.mp4';
>>video2='video3.mp4';
>>join_video_audio(video1,video2);
tên video ghép thành công video_ghep_thanhcong.avi. định dạng DV compressor; để nét hơn xóa định dạng videoCompressor trong bộ videoFilewriter đi.

cắt hai video:
>>video ='video_ghep_thanhcong.avi'
>>batdau=3;
>>ketthuc=10;
>>video_split(video,batdau,ketthuc);
batdau và ketthuc nên là số giây phù hợp từ video cần cắt ra;
