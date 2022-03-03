# Noalbs Hosting Setup for Belabox on the Jetson
the streaming folder contains the docker compose for running the containers that are needed on the endpoint side (e.g. at home or cloud)

## Updating
just modify the `.env` file and increase the version number (see changelog)
and rerun
```
sudo docker-compose -f docker-compose-noalbs-v2.yml up -d
```

## Changelog:
1.1: applied critical patch from b3cks repo

1.0: first docker release

## Pre-Requirements (windows)
+ OBS https://obsproject.com/download
+ Docker for Windows (it's important to check their requirements) https://docs.docker.com/docker-for-windows/install/
+ Router that can Port-Forward to your windows machine (also check windows firewall)


## Pre-Requirements (linux)
+ docker-ce
+ docker-compose

## Installation (mixed)
+ download https://github.com/moo-the-cow/streaming/archive/refs/heads/main.zip extract do a folder that will be used permamently
+ go into the folder `streaming` in that extracted directory
+ modify the `config.json` (see documentation for details https://github.com/715209/nginx-obs-automatic-low-bitrate-switching#using-sls-srt-live-server )
+ (optional) modify the `entrypoint.sh` file if you need to change the inbound port for the srtla stream (coming from jetson)
+ (optional) modify the `sls.conf` file if you wanna add more stream id's or change the name or do other things
+ make sure docker for windows is started and the containers are switched to "linux containers" (see https://docs.docker.com/docker-for-windows/)
+ open a Terminal (suggestion: https://www.microsoft.com/store/productId/9N8G5RFZ9XK3 ) browse to that directory and type
```
sudo docker-compose -f docker-compose-noalbs-v2.yml up -d
```

## Troubleshooting
+ you can still access the normal srt server without bonding feature using udp port 30000 as a fallback (you'd need to add that to portforwarding though)
+ you can access the stats page via the ip of your windows machine using port 8282 in your browser if you need to fetch the statistics (bitrate/tts) that can be used in OBS
+ the linux setup is quite similar, just skip the windows related parts
+ this setup is highly flexible - if you don't wanna use noalbs just configure the `docker-compose.yml` file and replace it with some other SRT solution. you can just re-configure ports and the container name via environment variables that are used in the `entrypoint.sh` file
+ If you want to use v1 for some reason just run
```
sudo docker-compose --env-file .env.v1 -f docker-compose-noalbs-v1.yml up -d
```
instead

## Note
the other folders contain the docker build files for streaming on a jetson nano and srt setup to send stream data to

the build folder contains the docker compose for building all the containers

everything is opensource, there are no secrets about the setup

# NGINX-RTMP (for example for phone streams or on Go Pro 10)
place the files from [streaming/nginx.conf](streaming/nginx.conf) and [streaming/docker-compose-nginx-rtmp.yml](streaming/docker-compose-nginx-rtmp.yml) into a directory on your jetson and start it up via
```
sudo docker-compose -f docker-compose-nginx-rtmp.yml up -d
```
[LARIX IOS](https://apps.apple.com/us/app/larix-broadcaster/id1042474385)

[LARIX ANDROID](https://play.google.com/store/apps/details?id=com.wmspanel.larix_broadcaster)

on your phone install LARIX and connect to the jetson locally
setup LARIX to connect to the jetson like this
`rtmp://[INTERNAL_IP_OF_JETSON]:1935/publish/live`

on belaUI select the pipeline 
```
h265_rtmp_localhost_publish_live
```
and the usual SRT server settings

example how it looks like when everything is working:
![image](https://user-images.githubusercontent.com/34907770/156200207-f2ec9425-8289-4722-bc93-daefbdbc8734.png)

## Note
This requires you to have a local network. so you need some kind of small portable wifi-router handling it)
