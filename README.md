# DockerToSingularity
Examples of converting a docker image to singularity, and execute the singularity image

In this repository, we give an example of how to convert a Docker image to a Singularity Image Format (SIF) file. 

We will imagine the following scenario as a simple test case: someone created a `Dockerfile` to build a Docker enviroment. In this environment,the `numpy` module is installed by `conda`. This environment can be used to run a Python script `mat_sum.py`, where a matrix addition will be performed. Later this person would like to execute this Docker environment on a HPC environment, e.g.Snellius, where Docker is not available. So this person needs to convert this Docker image to a SIF before execution. 
## Preparation

To set up this test case, we will clone this repository:

```sh
git clone git@github.com:RS-DAT/DockerToSingularity.git
```

And use the directory of the cloned repository as the working directory:

```sh
cd DockerToSingularity
```
## Build a Docker image

In the directory the `Dockerfile` should already be available. One can build a Docker image by:

```sh
docker build . -t np_mat_sum 
```

## Convert the Docker image to Singularity Image Format (SIF)

The next step is to convert a Docker container to a Singularity Image Format (SIF). First, we need to output the Docker image as a `.tar` file:

```sh
docker save np_mat_sum -o np_mat_sum.tar
```

Then you need to expose the `tar` file to Singularity. Singularity uses the path in the format of `docker-archive://<path_to_the_tar>`. If you are using a Unix-like system you can just fill in the current directory. This example, on the other hand, is tested on WSL. Therefore to expose the `tar` file to Singularity, we can move the `tar` file to `/tmp`:

```sh
mv np_mat_sum.tar /tmp/np_mat_sum.tar 
```

Then the Singularity can build the SIF file from the `tar`.

```sh
sudo singularity build np_mat_sum.sif docker-archive:///tmp/np_mat_sum.tar
```

Note that singularty can also build SIF directly from the DockerHub, which may also be a common practice. See the [documentation of Singularity](https://docs.sylabs.io/guides/3.0/user-guide/build_a_container.html).

## Execute the SIF file

### At local

After building the SIF file locally, one can directly execute the Python script by:

```sh
singularity run np_mat_sum.sif
```

### On Snellius

To run the SIF on Snellius, you need to first upload `np_mat_sum.sif` and `mat_sum.py` to the same diretory on Snellius.

According to the [documentation of Snellius](https://servicedesk.surf.nl/wiki/pages/viewpage.action?pageId=30660251), one cannot execute SIF on the login node. There is a dedicated partition called `cbuild` for this purpose. You first need to claim a node in this partition. For example, we can claim a node in `cbuild` for 2 hours: 

```sh
salloc -p cbuild -t 2:00:00
```

Then you can log into the claimed node, say `srv2`

```sh
ssh srv2 # May require password, should be the pw of the Snelliu account
```

Then we can execute this SIF by:

```sh
singularity run np_mat_sum.sif
```
