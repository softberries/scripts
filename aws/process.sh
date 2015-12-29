#!/bin/bash

lastdir=""
print_folder_recurse() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
            echo "dir: $i"
            if [ -n "$lastdir" ]; then
                echo "lastdir: $lastdir"
        #       aws s3 mv $lastdir s3://grajo001/ --recursive
            fi
            lastdir=$i
            print_folder_recurse "$i"
        elif [ -f "$i" ]; then
            echo "file: $i"
            bzip2 -d $i
            filename=$(basename "$i")
            fname=$(basename "$i")
            nameonly=${filename%.*}
            ext=${fname##*.}
            pathonly=${i%/*}
        fi
    done
}

split_files_recurse() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
            split_files_recurse "$i"
        elif [ -f "$i" ]; then
            echo "splitting file: $i"
            split -d -C 127m -a 4 $i ${i}part_
            rm $i
        fi
    done
}
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/tmp"
fi

echo "base path: $path"
print_folder_recurse $path
split_files_recurse $path

# the very last dir needs to be transfered explicitly
aws s3 mv $path s3://grajo001/ --recursive
