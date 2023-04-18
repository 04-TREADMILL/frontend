#!/usr/bin/bash
echo "*** BUILD START ***"
sudo docker build -t registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend .
sudo docker rm -f $(sudo docker ps -aqf "expose=8501" --format="{{.ID}}")
sudo docker run -d -p 8501:8501 registry.cn-shanghai.aliyuncs.com/vgalaxies/frontend 8501
echo "*** BUILD END ***"