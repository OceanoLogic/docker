# Official AWS Glue 5.0 base image
FROM public.ecr.aws/glue/aws-glue-libs:5

# Set PATH and PYTHONPATH
ENV PATH="/home/hadoop/.local/bin:${PATH}"
ENV PYTHONPATH=$PYTHONPATH:/home/hadoop/aws-glue-libs/PyGlue.zip:/home/hadoop/spark/python/lib/py4j-0.10.9.7-src.zip:/home/hadoop/spark/python/

# Upgrade pip and install dependencies
RUN pip3 install --upgrade pip

# TODO Change to install requirements.txt
COPY requirements.txt /home/hadoop/requirements.txt
RUN pip3 install -r /home/hadoop/requirements.txt


# Install Python packages
RUN pip3 install \
    awswrangler \
    pyarrow \
    snowflake-connector-python \
    jsonpath-rw \
    jsonpath-ng \
    pytest \
    build \
    black \
    sqlparse \
    jupyterlab \
    notebook

# Install required system tools and add Azure
pip3 install azure-cli

# Create required directories
RUN mkdir /home/hadoop/git 
RUN mkdir /home/hadoop/logs 
RUN mkdir -p /home/hadoop/workspace/jupyter_workspace

RUN chown hadoop /home/hadoop/git 
RUN chown hadoop /home/hadoop/logs 
RUN chown hadoop /home/hadoop/workspace/jupyter_workspace

# Global git configuration
RUN git config --global core.excludesfile ~/.gitignore && \
    echo .DS_Store >> ~/.gitignore

# Expose commonly used ports (Spark UI, Jupyter, etc.)
EXPOSE 4040 18080 8998 8888

# Default entrypoint to launch an interactive bash shell
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
