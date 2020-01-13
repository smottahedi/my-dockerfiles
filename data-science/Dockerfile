# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/pyspark-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

# RSpark config
ENV R_LIBS_USER $SPARK_HOME/R/lib
RUN fix-permissions $R_LIBS_USER

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    vim \
    git-lfs \
    gcc && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN conda install --quiet --yes \
    'beautifulsoup4=4.8.*' \
    'conda-forge::blas=*=openblas' \
    'bokeh=1.3*' \
    'cloudpickle=1.2*' \
    'cython=0.29*' \
    'dask=2.2.*' \
    'dill=0.3*' \
    'h5py=2.9*' \
    'hdf5=1.10*' \
    'ipywidgets=7.5*' \
    'matplotlib-base=3.1.*' \
    'numba=0.45*' \
    'numexpr=2.6*' \
    'pandas=0.25*' \
    'patsy=0.5*' \
    'protobuf=3.9.*' \
    'scikit-image=0.15*' \
    'scikit-learn=0.21*' \
    'scipy=1.3*' \
    'seaborn' \
    'sqlalchemy=1.3*' \
    'statsmodels=0.10*' \
    'sympy=1.4*' \
    'vincent=0.4.*' \
    'xlrd' \
    'dask' \
    && \
    conda clean --all -f -y && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    # Also activate ipywidgets extension for JupyterLab
    # Check this URL for most recent compatibilities
    # https://github.com/jupyter-widgets/ipywidgets/tree/master/packages/jupyterlab-manager
    jupyter labextension install @jupyter-widgets/jupyterlab-manager@^1.0.1 --no-build && \
    jupyter labextension install jupyterlab_bokeh@1.0.0 --no-build && \
    jupyter labextension install @jupyterlab/git --no-build && \
    jupyter labextension install @jupyterlab/toc --no-build && \
    jupyter labextension install @aquirdturtle/collapsible_headings --no-build && \
    jupyter labextension install @ijmbarr/jupyterlab_spellchecker --no-build && \
    jupyter labextension install jupyterlab_vim --no-build && \
    jupyter labextension install jupyterlab-drawio --no-build && \
    jupyter labextension install @krassowski/jupyterlab_go_to_definition --no-build && \
    jupyter lab build && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER



RUN conda install pytorch torchvision cpuonly -c pytorch && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir \
    pyro-ppl && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# R packages
RUN conda install --quiet --yes \
    'r-base' \
    'r-ggplot2' \
    'r-irkernel' \
    'r-rcurl' \
    'r-sparklyr' \
    'r-languageserver'  \
    && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Apache Toree kernel
RUN pip install --no-cache-dir \
    https://dist.apache.org/repos/dist/release/incubator/toree/0.3.0-incubating/toree-pip/toree-0.3.0.tar.gz \
    && \
    jupyter toree install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Spylon-kernel
RUN conda install --quiet --yes 'spylon-kernel=0.4*' && \
    conda clean --all -f -y && \
    python -m spylon_kernel install --sys-prefix && \
    rm -rf /home/$NB_USER/.local && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Apache Toree kernel
RUN pip install --no-cache-dir \
    ipython-sql \
    tensorflow \
    mlflow \
    pipenv \
    xgboost \
    kedro \
    statsmodels \
    bokeh \
    && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
