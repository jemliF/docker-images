FROM java:8
MAINTAINER fathi.jemli@proxym-it.com

WORKDIR /home
# Download dev kit
RUN wget http://public.dhe.ibm.com/ibmdl/export/pub/software/products/en/MobileFirstPlatform/mobilefirst-deved-devkit-linux-8.0.0.0.bin
# Or just copy it from current folder
#COPY ./mobilefirst-deved-devkit-linux-8.0.0.0.bin /home
COPY ./installation.properties /home

# Install Mobile First Platform
RUN chmod +x mobilefirst-deved-devkit-linux-8.0.0.0.bin
# Run devkit installer in silent mode using an installation file
RUN ./mobilefirst-deved-devkit-linux-8.0.0.0.bin -i silent -f installation.properties

ENTRYPOINT /root/MobileFirst-8.0.0.0/run.sh
EXPOSE 9080