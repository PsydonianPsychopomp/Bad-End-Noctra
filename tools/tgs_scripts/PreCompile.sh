  GNU nano 6.2           /home/tgs/instances/BadEndTheatre2/Configuration/EventScripts/PreCompile.sh *                  #!/bin/bash
# update rust-g

: "${RUST_G_VERSION:=3.9.0}"

RUSTG_DIR="$1/rust-g"

if [ ! -d "$RUSTG_DIR/.git" ]; then
        echo "Cloning rust-g..."
        rm -rf "$RUSTG_DIR"
        git clone https://github.com/tgstation/rust-g "$RUSTG_DIR"
else
        echo "Fetching rust-g..."
        git -C "$RUSTG_DIR" fetch --all --prune
fi

cd "$RUSTG_DIR"

"$HOME/.cargo/bin/rustup" target add i686-unknown-linux-gnu

echo "Deploying rust-g..."
git checkout -f "$RUST_G_VERSION"

env PKG_CONFIG_ALLOW_CROSS=1 \
    CARGO_TARGET_DIR="$RUSTG_DIR/target" \
    "$HOME/.cargo/bin/cargo" build --ignore-rust-version --release --target=i686-unknown-linux-gnu
