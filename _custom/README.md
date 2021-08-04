# Custom stuff

# Requirements
- Change default container runtime for docker to "nvidia-container-runtime". <https://docs.nvidia.com/dgx/nvidia-container-runtime-upgrade/index.html>
- A webcam for the Docker container. OBS virtual webcam is mounted on `/dev/video0` for this example.
- Place your custom train/test data in [albion-online](albion-online) folder.
- Copy [.env.sample](.env.sample) to [.env](.env), and change to your webcam device.

# How to use
1. Build the docker image. 
Modify the cmake arguments `-DCUDA_ARCH_BIN`, `DCUDA_ARCH_PTX` in [app/Dockerfile](app/Dockerfile) 
to build for specific GPU architecture.
```
docker build -t darren/opencv-cuda:cuda-11.3.1-cudnn8-opencv-4.5.3 .
```

2. Run
```
docker-compose up -d
```

3. Attach the docker container and start a bash session
```
docker exec -ti custom_app_1 bash
```

4. Compile darknet inside the container
```
git clone https://github.com/ryanalexmartin/darknet.git
cd darknet
mkdir build_release
cd build_release
rm ../CMakeCache.txt
cmake ..
cmake --build . --target install --parallel 8
```

5. Copy your _custom folder stuff. It's under /albion_stuff folder inside the container. You probably want to change the volume path in your docker-compose.yml file.
```
cp -r /albion-online/ /src/darknet/_custom/.
```

6. Set up your XAuth if you do not see the darknet demo displayed.
https://www.cloudsavvyit.com/10520/how-to-run-gui-applications-in-a-docker-container/
    - On the host machine, copy the xauth token.
    ```
    xauth list
    ```
    - In the container, paste the copied token
    ```
    xauth add <token>
    # Example:
    # xauth add iphone13/unix:  MIT-MAGIC-COOKIE-1  1fba3d4616632715160f533ee5ca344e
    ```

7. Run the demo at `/src/darknet`
```
./darknet detector demo _custom/albion-online/albion-online.data _custom/albion-online/albion-online-yolov4.cfg _custom/albion-online/backup/albion-online-yolov4_final.weights /albion-online/2021-07-23\ 22-47-18.mp4

# Webcam
./darknet detector demo _custom/albion-online/albion-online.data _custom/albion-online/albion-online-yolov4.cfg _custom/albion-online/backup/albion-online-yolov4_final.weights -c 0
```
