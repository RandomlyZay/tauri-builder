# Base image matches the GitHub Actions runner version
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install Flatpak & Builder Dependencies
RUN apt-get update && apt-get install -y \
    flatpak \
    flatpak-builder \
    elfutils \
    appstream \
    curl \
    git \
    xdg-dbus-proxy \
    && rm -rf /var/lib/apt/lists/*

# 2. Add Flathub repository (System-wide)
RUN flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 3. Install Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# 4. Install pnpm (Global)
RUN npm install -g pnpm