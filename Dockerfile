FROM python:2
MAINTAINER Chiradeep Vittal <chiradeep.vittal@citrix.com>
RUN mkdir -p /tmp
RUN (cd /tmp && wget http://downloadns.citrix.com.edgesuite.net/11872/ns-11.0-65.31-sdk.tar.gz )
RUN (cd /tmp && tar xvzf ns-11.0-65.31-sdk.tar.gz && \
    tar xvzf ns-11.0-65.31-nitro-python.tgz && \
    tar xvf ns_nitro-python_ion_65_31.tar && \
    cd nitro-python-1.0/ && \
    python setup.py install && \
    cd / && \
    rm -rf /tmp && \
    mkdir -p /usr/src/app)

RUN pip install docker-py
RUN pip install pyyaml

COPY *.py /usr/src/app/
COPY swarm/ /usr/src/app/swarm/
COPY marathon/ /usr/src/app/marathon/
COPY kubernetes/ /usr/src/app/kubernetes/
COPY consul/ /usr/src/app/consul/

ENTRYPOINT ["python", "/usr/src/app/main.py" ]
