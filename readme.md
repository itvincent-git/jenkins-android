# Description

1. 镜像基于jenkinsci/blueocean创建
2. 安装的android sdk工具包是：[https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip](https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip)
3. ANDROID_HOME 和 PATH都已经设置好
4. 预安装了build-tools和sdk版本为27,29,30



# How to use

```
docker run \
  -u root \
  -d \
  --name jenkins-android-v1 \
  -p 8080:8080 \
  -p 50000:50000 \
  -v $DOCKERDATA_HOME/jenkins:/var/jenkins_home \
  jenkins-android-v1
```

