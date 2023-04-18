#!/usr/bin/bash
echo "*** BUILD START ***"
sudo docker build -t registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend .
sudo docker stop `sudo docker ps -a | grep registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend | awk '{print $1}'`
sudo docker rm `sudo docker ps -a | grep registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend | awk '{print $1}'`
sudo docker run -d -p 8501:8501 registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend
echo "*** BUILD END ***"