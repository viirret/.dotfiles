#!/usr/bin/env python3

import os
import argparse
from pytube import YouTube

parser = argparse.ArgumentParser(description='Download a Youtube video.')
parser.add_argument('url', help='the Youtube video url')
parser.add_argument('-o', '--output', help='name of the output file')
parser.add_argument('-p', '--path', help='path to download the video to')
parser.add_argument('-t', '--type', help='file type (default: mp4)', default='mp4')

# parse cmd arguments
args = parser.parse_args()

# create a YouTube object from the URL
yt = YouTube(args.url)

# get the highest resolution stream
stream = yt.streams.get_highest_resolution()

# set the output filename and extension
if args.output:
    output_file = args.output
    if not args.output.endswith('.{}'.format(args.type)):
        output_file += '.{}'.format(args.type)
else:
    output_file = stream.default_filename.replace('.mp4', '.{}'.format(args.type))

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

# download the video as mp3 or mp4
try:
    if args.type == 'mp3':
        print(f"Downloading audio as {output_file_path}...")
        stream.download(output_path=output_path, filename='temp.mp4')
        os.system('ffmpeg -i "{}" -vn -ar 44100 -ac 2 -ab 192k -f mp3 "{}"'.format(os.path.join(output_path, 'temp.mp4'), output_file_path))
        os.remove(os.path.join(output_path, 'temp.mp4'))
    else:
        print(f"Downloading video as {output_file_path}...")
        stream.download(output_path=output_path, filename=output_file)
    print("Download complete!")
except Exception as e:
    print(f"Error: {str(e)}")

