# Custom stuff

# How to use
1. Build the docker image
```
docker build -t darren/opencv-cuda:11.3.1-cudnn8-devel-ubuntu20.04-opencv-4.5.3 .
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
cmake ..
cmake --build . --target install --parallel 8
```

5. Copy your _custom folder stuff. It's under /albion_stuff folder inside the container. You probably want to change the volume path in your docker-compose.yml file.

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

7. Run the demo
```
./darknet detector demo _custom/albion-online/albion-online.data _custom/albion-online/albion-online-yolov4.cfg _custom/albion-online/backup/albion-online-yolov4_final.weights /albion_stuff/2021-07-23\ 22-47-18.mp4
```
