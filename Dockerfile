FROM ubuntu:20.04
# 安装miniconda
#wget https://repo.anaconda.com/miniconda/Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
COPY Miniconda3-py39_23.1.0-1-Linux-x86_64.sh .
RUN /bin/bash Miniconda3-py39_23.1.0-1-Linux-x86_64.sh -b && rm Miniconda3-py39_23.1.0-1-Linux-x86_64.sh
ENV PATH=/root/miniconda3/bin:${PATH}

ENV DEBIAN_FRONTEND=noninteractive
RUN conda install -c http://mirrors.aliyun.com/anaconda/cloud/conda-forge --override-channels "gxx>=12.1" h5py "hdf5>=1.12" matplotlib numpy pyside2 "python=3.8" zlib

RUN apt update
RUN apt install -y curl vim wget 

RUN curl -fsSL https://deb.nodesource.com/setup_current.x && apt-get install -y nodejs

COPY requirement.txt .
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ --no-cache-dir -r requirement.txt
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ h5py matplotlib numpy pyside2

RUN conda install -y pytorch
RUN apt-get install ffmpeg libsm6 libxext6 libgl1 zip -y

RUN pip install -i https://mirrors.aliyun.com/pypi/simple/  defusedxml shapely tensorflow tensorboard gif psutil torchvision


ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV LANG=C.UTF-8
ENV MPLBACKEND="TkAgg"
ENV LD_LIBRARY_PATH=/data/workspace/DarwinOS-0.2.1-Ubuntu20.04/lib:$LD_LIBRARY_PATH