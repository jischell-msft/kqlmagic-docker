ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

USER root

RUN apt-get update --yes && \
    apt-get install --yes \
    libgirepository1.0-dev \
    libcairo2-dev \
    python3-dev \ 
    gir1.2-secret-1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

ENV PATH /opt/conda/envs/env/bin:$PATH

ENV INSTALL_CONDA_PACKAGES plotly \
    pandas-profiling 

# Install kqlmagic and related packages
ENV INSTALL_PIP_PACKAGES jupyterlab-git \ 
    kqlmagic \
    pyvis \
    setuptools_git \
    pandas-bokeh \
    datetime \
    pycairo \
    PyGObject

# Install conda and pip packages
RUN conda install --quiet --yes ${INSTALL_CONDA_PACKAGES} && \
    pip install --upgrade --quiet ${INSTALL_PIP_PACKAGES} && \
    conda clean --all -f -q -y && \
    pip cache purge && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
 
RUN jupyter labextension install @jupyterlab/git --no-build && \
    jupyter labextension enable git && \
    jupyter lab build --dev-build=False

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

# The first time you 'import plotly' on a new system, it has to build the
# font cache.  This takes a while and also causes spurious warnings, so
# we can just do that during the build process and the user never has to
# see it.
RUN /opt/conda/bin/python -c 'import plotly'