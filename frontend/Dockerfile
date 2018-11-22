FROM node:8-alpine
MAINTAINER fathi.jemli@proxym-it.com

# Update and Install Git and Maven and ftp-upload
RUN apk update && apk --update --allow-untrusted add zip unzip wget git maven jq yarn && rm -rf /var/cache/apk/*

# Download sonar scanner
RUN wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip && unzip sonar-scanner-cli-3.0.3.778-linux.zip
# Add sonar scanner to PATH
ENV PATH ${PATH}:/sonar-scanner-3.0.3.778-linux/bin

# Install common frontend
RUN npm i -g @angular/cli cordova bower webpack gulp grunt jslint tslint