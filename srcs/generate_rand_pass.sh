#!/bin/sh

< /dev/random tr -dc a-zA-Z0-9=._+- | head -c 79; echo