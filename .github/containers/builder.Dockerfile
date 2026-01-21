# Base image matches the GitHub Actions runner version for consistency
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install System Dependencies
# Includes common build tools, Tauri Linux deps, and curl/wget
RUN apt-get update && apt-get install -y \
    libwebkit2gtk-4.1-dev \
    build-essential \
    curl \
    wget \
    file \
    libxdo-dev \
    libssl-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    patchelf \
    rpm \
    xdg-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

# 2. Install Rust (Stable)
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --profile minimal

# 3. Install Node.js (via Volta for easy version management or just direct Node source)
# Using NodeSource for Node 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# 4. Install pnpm
RUN npm install -g pnpm

# 5. Pre-create generic cache directories to ensure permissions
RUN mkdir -p /github/home/.cargo && chmod 777 /github/home/.cargo