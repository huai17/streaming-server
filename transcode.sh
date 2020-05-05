#!/bin/bash

on_die() {
  # kill all children
  pkill -KILL -P $$
}

trap 'on_die' TERM

filepath="rtmp://127.0.0.1/$1/$2"
width_prefix='streams_stream_0_width='
height_prefix='streams_stream_0_height='
declare -a dimensions
while read -r line; do
  dimensions+=("${line}")
done < <(ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=width,height "${filepath}")
width_with_prefix=${dimensions[0]}
height_with_prefix=${dimensions[1]}
width=${width_with_prefix#${width_prefix}}
height=${height_with_prefix#${height_prefix}}

if [ "${height}" -lt 1441 ] && [ "${height}" -gt 1080 ]; then
  ffmpeg -i rtmp://127.0.0.1/$1/$2 -async 1 -vsync -1 \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 400k -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:360" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_360p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 500K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:480" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_480p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 1500K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:720" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_720p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 3000K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:1080" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_1080p \
    -c copy -f flv rtmp://127.0.0.1/hls/$2_src &
elif [ "${height}" -lt 1081 ] && [ "${height}" -gt 720 ]; then
  ffmpeg -i rtmp://127.0.0.1/$1/$2 -async 1 -vsync -1 \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 400k -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:360" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_360p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 500K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:480" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_480p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 1500K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:720" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_720p \
    -c copy -f flv rtmp://127.0.0.1/hls/$2_src &
elif [ "${height}" -lt 721 ] && [ "${height}" -gt 480 ]; then
  ffmpeg -i rtmp://127.0.0.1/$1/$2 -async 1 -vsync -1 \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 400k -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:360" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_360p \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 500K -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:480" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_480p \
    -c copy -f flv rtmp://127.0.0.1/hls/$2_src &
elif [ "${height}" -lt 481 ] && [ "${height}" -gt 300 ]; then
  ffmpeg -i rtmp://127.0.0.1/$1/$2 -async 1 -vsync -1 \
    -c:v libx264 -x264opts keyint=24:no-scenecut -c:a aac -max_muxing_queue_size 4000 -r 30 -b:v 400k -profile:v high -b:a 128k -vf "trunc(oh*a/2)*2:360" -tune zerolatency -preset veryfast -crf 23 -f flv rtmp://127.0.0.1/hls/$2_360p \
    -c copy -f flv rtmp://127.0.0.1/hls/$2_src &
else
  echo "not working"
fi

wait
