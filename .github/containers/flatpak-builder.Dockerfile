# Base image matches the GitHub Actions runner version
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install Flatpak & Builder Dependencies
RUN apt-get update && apt-get install -y \
    flatpak \
    flatpak-builder \
    elfutils \
    curl \
    git \
    # Required for some flatpak operations
    xdg-dbus-proxy \
    && rm -rf /var/lib/apt/lists/*

# 2. Add Flathub repository (System-wide)
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 3. Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# 4. Install pnpm (Global)
RUN npm install -g pnpm