FROM debian
RUN apt-get update && \
    apt-get install -y wget python-pip sqlite3 libsqlite3-dev python-dev python-pip git vi && \
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

RUN multichain-util create chain1 && \
    multichaind chain1 -daemon && \
    cd ~/.multichain/chain1/ && \
    echo "rpcport="`grep rpc params.dat| awk {'print $3'}` >> multichain.conf && \
    cd /multichain-explorer && \
    cp chain1.example.conf chain1.conf && \
    sed -i 's/host localhost/host 0.0.0.0/g' chain1.conf

CMD multichaind chain1 -daemon && \
    cd /multichain-explorer && \
    python -m Mce.abe --config chain1.conf --commit-bytes 100000 --no-serve && \
    python -m Mce.abe --config chain1.conf
