#!/usr/bin/env python3

import os
import argparse
from pytube import YouTube

parser = argparse.ArgumentParser(description='Download a Youtube video.')
parser.add_argument('url', help='the Youtube video url')
parser.add_argument('-o', '--output', help='name of the output file')
parser.add_argument('-p', '--path', help='path to download the video to')

# parse cmd arguments
args = parser.parse_args()

# create a YouTube object from the URL
yt = YouTube(args.url)

# get the highest resolution stream
stream = yt.streams.get_highest_resolution()

# set the output filename
if args.output:
    output_file = args.output
    if not args.output.endswith('.mp4'):
        output_file += '.mp4'
else:
    output_file = stream.default_filename

# set the path
if args.path:
    output_path = args.path
else:
    output_path = '.'

# check that the output path is valid
if not os.path.isdir(output_path):
    print(f"Error: {output_path} is not a valid directory.")
    exit(1)

output_file_path = os.path.join(output_path, output_file)

# download the video
try:
    print(f"Downloading video as {output_file_path}...")
    stream.download(output_path=output_path, filename=output_file)
    print("Video downloaded successfully!")
except Exception as e:
    print(f"Error: {str(e)}")

