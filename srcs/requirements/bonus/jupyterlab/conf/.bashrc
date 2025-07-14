#!/bin/bash

PS1='\[\e[32m\]\u\[\e[0m\]:\W\\$ '

if [ -d "$HOME/default" ]; then
    source "$HOME/default/bin/activate"
fi

source $HOME/.local/bin/env