#!/bin/bash 
docker run -p 10000:8888 -e JUPYTER_ENABLE_LAB=yes -v /home/mfc/Projects/:/home/jovyan/work smottahedi/statistical-rethinking
