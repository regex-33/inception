FROM debian:buster

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    wget \
    tcl \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://download.redis.io/releases/redis-7.2.4.tar.gz && \
    tar xzf redis-7.2.4.tar.gz && \
    cd redis-7.2.4 && \
    make && \
    make install && \
    cp redis.conf /etc/redis.conf && \
    cd .. && \
    rm -rf redis-7.2.4.tar.gz redis-7.2.4

# Create Redis user and directories
RUN mkdir -p /var/lib/redis && \
    useradd -r -s /bin/false redis && \
    chown -R redis:redis /var/lib/redis

# Configure Redis
RUN sed -i 's/^bind 127.0.0.1 -::1/bind 0.0.0.0/' /etc/redis.conf && \
    sed -i 's/^daemonize yes/daemonize no/' /etc/redis.conf && \
    sed -i 's/^dir .\//dir \/var\/lib\/redis/' /etc/redis.conf && \
    sed -i 's/^protected-mode yes/protected-mode no/' /etc/redis.conf

# Switch to redis user
USER redis

# Expose Redis port
EXPOSE 6379

# Start Redis server
CMD ["redis-server", "/etc/redis.conf"]