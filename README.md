# DockerToSingularity
Examples of converting a docker image to singularity, and execute the singularity image

## Build Docker image

```sh
git clone git@github.com:RS-DAT/DockerToSingularity.git
```

```sh
cd DockerToSingularity
```


```sh
docker build . -t np_mat_sum 
```

## Convert Docker image to Singularity image (sif)

```sh
docker save np_mat_sum -o np_mat_sum.tar
```

```sh
mv np_mat_sum.tar /tmp/np_mat_sum.tar 
```

```sh
sudo singularity build np_mat_sum.sif docker-archive:///tmp/np_mat_sum.tar
```

## Execute the Singularity image

### At local

```sh
singularity run np_mat_sum.sif
```

### On Snellius

```sh
salloc -p cbuild -t 2:00:00
```

```sh
ssh srv2 # May require password, should be the pw of the Snelliu account
```

```sh
singularity run np_mat_sum.sif
```
