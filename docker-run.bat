call "%~dp0set_env.bat"

docker run -itd ^
    --name devops-de2 ^
    -v "%USER_HOME%\.aws:/home/hadoop/.aws" ^
    -v "%USER_HOME%\.ssh:/home/hadoop/.ssh" ^
    -v "%DOCKER_SHARE%\jupyter_workspace:/home/hadoop/workspace/jupyter_workspace" ^
    -v "%DOCKER_SHARE%\.jupyter:/home/hadoop/.jupyter" ^
    -v "%DOCKER_SHARE%\logs:/home/hadoop/logs" ^
    -v "%GIT_REPO_HOME%:/home/hadoop/workspace/practice-repo" ^
    -v "%WORKSPACE_HOME%:/home/hadoop/workspace" ^
    -e AWS_REGION=us-west-2 ^
    -e AWS_PROFILE=%AWS_PROFILE% ^
    -e DISABLE_SSL=true ^
    -p 4040:4040 -p 18080:18080 -p 8998:8998 -p 8888:8888 ^
    local/glue_5 ^
    "jupyter lab --ip=0.0.0.0 --no-browser --NotebookApp.token='' --NotebookApp.password=''"
