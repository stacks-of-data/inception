#!/bin/sh

set -e

JUPYTERLAB_TOKEN=$(< /run/secrets/jupyterlab_token tr -d '\n')
JUPYTERLAB_USER_PASS=$(< /run/secrets/jupyterlab_user_pass tr -d '\n')

chown -R "$JUPYTERLAB_USERNAME:$JUPYTERLAB_USERNAME" /home/"$JUPYTERLAB_USERNAME"/working

printf "\nc.NotebookApp.token = '%s'" "$JUPYTERLAB_TOKEN" \
    >> /home/"$JUPYTERLAB_USERNAME"/.jupyter/jupyter_server_config.py

echo "$JUPYTERLAB_USERNAME:$JUPYTERLAB_USER_PASS" | chpasswd

exec su "$JUPYTERLAB_USERNAME" -s /bin/bash -c "$@"