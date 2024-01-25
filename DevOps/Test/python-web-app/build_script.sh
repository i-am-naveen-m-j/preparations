
 
# Navigate to your Python project directory
# cd /path/to/your/python/project
 
# Install dependencies (if needed)




#!/bin/bash
echo "started shell script execution from here"
ls -la
pip install -r requirements.txt
cd devops
python3 manage.py runserver 0.0.0.0:8000





# nohup python3 manage.py runserver 0.0.0.0:8000 > server_log.txt 2>&1 & disown

# // nohup python3 manage.py runserver 0.0.0.0:8000

# Run your Python script to build the project
#python YOUR_PYTHON_SCRIPT.py
