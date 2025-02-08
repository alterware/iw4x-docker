FROM alpine:3

# Install wine
RUN echo "x86" > /etc/apk/arch
RUN apk add --no-cache wine freetype xvfb gnutls

# Wine environment variables
ENV WINEARCH=win32
ENV WINEDEBUG=fixme-all

# Create and use iw4x user
RUN adduser -u 1000 -D iw4x
USER iw4x

# Configure Wine
RUN winecfg

# Set working directory
WORKDIR /iw4x

# Copy files from the CI workspace
COPY --chown=iw4x:iw4x server /iw4x

# Copy entrypoint script
COPY tools/docker/entrypoint.sh entrypoint.sh

EXPOSE 28960/udp

ENTRYPOINT ["./entrypoint.sh"]
