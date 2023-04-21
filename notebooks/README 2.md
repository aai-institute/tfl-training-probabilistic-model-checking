# Storm tutorial at DisCoTec 2020

The directory contains Jupyter notebooks for the [Storm tutorial](https://www.discotec.org/2020/tutorials#the-probabilistic-model-checker-storm) at [DisCoTec 2020](https://www.discotec.org/2020/)

- [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/moves-rwth/stormpyter/discotec2020?filepath=tutorial_discotec2020%2Fdiscotec_storm.ipynb)
`discotec_storm.ipynb` contains an interactive presentation about the usage and features of [Storm](https://www.stormchecker.org/).
- [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/moves-rwth/stormpyter/discotec2020?filepath=tutorial_discotec2020%2Fdiscotec_stormpy.ipynb)
`discotec_stormpy.ipynb` contains an interactive presentation about advanced features with [stormpy](https://moves-rwth.github.io/stormpy/), the Python bindings for Storm.


## Following the presentation

The presentation is interactive.
All commands can be executed in the presentation and will be executed in the Docker container.

- Navigate forwards with `spacebar` and backwards with `shift+spacebar`.
- All interactive commands can be executed with `shift+enter`.
- Switch between presentation and the notebook with `alt+r`.


## Videos

Videos of the tutorial are available on YouTube:
1. [Part 1](https://www.youtube.com/watch?v=TTfSZGiCQ3I): "What is Storm?"
2. [Part 2](https://www.youtube.com/watch?v=rCgoqV5hesQ): "Introduction to Storm"
3. [Part 3](https://www.youtube.com/watch?v=WR72wrvtta0): "Advanced Features with Stormpy"


## Installation steps

1. Install Docker for your OS according to [these instructions](https://docs.docker.com/get-docker/).

2. Download and start the Docker container from the command line:

```
docker run -it -p 8080:8080 --name stormpyter movesrwth/stormpyter:discotec2020
```
(Please note that the download with >1GB might take a while.)

3. Open the Jupyter website which is indicated in the command line and starts with `127.0.0.1:8080/?token=...`

4. On the website, open the notebook `discotec_storm.ipynb` or `discotec_stormpy.ipynb`.
The presentation should start automatically.


## Manual build
Instead of downloading the Docker container, you can also build it manually with:
```
docker build -t movesrwth/stormpyter:discotec2020 -f Dockerfile .
```
and afterwards continue with step 3.

