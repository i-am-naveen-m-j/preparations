#!/bin/bash
 
# Navigate to your Python project directory
# cd /path/to/your/python/project
 
# Install dependencies (if needed)
ls -la
pip install -r requirements.txt

cd devops

pwd
ls -la

nohup python3 manage.py runserver 0.0.0.0:8000 > server_log.txt 2>&1 &
disown

# // nohup python3 manage.py runserver 0.0.0.0:8000


 
# Run your Python script to build the project
#python YOUR_PYTHON_SCRIPT.py
