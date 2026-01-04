#!/bin/bash
set -euo pipefail

# ===============================
# rust-g precompile for TGS
# ===============================
# This script is called by TGS with:
#   PreCompile.sh <GAME_DIR>
#
# We must:
# 1) Build rust-g with low memory usage
# 2) Produce librust_g.so
# 3) Copy it into the GAME_DIR root so BYOND can load it
# ===============================

# rust-g version to pin
: "${RUST_G_VERSION:=3.9.0}"

# TGS passes the game directory as $1
GAME_DIR="$1"
RUSTG_DIR="$GAME_DIR/rust-g"

echo "GAME_DIR = $GAME_DIR"
echo "RUSTG_DIR = $RUSTG_DIR"

# Ensure rust-g repo exists
if [ ! -d "$RUSTG_DIR/.git" ]; then
    echo "Cloning rust-g..."
    rm -rf "$RUSTG_DIR"
    git clone https://github.com/tgstation/rust-g "$RUSTG_DIR"
else
    echo "Updating rust-g..."
    git -C "$RUSTG_DIR" fetch --all --prune
fi

cd "$RUSTG_DIR"

# Ensure 32-bit target exists
"$HOME/.cargo/bin/rustup" target add i686-unknown-linux-gnu

echo "Checking out rust-g version $RUST_G_VERSION"
git checkout -f "$RUST_G_VERSION"

# ===============================
# Memory-safe build settings
# ===============================
export CARGO_BUILD_JOBS=1
export RUSTFLAGS="-C codegen-units=16 -C lto=off"

echo "Building rust-g (low memory mode)..."

env PKG_CONFIG_ALLOW_CROSS=1 \
    CARGO_TARGET_DIR="$RUSTG_DIR/target" \
    "$HOME/.cargo/bin/cargo" build \
        --ignore-rust-version \
        --release \
        --target=i686-unknown-linux-gnu

OUT="$RUSTG_DIR/target/i686-unknown-linux-gnu/release/librust_g.so"

if [ ! -f "$OUT" ]; then
    echo "ERROR: librust_g.so was not produced"
    exit 1
fi

echo "rust-g built successfully"

# ===============================
# Install into game root
# ===============================
echo "Installing librust_g.so into $GAME_DIR"

cp -f "$OUT" "$GAME_DIR/librust_g.so"

ls -lah "$GAME_DIR/librust_g.so"
file "$GAME_DIR/librust_g.so"

echo "rust-g install complete"
