# TransferLab Training: Probabilistic Model Checking with Storm

Welcome to the TransferLab training: Probabilistic Model Checking with Storm.
The content was created by two major researchers in the field, Prof. [Joost-Pieter Katoen](https://moves.rwth-aachen.de/people/katoen/) and Assoc. Prof. [Sebastian Junges](https://sjunges.github.io). The course contains a mix of lectures and hands-on exercises covering
the fundamentals of probabilistic model checking as well as practical applications using the model checker Storm. 


## During the training

If you are currently participating in the training, you can find the agenda in
the file `AGENDA.md`. Everything is already set up, so feel free to follow the
trainer's presentation or to explore the notebooks and source code on your own.

## After the training

You have received this file as part of the training materials.

There are multiple ways of viewing/executing the content. 

1. If you just want to view the rendered notebooks, open `html/index.html` in
your browser.
2. If you want to execute the notebooks, we recommend to use docker. You can
build the image locally. First, set the variable
`PARTICIPANT_BUCKET_READ_SECRET` to the secret found in `config.yml`, and then
build the image with
    ```shell
    docker build --build-arg PARTICIPANT_BUCKET_READ_SECRET=$PARTICIPANT_BUCKET_READ_SECRET -t tfl-training-probabilistic-model-checking .
    ```
    You can then start the container e.g., with
    ```shell
    docker run -it -p 8888:8888 tfl-training-probabilistic-model-checking jupyter notebook
    ```
4. The data will be downloaded on the fly when you run the notebooks.

Note that there is some non-trivial logic in the entrypoint that may collide
with mounting volumes to paths directly inside
`/home/jovyan/tfl-training-probabilistic-model-checking`. If you want to do
that, the easiest way is to override the entrypoint or to mount somewhere else
and create a symbolic link. For details on that see the `Dockerfile` and
`entrypoint.sh`.

