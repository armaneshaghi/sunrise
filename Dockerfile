FROM ubuntu:bionic as builder 
USER root
RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER $UNAME
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
RUN conda install  --yes scikit-learn
RUN conda install  --yes joblib
RUN conda install  --yes -c conda-forge ipdb lifelines 
#COPY mplus8.4 /opt/mplus8.4
WORKDIR /mnt
RUN conda install -c anaconda pip
RUN pip install sklearn
RUN pip install scikit-survival
RUN conda install -c conda-forge pycox
RUN chmod 777 -R /opt/conda/lib/python3.9/site-packages/pycox
RUN conda install -c conda-forge sklearn-pandas 
RUN conda install -c conda-forge seaborn
RUN conda install -c conda-forge jupyter 
USER $USER
