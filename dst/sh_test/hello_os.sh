#!/bin/bash
sed -n "8,8p" $1 > $2
for i in 32 128 512 1024
do
    j="${i}p"
    sed -n "$i,$j" $1 >> $2
done
