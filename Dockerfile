FROM debian
RUN apt-get update && apt-get install -y wget
RUN wget https://www.multichain.com/download/multichain-1.0.1.tar.gz && \
    tar -xvzf multichain-1.0.1.tar.gz && \
    cd multichain-1.0.1 && \
    mv multichaind multichain-cli multichain-util /usr/local/bin

CMD bash
