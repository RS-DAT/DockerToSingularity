FROM continuumio/miniconda3

COPY ./mat_sum.py /src/docker2singularity/mat_sum.py
WORKDIR /src/docker2singularity
RUN conda update -y conda && conda install -y numpy && conda create --name np_mat_sum && conda clean --all -y

# Run a simple command
CMD  ["conda", "run", "--name", "np_mat_sum", "python", "/src/docker2singularity/mat_sum.py"]



