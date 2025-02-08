# AlterWare: IW4x Dedicated Server Docker Image
The official Docker image for IW4x

## Running the Server
To start the IW4x dedicated server using Docker, run the following command:

```sh
docker run -d --name iw4x-server \
    -p 28960:28960/udp \
    -v ~/iw4x:/base_files:ro \
    -e IW4X_NET_PORT=<net_port: default 28960> \
    alterware/iw4x-docker:latest <options: example +set sv_hostname "My Server">
```

### Explanation of Parameters:
- `-d` – Runs the container in detached mode (in the background).
- `--name iw4x-server` – Names the container `iw4x-server`.
- `-p 28960:28960/udp` – Exposes UDP port 28960 for external connections.
- `-v ~/iw4x:/base_files:ro` – Mounts the game files directory (`~/iw4x`) inside the container as read-only.
- `-e IW4X_NET_PORT=<net_port>` – (Optional) Changes the network port (default: `28960`).
- `<options>` – Additional IW4x server settings, e.g., `+set sv_hostname "My Server"`, `+set rcon_password "mypassword"`.

## Customizing the Server
To further customize your server, you **must manually set the RCON password** to enable remote administration. Without it, you won’t be able to modify settings dynamically. You can do this by adding:

```sh
+set rcon_password "your_secure_password"
```

Example:
```sh
docker run -d --name iw4x-server \
    -p 28960:28960/udp \
    -v ~/iw4x:/base_files:ro \
    -e IW4X_NET_PORT=28960 \
    alterware/iw4x-docker:latest \
    +set sv_hostname "My Server" +set rcon_password "mypassword"
```

## Proof of Concept
This repository serves as a **working proof of concept** for running IW4x in Docker. If the provided features **do not meet your requirements**, we encourage you to:

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/iw4x-docker.git
   cd iw4x-docker
   ```
2. Modify the Dockerfile, entrypoint script, or any other configuration to fit your needs.
3. Build your own Docker image:
   ```sh
   docker build -t custom-iw4x-docker .
   ```
4. Run your custom image:
   ```sh
   docker run -d --name custom-iw4x-server -p 28960:28960/udp custom-iw4x-docker
   ```

To reduce the image size, remove the code in [ci.sh](tools/ci/ci.sh) that downloads the rawfiles or server configuration files.  
By doing so, users must mount their own directory containing these necessary files, ensuring flexibility and allowing for a customized setup.
This approach keeps the image lightweight while giving you full control over the server configuration. If you require additional modifications, consider cloning the repository and building your own custom image.  
