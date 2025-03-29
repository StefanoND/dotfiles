#!/usr/bin/env bash

# fd ./ -type f -iname "*.jpeg" -exec mogrify -verbose -format jpeg -layers Dispose -resize 1920\>x1080\> -quality 100% {} +
# fd ./ -type f -iname "*.jpg" -exec mogrify -verbose -format jpg -layers Dispose -resize 1920\>x1080\> -quality 100% {} +
# fd ./ -type f -iname "*.png" -exec mogrify -verbose -format png -alpha on -layers Dispose -resize 1080\>x1080\> {} +


find "${1}" -type f -iname "*.jpeg" -exec mogrify -verbose -format jpeg -layers Dispose -resize 1920\<x1080\< -quality 100% {} +
find "${1}" -type f -iname "*.jpg" -exec mogrify -verbose -format jpg -layers Dispose -resize 1920\<x1080\< -quality 100% {} +
find "${1}" -type f -iname "*.png" -exec mogrify -verbose -format png -alpha on -layers Dispose -resize 1920\<x1080\< {} +
# find "${1}" -type f -iname "*.webp" -exec mogrify -verbose -format png -alpha on -layers Dispose -resize 1920\<x1080\< {} +
