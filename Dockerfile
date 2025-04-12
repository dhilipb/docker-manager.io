FROM mcr.microsoft.com/dotnet/runtime-deps:6.0

RUN apt update; \
    apt install -y unzip wget; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s|DEFAULT@SECLEVEL=2|DEFAULT@SECLEVEL=1|g" /etc/ssl/openssl.cnf

# Download and extract the latest ManagerServer release
RUN mkdir -p /opt/manager-server && \
    wget -qO- https://github.com/Manager-io/Manager/releases/latest/download/ManagerServer-linux-x64.tar.gz | tar -xz -C /opt/manager-server && \
    chmod +x /opt/manager-server/ManagerServer

# Run instance of Manager
CMD ["/opt/manager-server/ManagerServer","-port","8080","-path","/data"]

VOLUME /data
EXPOSE 8080

