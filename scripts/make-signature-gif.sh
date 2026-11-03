#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input="$project_dir/media/signature.mp4"
output="$project_dir/media/signature.gif"

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "FFmpeg is not installed. Install it with: brew install ffmpeg" >&2
  exit 1
fi
if [[ ! -f "$input" ]]; then
  echo "Source video not found: $input" >&2
  echo "Place your MP4 at media/signature.mp4 and run this script again." >&2
  exit 1
fi
if [[ -e "$output" ]]; then
  echo "Output already exists: $output" >&2
  echo "Move or remove the old GIF first; the MP4 source is never changed." >&2
  exit 1
fi

echo "Creating an 8-second, 8 fps, 480 px wide GIF from media/signature.mp4..."
ffmpeg -hide_banner -i "$input" -t 8 \
  -filter_complex '[0:v]fps=8,scale=480:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=128[p];[b][p]paletteuse=dither=bayer:bayer_scale=3' \
  -loop 0 "$output"

size_bytes="$(wc -c < "$output" | tr -d '[:space:]')"
size_mib="$(( (size_bytes + 1048575) / 1048576 ))"
echo "Created media/signature.gif (${size_mib} MiB)."
echo "Signature URL path: /media/signature.gif"
if (( size_bytes > 100 * 1024 * 1024 )); then
  echo "Warning: this GIF exceeds GitHub's 100 MiB per-file limit and Vercel Hobby's 100 MB static upload limit. Do not commit it; reduce duration/width/fps or use external media hosting." >&2
fi
