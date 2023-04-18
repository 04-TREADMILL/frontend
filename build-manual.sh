#!/usr/bin/bash
echo "*** BUILD START ***"
sudo docker build -t registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend .
sudo docker rm -f $(sudo docker ps -aqf "expose=8502" --format="{{.ID}}")
sudo docker run -d -p 8502:8502 registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend 8502
echo "*** BUILD END ***"