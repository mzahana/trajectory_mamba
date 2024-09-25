# trajectory_mamba

This repository provides a Docker environment for setting up a Python-based AI development environment, specifically optimized for projects that use PyTorch and the `mamba-ssm` library. The Docker environment is built with NVIDIA CUDA 11.8 and supports GPU acceleration using CUDA-enabled PyTorch. It now supports both **Windows WSL2** and **non-WSL2** environments.

## Repository Contents

- **Dockerfile**: Defines the Docker image for non-WSL2 environments with CUDA 11.8, Python 3.10, and all necessary build tools for machine learning development.
- **Dockerfile.wsl2**: Defines the Docker image specifically for WSL2 with CUDA 11.8.
- **requirements.txt**: Lists the Python dependencies for the project.
- **run_container.sh**: A script that builds and either runs or enters the Docker container for non-WSL2 environments.
- **run_container_wsl2.sh**: A script that builds and either runs or enters the Docker container specifically for WSL2 environments.

## Prerequisites

Before using this repository, ensure you have the following installed, based on your system:

### For Both Pure Ubuntu and WSL2:

- **Docker**: Install the latest version of Docker on your machine. 
  - For Ubuntu: [Docker Installation Guide for Ubuntu](https://docs.docker.com/engine/install/ubuntu/).
  - For WSL2: Docker Desktop for Windows comes with WSL2 integration.

- **NVIDIA Drivers**: Ensure that you have the appropriate NVIDIA drivers installed on your machine.
  - For Ubuntu: Install the latest NVIDIA drivers through `apt` or from the NVIDIA website.
  - For WSL2: Follow the steps below to install the WSL2-specific NVIDIA drivers.

### For Pure Ubuntu:

- **NVIDIA Container Toolkit**: This is required to run containers with GPU access on pure Ubuntu. You can set this up as follows:

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

### Additional Steps for Windows WSL2:

- **Install NVIDIA Drivers for WSL2**:
  Windows requires a special driver to enable GPU access in WSL2. Follow these steps:
  
  1. Download and install the [WSL2 NVIDIA Driver](https://developer.nvidia.com/cuda/wsl/download).
  
  2. Verify that your GPU is visible inside WSL2 by running:
  
     ```bash
     wsl --list --verbose
     ```

  3. Install the latest version of **Docker Desktop** on Windows and ensure that WSL2 integration is enabled.

- **Configure Docker Desktop for WSL2 GPU Support**:
  1. Open Docker Desktop and go to **Settings** > **Resources** > **WSL Integration**.
  2. Ensure that the correct WSL2 distributions are enabled for Docker integration.
  3. Under **Settings** > **Resources** > **GPU**, ensure that **"Enable GPU support"** is checked.

Once the above is set up, you can run GPU-accelerated containers in WSL2 just like in a native Linux environment.


## Building and Running the Docker Container

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/mzahana/trajectory_mamba.git
cd trajectory_mamba
```

### 2. Choose Your Environment (WSL2 or Non-WSL2)

- For **Windows WSL2**, use the `run_container_wsl2.sh` script, which relies on `Dockerfile.wsl2`.
- For **non-WSL2** systems (e.g., pure Linux), use the `run_container.sh` script, which uses the standard `Dockerfile`.

### 3. Build and Run the Docker Container

#### For **Non-WSL2**:

To build and run the container in non-WSL2 environments, use the `run_container.sh` script:

```bash
./run_container.sh
```

This will:

- Build the Docker image using the `Dockerfile`.
- Run the container with GPU support, mounting the current directory into the container for seamless development.
- If the container is already running, it will attach you to the running container's shell.

#### For **WSL2**:

To build and run the container in WSL2 environments, use the `run_container_wsl2.sh` script:

```bash
./run_container_wsl2.sh
```

This will:

- Build the Docker image using the `Dockerfile.wsl2`.
- Run the container with GPU support specifically configured for WSL2.
- If the container is already running, it will attach you to the running container's shell.

## File Descriptions

### 1. Dockerfile

The `Dockerfile` sets up the environment with the following key components:

- **CUDA 11.8**: Provides GPU acceleration.
- **Python 3.10**: The Python version used in the container.
- **PyTorch with CUDA 11.8**: For GPU-accelerated machine learning.
- **Precompiled mamba-ssm**: The mamba-ssm library is installed via a precompiled wheel.

### 2. Dockerfile.wsl2

Similar to the standard `Dockerfile`, but tailored for use with WSL2 on Windows, ensuring proper CUDA setup for WSL2 environments.

### 3. requirements.txt

This file lists the Python dependencies required for the project, which are installed in the container.

### 4. run_container.sh (Non-WSL2)

This shell script automates the process of building the Docker image and running or entering the container for non-WSL2 environments.

- It builds the Docker image with GPU support.
- Mounts the local project directory into the container.
- Automatically checks and removes any existing containers with the same name before running a new one or enters the container if it's already running.

### 5. run_container_wsl2.sh (WSL2)

This script is the WSL2-specific version of `run_container.sh`, designed to build and run the container with WSL2-specific configurations using the `Dockerfile.wsl2`.

### 6. Running S-Mamba

* Run the container using either `./run_container.sh` (non-WSL2) or `./run_container_wsl2.sh` (WSL2).
* Once you are inside the container shell, execute `cd pkgs` then clone the [S-D-Mamba repo](https://github.com/wzhwzhwzh0921/S-D-Mamba):

```bash
git clone https://github.com/wzhwzhwzh0921/S-D-Mamba.git
```

* Download the datasets from [this link](https://github.com/wzhwzhwzh0921/S-D-Mamba/releases/download/datasets/S-Mamba_datasets.zip), extract the directory, and rename it to `dataset`, and put it in the `S-D-Mamba` directory.

* Then, you can run the example scripts as described in the [S-D-Mamba repo](https://github.com/wzhwzhwzh0921/S-D-Mamba).

## Contributing

Feel free to open issues or submit pull requests if you find any bugs or want to add new features.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
