FROM java:8
MAINTAINER fathi.jemli@proxym-it.com

# Update and Install Git and Maven and ftp-upload
RUN apt-get update && apt-get --assume-yes install --no-install-recommends -y zip unzip apt-utils wget git maven lftp ftp-upload jq figlet && rm -rf /var/lib/apt/lists/*

# Install node 6
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install --no-install-recommends -y nodejs

# Install cordova, mfpdevcli and angular-cli
RUN npm i -g mfpdev-cli && npm i -g cordova@6.4.0 && npm i -g @angular/cli

# Download sonar scanner
RUN cd /opt && wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip && unzip sonar-scanner-cli-3.2.0.1227-linux.zip
# Add sonar scanner to PATH
ENV PATH ${PATH}:/opt/sonar-scanner-cli-3.2.0.1227-linux/bin

# Update settings.xml Maven config file
COPY ./settings.xml /usr/share/maven/conf/settings.xml

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install --no-install-recommends -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl libqt5widgets5 && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*


# Install Android

# Copy install tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar xzf android-sdk.tgz && \
  rm -f android-sdk.tgz && \
  chown -R root.root android-sdk-linux && \
  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools" && \
  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools,build-tools-21.0.0,build-tools-21.0.1,build-tools-21.0.2,build-tools-21.1.0,build-tools-21.1.1,build-tools-21.1.2,build-tools-22.0.0,build-tools-22.0.1,build-tools-23.0.0,build-tools-23.0.3,build-tools-24.0.0,build-tools-24.0.1,build-tools-24.0.2,build-tools-24.0.3,build-tools-25.0.0,android-21,android-22,android-23,android-24,android-25,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services,sys-img-armeabi-v7a-android-24"

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN which adb
RUN which android

# Install Gradle
RUN wget https://downloads.gradle.org/distributions/gradle-4.5.1-bin.zip
RUN mkdir /opt/gradle && unzip -d /opt/gradle gradle-4.5.1-bin.zip
ENV GRADLE_HOME /opt/gradle/gradle-4.5.1
ENV PATH ${PATH}:${GRADLE_HOME}/bin
RUN gradle -v

# Cleaning
RUN apt-get clean

CMD tail -f /dev/null