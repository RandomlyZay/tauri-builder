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
    xdg-dbus-proxy \
    && rm -rf /var/lib/apt/lists/*

# 2. Add Flathub repository (System-wide)
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# 3. Install Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# 4. Install pnpm (Global)
RUN npm install -g pnpm

# 5. Install sccache (Rust Caching)
RUN curl -L https://github.com/mozilla/sccache/releases/download/v0.13.0/sccache-v0.13.0-x86_64-unknown-linux-musl.tar.gz | tar xz && \
    mv sccache-v0.13.0-x86_64-unknown-linux-musl/sccache /usr/local/bin/sccache && \
    chmod +x /usr/local/bin/sccache && \
    rm -rf sccache-v0.13.0-x86_64-unknown-linux-musl