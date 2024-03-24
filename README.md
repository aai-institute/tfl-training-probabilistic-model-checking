# TransferLab Training: Verifying Systems in the Face of Uncertainty

Welcome to the TransferLab training: Probabilistic Verifying Systems in the Face of Uncertainty.
The content was created and presented by two major researchers in the field, Prof. [Joost-Pieter Katoen](https://moves.rwth-aachen.de/people/katoen/) and Assoc. Prof. [Sebastian Junges](https://sjunges.github.io). The course contains a mix of lectures and hands-on exercises covering
the fundamentals of probabilistic model checking as well as practical applications using the model checker Storm. 

## Course video
The event took place on 1st December 2023. The recorded Lecture is available on our [TranferLab website](https://transferlab.ai/trainings/verifying-systems-in-the-face-of-uncertainty/) 

## Getting started

If you want to execute the notebooks, we recommend to use docker. You can
eigther download a pre-build image from ghcr or build the image locally. 

1. Option a) Pull the pre-build image from [ghcr.io](ghcr.io/aai-institute/tfl-training-probabilistic-model-checking:main)
   ```shell
   docker pull ghcr.io/aai-institute/tfl-training-probabilistic-model-checking:main
   ```
   Option b) Build the image within your local clone of the repository with

    ```shell
    docker build -t tfl-training-probabilistic-model-checking .
    ```
    
2. You can then start the container e.g., with
    ```shell
    docker run -it -p 8888:8888 tfl-training-probabilistic-model-checking jupyter notebook
    ```
3. Run the first notebook **welcome_run_me_first.ipynb** within jupyter. This will download the data for 
the workshop and finilize the setup.

Note that there is some non-trivial logic in the entrypoint that may collide
with mounting volumes to paths directly inside
`/home/jovyan/tfl-training-probabilistic-model-checking`. If you want to do
that, the easiest way is to override the entrypoint or to mount somewhere else
and create a symbolic link. For details on that see the `Dockerfile` and
`entrypoint.sh`.

## License

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
