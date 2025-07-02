# storage-analyzer.sh

Quick and dirty storage analyzer for Android (Termux)

## What is this?
A shell script that scans your `/sdcard` for big files—videos, images, APKs, audio, docs—and tells you how many you have and how much space they eat up. Output is sorted by size, so you know what's hogging your storage.

## How do I use it?
1. Open Termux (or any Android shell that can run sh scripts).
2. Plop `storage-analyzer.sh` in your home dir or wherever.
3. Run:
   ```sh
   sh storage-analyzer.sh
   ```

## What do I need?
- Termux (or any POSIX-y shell on Android)
- No root needed
- Uses only basic tools: `find`, `stat`, `awk`, `xargs`, `grep`, `sort`, `printf`

## What does the output mean?
```
Type   Files  Size      
Vid    123    2.34 GB   
Img    456    1.12 GB   
Apk    12     0.45 GB   
Aud    78     0.33 GB   
Doc    90     0.02 GB   
```
- **Type**: File category (Vid = videos, Img = images, etc)
- **Files**: How many files of that type
- **Size**: Total space used by that type (human readable)

## What file types does it check?
- **Vid**: mp4, mkv, avi, webm
- **Img**: jpg, jpeg, png, gif, webp
- **Apk**: apk
- **Aud**: mp3, wav, flac
- **Doc**: pdf, docx, txt

## Can I add more types?
Yep! Just edit the script and add extensions to the lists at the top.

---

Dont Forget To Add As Star!
