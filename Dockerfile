# Use NVIDIA's official CUDA 11.8 base image with Ubuntu 22.04
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Set environment variables to prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential system packages and build tools
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    git \
    wget \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN python3.10 -m pip install --upgrade pip

# Create a non-root user 'ai' with sudo privileges
RUN useradd -m ai && echo "ai:ai" | chpasswd && adduser ai sudo

# Allow passwordless sudo for 'ai' (optional for security)
RUN echo "ai ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set the user to 'ai'
USER ai

# Set the working directory
WORKDIR /home/ai/app

# Copy the requirements.txt file into the container
COPY --chown=ai:ai requirements.txt .

# Install torch with CUDA 11.8 support first to satisfy build dependencies
RUN pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu118

# Install packaging to satisfy mamba-ssm dependencies
RUN pip install packaging

# Install the precompiled wheel for mamba-ssm
RUN pip install https://github.com/state-spaces/mamba/releases/download/v2.2.2/mamba_ssm-2.2.2+cu118torch2.0cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

# Install the remaining Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# (Optional) Clone your repositories here if needed
# RUN git clone https://github.com/username/repository.git /home/ai/app/repository

# Set the default command to bash
CMD ["/bin/bash"]
