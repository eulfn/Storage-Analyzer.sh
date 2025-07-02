#!/bin/sh
# storage-analyzer.sh: Quick storage scan for Termux/Android

p="/sdcard"
types="Vid Img Apk Aud Doc"
ext_vid="mp4 mkv avi webm"
ext_img="jpg jpeg png gif webp"
ext_apk="apk"
ext_aud="mp3 wav flac"
ext_doc="pdf docx txt"

# Make find args for extensions
FindArgs() {
  for e in $1; do
    printf " -o -iname '*.%s'" "$e"
  done | sed '1s/ -o//'
}

# Human size
HSize() {
  awk '{
    split("B KB MB GB TB", u)
    s=$1
    for(i=1; s>=1024 && i<5; i++) s/=1024
    printf "%.2f %s", s, u[i]
  }'
}

echo "Scanning $p..."
data=""

for t in $types; do
  case $t in
    Vid) e="$ext_vid" ;;
    Img) e="$ext_img" ;;
    Apk) e="$ext_apk" ;;
    Aud) e="$ext_aud" ;;
    Doc) e="$ext_doc" ;;
  esac
  fargs=""
  for x in $e; do
    fargs="$fargs -iname '*.$x' -o"
  done
  fargs="${fargs% -o}"
  files=$(find "$p" \( $fargs \) 2>/dev/null)
  n=$(printf '%s\n' "$files" | grep -c ".")
  if [ "$n" -eq 0 ]; then
    sz=0
  else
    sz=$(printf '%s\n' "$files" | xargs -r stat -c %s 2>/dev/null | awk '{s+=$1} END{print s}')
  fi
  hsz=$(echo "${sz:-0}" | HSize)
  data="$data$n|$sz|$t|$hsz\n"
done

printf "\n%-6s %-6s %-10s\n" "Type" "Files" "Size"
echo "$data" | awk -F'|' 'NF==4' | sort -t'|' -k2,2nr | while IFS='|' read n sz t hsz; do
  printf "%-6s %-6s %-10s\n" "$t" "$n" "$hsz"
done 