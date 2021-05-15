FROM jenkinsci/blueocean
USER root
# 压缩androidsdk目录： tar -czf android-sdk-linux.gz android-sdk-linux/
# 从容器中复制出来：docker cp jenkins:/opt/android-sdk-linux.gz 
# 使用方式: docker build -t jenkins-android-v1 .
# 镜像打标签： docker tag jenkins-android-v1 itvincent/jenkins-android-v1:1.0
# 上传镜像： docker push itvincent/jenkins-android-v1:1.0

# 安装android sdk
ENV ANDROID_HOME=/opt/android-sdk-linux
# 方式1. 先在宿主主机中下载好 android sdk tools, 放置于 ./tools/ 目录下, 利用 ADD 指令将其内的文件复制到容器指定位置
ADD android-sdk-linux.gz /opt
# 方式2. 在线下载(官网: https://developer.android.com/studio)
# RUN mkdir -p ${ANDROID_HOME} \
#      && cd $ANDROID_HOME \
#      && curl -o sdk.zip $SDK_TOOL_URL \
#      && unzip sdk.zip \
#      && rm sdk.zip

# 下载cmdtools，安装到/opt/android-sdk-linux
# RUN curl https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip --output commandlinetools-linux-7302050_latest.zip \
#     && unzip -q /opt/soft/commandlinetools-linux-7302050_latest.zip -d /opt/android-sdk-linux \
#     && chmod -R 755 ${ANDROID_HOME} \
#     && chmod a+rw -R /root/.android


# 此处会显示一个licence,需要输入 y 才能继续执行下载sdk相关包的操作
# sdkmanager --list 查看安装的包
# RUN echo y | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;m2repository" "extras;google;m2repository" "platform-tools" "platforms;android-28" "sources;android-28" "build-tools;28.0.0"
# RUN echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "build-tools;29.0.3" \
#     && echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "build-tools;27.0.3" \
#     && echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "build-tools;30.0.3" \
#     && echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "platforms;android-29" \
#     && echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "platforms;android-30" \
#     && echo yes | ${ANDROID_HOME}/tools/bin/sdkmanager --sdk_root=/opt/android-sdk-linux "platform-tools" "platforms;android-27"

# 设置环境变量: 把 android sdk加入到 PATH 中
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# 增大java虚拟机内存
ENV JAVA_OPTS="-Xmx8192m"

# docker run \
#   -u root \
#   -d \
#   --name jenkins \
#   -p 8080:8080 \
#   -p 50000:50000 \
#   -v $DOCKERDATA_HOME/jenkins:/var/jenkins_home \
#   jenkins-android-v1