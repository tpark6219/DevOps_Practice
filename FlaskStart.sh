#!/bin/bash

export FLASK_APP=app.py
nohup flask run --host=0.0.0.0 --port=3000 &
