FROM debian
RUN apt-get update && \
    apt-get install -y wget python-pip sqlite3 libsqlite3-dev python-dev python-pip && \
    pip install Crypto && \
    pip install --upgrade pip && \
    pip install pycrypto

RUN wget https://www.multichain.com/download/multichain-1.0.1.tar.gz && \
    tar -xvzf multichain-1.0.1.tar.gz && \
    cd multichain-1.0.1 && \
    mv multichaind multichain-cli multichain-util /usr/local/bin

RUN git clone https://github.com/MultiChain/multichain-explorer.git && \
    cd multichain-explorer && \
    python setup.py install

CMD bash
