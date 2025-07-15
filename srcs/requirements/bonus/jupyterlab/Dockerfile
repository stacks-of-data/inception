FROM debian:11

ARG UID=10002
ARG USERNAME="jupyterlab"

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y python3 python3-venv \
    vim nano wget curl && \
    apt clean
    
RUN useradd -mu $UID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

RUN wget -qO- https://astral.sh/uv/install.sh | sh

RUN python3 -m venv default

COPY --chown=$USERNAME:$USERNAME ./conf/.bashrc .
COPY --chown=$USERNAME:$USERNAME ./conf/jupyter_server_config.py .jupyter/
COPY --chown=$USERNAME:$USERNAME ./conf/themes.jupyterlab-settings .jupyter/lab/user-settings/\@jupyterlab/apputils-extension/
COPY --chown=$USERNAME:$USERNAME ./conf/notification.jupyterlab-settings .jupyter/lab/user-settings/\@jupyterlab/apputils-extension/
COPY --chmod=700 --chown=$USERNAME:$USERNAME ./tools/jupyterlab-entrypoint.sh /usr/local/bin/

RUN source ~/default/bin/activate && \
    source ~/.local/bin/env && \
    uv pip install --no-cache-dir jupyterlab python-language-server[all] \
    numpy pandas scipy matplotlib seaborn scikit-learn

USER root
WORKDIR /home/$USERNAME/working

EXPOSE 8888

ENTRYPOINT ["jupyterlab-entrypoint.sh"]

CMD source ../default/bin/activate && \
    jupyter lab --ip=0.0.0.0 --no-browser