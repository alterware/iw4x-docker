#!/bin/sh
set -e

TMP_DIR="/tmp/iw4x_config"
SERVER_DIR="$(pwd)/server" # Set to GitHub workspace

echo "Creating temporary directory..."
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "Downloading server configs..."
curl -Lo main.zip https://github.com/alterware/IW4ServerConfigsLinux/archive/main.zip || {
  echo "Failed to download server configs"
  exit 1
}

echo "Unzipping server configs..."
unzip -q main.zip || {
  echo "Failed to unzip server configs"
  exit 1
}

echo "Moving files to server directory..."
mkdir -p "$SERVER_DIR"

mv IW4ServerConfigsLinux-main/* "$SERVER_DIR/" || {
  echo "Failed to move files to server directory"
  exit 1
}

echo "Cleaning up temporary files..."
rmdir IW4ServerConfigsLinux-main
rm main.zip

echo "Removing unnecessary files..."
rm -f "$SERVER_DIR/LICENSE" "$SERVER_DIR/README.md" \
      "$SERVER_DIR/DedicatedServerLAN.sh" "$SERVER_DIR/DedicatedServer.sh" \
      "$SERVER_DIR/DedicatedLobbyServerLAN.sh" "$SERVER_DIR/DedicatedLobbyServer.sh"

echo "Server configs installed successfully in $SERVER_DIR"

echo "Downloading rawfiles..."
curl -Lo release.zip https://github.com/iw4x/iw4x-rawfiles/releases/latest/download/release.zip || {
  echo "Failed to download rawfiles"
  exit 1
}

echo "Unzipping rawfiles to server directory..."
unzip -qo release.zip -d "$SERVER_DIR" || {
  echo "Failed to unzip rawfiles"
  exit 1
}

echo "Cleaning up rawfiles zip..."
rm release.zip

echo "IW4x rawfiles downloaded successfully in $SERVER_DIR"

echo "Downloading iw4x.dll..."
curl -Lo iw4x.dll https://github.com/iw4x/iw4x-client/releases/latest/download/iw4x.dll || {
  echo "Failed to download iw4x.dll"
  exit 1
}

mv iw4x.dll "$SERVER_DIR/" || {
  echo "Failed to move iw4x.dll to server directory"
  exit 1
}

echo "iw4x.dll installed successfully in $SERVER_DIR"

# Navigate to the server directory and list all files
cd "$SERVER_DIR"
echo "Listing all files in $SERVER_DIR:"
ls -lah
