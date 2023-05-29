#!/bin/bash

# Set the TikTok video URL
tiktok_url=$1
output_file=$2.mp4

# Download the TikTok video using yt-dlp
video_info=$(yt-dlp -J "$tiktok_url")
video_url=$(echo "$video_info" | jq -r '.formats[-1].url')

# Use ffmpeg to encode and save the video as H.264
ffmpeg -i "$video_url" -c:v libx264 -preset medium -crf 23 -c:a copy "$output_file"
