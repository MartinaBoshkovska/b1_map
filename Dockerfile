FROM jupyter/base-notebook:8ccdfc1da8d5

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl \
        wget \
        gfortran \
        cmake \
        bsdtar  \
        rsync \
        imagemagick \
        gnuplot-x11 \
        libopenblas-base \
        octave \
        liboctave-dev  \
        octave-info \
        octave-parallel \
        octave-struct \
        octave-io \
        octave-statistics \
        octave-optim \
        octave-image \
        python3-dev \
        ttf-dejavu && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd $HOME/work;\
    pip install octave_kernel \
                sos==0.17.7 \
                sos-notebook==0.17.2 \
                sos-python==0.9.12.1 \
                sos-bash==0.12.3 \
                sos-matlab==0.9.12.1 \
                sos-ruby==0.9.15.0 \
                sos-sas==0.9.12.3 \
                sos-julia==0.9.12.1 \
                sos-javascript==0.9.12.2 \
                sos-r==0.9.12.2 \
                scipy==1.1.0 \
                plotly==4.4.1 \
                plotly_express==0.4.1 \
                nibabel==3.0.0 \
                dash==1.6.1 \
                dash_core_components==1.5.1 \
                dash_html_components==1.0.2 \
                dash_dangerously_set_inner_html \
                dash-renderer==1.2.0 \
                jupyter_plotly_dash==0.3.1 \
                flask==1.0.2; \
    python -m sos_notebook.install;\
    git clone https://github.com/MartinaBoshkovska/b1_map.git;        \
    cd b1_map;\
    git clone https://github.com/neuropoly/qMRLab.git;   \
    cd qMRLab; \
    git checkout master; \
    cd ..; \
    chmod -R 777 $HOME/work/b1_map; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

WORKDIR $HOME/work/b1_map

USER $NB_UID
