#!/bin/bash
sh generateFS.sh
du -h --block-size=1  | sort -h | head -n 24 | awk '{print $1}' | awk '{Total=Total+$1} END{print "Sum of dirs with max 100000 bytes is: " Total}'

