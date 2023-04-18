FROM python:3.9-buster

RUN sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list \
    && apt update && apt-get install -y openjdk-11-jdk && apt-get install -y wget

COPY . /app
WORKDIR /app

RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && pip install -r requirements.txt
RUN wget https://senti-strength.oss-cn-nanjing.aliyuncs.com/myEASIEST-1.0-SNAPSHOT.jar

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

ENTRYPOINT ["streamlit", "run", "main.py", "--server.port"]