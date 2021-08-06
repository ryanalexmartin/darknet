#!/bin/bash
args=("$@")

cp -r /albion-online/ /src/darknet/_custom/.;

if ${args[0]}; then
    ./darknet detector demo _custom/albion-online/albion-online.data \
        _custom/albion-online/albion-online-yolov4.cfg \
        _custom/albion-online/backup/albion-online-yolov4_final.weights \
        -c 0 -json_port 8070 -dont_show;
else
    tail -F anything
fi
