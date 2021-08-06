# Custom stuff

# Requirements
- Change default container runtime for docker to "nvidia-container-runtime". 
<https://docs.nvidia.com/dgx/nvidia-container-runtime-upgrade/index.html>
- A webcam for the Docker container. OBS virtual webcam is mounted on `/dev/video0` for this example.
- Place your custom train/test data in [albion-online](albion-online) folder.
- Copy [.env.sample](.env.sample) to [.env](.env), then configure the settings.

# How to use
1. Build the docker image. 
to build for specific GPU architecture.
    ```
    docker-compose build
    ```

2. Run
    ```
    docker-compose up -d
    ```

# Optional
If you set `STREAM_JSON` in [.env](.env) to `false` the the container
will do nothing, but stay alive using the `tail -F anything` trick. 
1. Run the demo at `/src/darknet`
    ```
    # Sample video
    ./darknet detector demo _custom/albion-online/albion-online.data \
    _custom/albion-online/albion-online-yolov4.cfg \
    _custom/albion-online/backup/albion-online-yolov4_final.weights \
    /albion-online/2021-07-23\ 22-47-18.mp4

    # Webcam JSON stream
    ./darknet detector demo _custom/albion-online/albion-online.data \
    _custom/albion-online/albion-online-yolov4.cfg \
    _custom/albion-online/backup/albion-online-yolov4_final.weights \
    -c 0 -json_port 8070 -dont_show
    ```
