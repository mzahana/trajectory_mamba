# trajectory_mamba

This repository provides a Docker environment for setting up a Python-based AI development environment, specifically optimized for projects that use PyTorch and the `mamba-ssm` library. The Docker environment is built with NVIDIA CUDA 11.8 and supports GPU acceleration using CUDA-enabled PyTorch.

## Repository Contents

- **Dockerfile**: Defines the Docker image with CUDA 11.8, Python 3.10, and all necessary build tools for machine learning development.
- **requirements.txt**: Lists the Python dependencies for the project.
- **run_container.sh**: A shell script that builds the Docker image and runs the container with GPU support.
- **enter_container.sh**: A shell script that allows you to enter the running Docker container’s shell.

## Prerequisites

Before using this repository, ensure you have the following installed:

- **Docker**: The latest version of Docker installed on your machine.
- **NVIDIA Drivers**: Ensure that you have the appropriate NVIDIA drivers and CUDA toolkit installed.
- **NVIDIA Container Toolkit**: This is required to run containers with GPU access.

### Setting Up NVIDIA Container Toolkit

If you don’t have the NVIDIA Container Toolkit installed, you can follow these steps:

```bash
# Set up the package repository
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Install the NVIDIA container runtime
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# Restart Docker to apply changes
sudo systemctl restart docker
```

Once the toolkit is set up, you can run containers with GPU support.

## Building and Running the Docker Container

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/mzahana/trajectory_mamba.git
cd trajectory_mamba
```

### 2. Build the Docker Image

Run the provided `run_container.sh` script to build the Docker image and start the container:

```bash
./run_container.sh
```

This will:

- Build the Docker image using the provided `Dockerfile`.
- Run the container with GPU support, mounting the current directory into the container for seamless development.

### 3. Enter the Running Container

Once the container is running, you can enter its shell by executing the `enter_container.sh` script:

```bash
./enter_container.sh
```

This script checks if the container is running and attaches you to the container’s shell.

## File Descriptions

### 1. Dockerfile

The `Dockerfile` sets up the environment with the following key components:

- **CUDA 11.8**: Provides GPU acceleration.
- **Python 3.10**: The Python version used in the container.
- **PyTorch with CUDA 11.8**: For GPU-accelerated machine learning.
- **Precompiled mamba-ssm**: The mamba-ssm library is installed via a precompiled wheel.

### 2. requirements.txt

This file lists the Python dependencies required for the project, which are installed in the container.

### 3. run_container.sh

This shell script automates the process of building the Docker image and running the container.

- It builds the Docker image with GPU support.
- Mounts the local project directory into the container.
- Automatically checks and removes any existing containers with the same name before running a new one.

### 4. enter_container.sh

This script allows you to easily enter the running container. It checks if the container is already running, and if not, it starts the container and attaches to it.

### 5. Running S-Mamba
* Run the container using `./run_container.sh`
* Once you are inside the container shell, execute `cd pkgs` then clone the [S-D-Mamba repo](https://github.com/wzhwzhwzh0921/S-D-Mamba)
```bash
git clone https://github.com/wzhwzhwzh0921/S-D-Mamba.git
```
* Download the datasets from [this link](https://github.com/wzhwzhwzh0921/S-D-Mamba/releases/download/datasets/S-Mamba_datasets.zip), extraxt the directory, and rename it to `dataset`, and put it in the `S-D-Mamba` directory

* Then, you can run the example scripts as described in [S-D-Mamba repo](https://github.com/wzhwzhwzh0921/S-D-Mamba)

## Contributing

Feel free to open issues or submit pull requests if you find any bugs or want to add new features.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
