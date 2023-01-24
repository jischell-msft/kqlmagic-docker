# kqlmagic-docker
 Built from jupyter/scipy-notebook, adding kqlmagic

 Available on docker hub: https://hub.docker.com/r/jischellmsft/kqlmagic


## Description
---
A docker container for running [Jupyter Lab](https://hub.docker.com/r/jupyter/scipy-notebook/) with [KqlMagic](https://github.com/microsoft/jupyter-Kqlmagic) with the minimum necessary ```venv``` wrangling. 

Getting consistent exploratory data analysis and investigative environments created and running shouldn't be hard, this is an attempt to minimize setup and configuration hurdles.

## Installation
---
```docker pull jischellmsft/kqlmagic```

## Usage
---
- Minimal invocation

    ```docker run jischellmsft/kqlmagic```

- Use Jupyter Lab (rather than Notebook) instance

    ```docker run -e JUPYTER_ENABLE_LAB=yes jischellmsft/kqlmagic```

- Specify different port (16384 rather than 8888)

    ```docker run -p 16834:8888 jischellmsft/kqlmagic```

- Use a folder from the host system in docker instance (assumes default container name of 'jovyan')

<strike>
<code>
    docker run --mount 'type=bind, src="C:\users\public\myNotebooks", dst=/home/jovyan/work' jischellmsft/kqlmagic
</code>    
</strike>

<code>
    docker run --rm -v 'C:\users\public\myNotebooks:/home/jovyan/work' -it jischellmsft/kqlmagic
</code>

- Start container with all of the optional examples above

    ```docker run --rm -p 16384:8888 -e JUPYTER_ENABLE_LAB=yes -v 'C:\users\public\myNotebooks:/home/jovyan/work' -it jischellmsft/kqlmagic -it jischellmsft/kqlmagic```

- Use the Start-DockerImage script

    ```
    . .\Start-DockerImage.ps1
    Start-DockerImage -ImageName jischellmsft/kqlmagic -FolderToMap C:\users\public\myNotebooks -LocalPort 16384
    ```