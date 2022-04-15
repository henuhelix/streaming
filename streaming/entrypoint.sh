#!/bin/sh
/tmp/srt/srt-live-transmit -st:yes "srt://127.0.0.1:${SRT_ENDPOINT_PORT}?mode=listener&lossmaxttl=40&latency=2000" "srt://0.0.0.0:5001?mode=listener" & \
/tmp/srtla/srtla_rec 5000 ${SRT_ENDPOINT_ADDR} ${SRT_ENDPOINT_PORT}

#path/to/srt/srt-live-transmit -st:yes "srt://127.0.0.1:5002?mode=listener&lossmaxttl=40&latency=2000" "srt://0.0.0.0:5001?mode=listener" &
#/tmp/srt/srt-live-transmit -st:yes "srt://${SRT_ENDPOINT_ADDR}:${SRT_ENDPOINT_PORT}?mode=listener&lossmaxttl=40&latency=2000" "srt://0.0.0.0:5001?mode=listener" & \
#/tmp/srtla/srtla_rec 5000 127.0.0.1 5002
#/tmp/srtla/srtla_rec 5000 ${SRT_ENDPOINT_ADDR} ${SRT_ENDPOINT_PORT}
# & /tmp/srt/srt-live-transmit -st:yes "srt://${SRT_ENDPOINT_ADDR}:${SRT_ENDPOINT_PORT}?mode=listener&lossmaxttl=40&latency=2000" "srt://0.0.0.0:5001?mode=listener"