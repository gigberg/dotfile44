# 2023-4-30 https://github.com/luongz/iptv-jp MTV(2)
conda activate torch190
while true; do ffmpeg -i "http://rip.hidari.moe/get/jptv/get.php?id=r92x5aJGtFjpXj4FtPuvAw==" -codec copy -f flv 2>/dev/null - | ffmpeg -re -i - -vcodec copy -acodec copy -f flv "rtmp://live-push.bilivideo.com/live-bvc/?streamname=live_1022009907_41747260&key=5a479f952f06bb5058304f751a79926b&schedule=rtmp&pflag=1" >/dev/null 2>&1; done
