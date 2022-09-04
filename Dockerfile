ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:22.08-py3
FROM ${FROM_IMAGE_NAME}

WORKDIR /stable-diffusion

ADD ./environment.yaml /stable-diffusion
ADD ./setup.py /stable-diffusion

RUN conda env create -f environment.yaml

RUN conda init bash

# Activate the environment, and make sure it's activated:
RUN echo "conda activate ldm" > ~/.bashrc

RUN pip install opencv-python
RUN apt update && apt install -y libsm6 libxext6
RUN apt-get install libxrender1

ADD . .
