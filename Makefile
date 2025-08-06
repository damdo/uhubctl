
all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_arm64.tar: Dockerfile.arm64
	podman build --platform linux/arm64 --rm -t uhubctl-arm64 --file Dockerfile.amd64 .
	podman run --platform linux/arm64 --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/ uhubctl-arm64 sh -c 'mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/uhubctl.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/aarch64-linux-gnu/uhubctl.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_arm64.tar *'

_gokrazy/extrafiles_amd64.tar: Dockerfile.amd64
	podman build --platform linux/amd64 --rm -t uhubctl-amd64 --file Dockerfile.amd64 .
	podman run --platform linux/amd64 --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/ uhubctl-amd64 sh -c 'mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/uhubctl.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/x86_64-linux-gnu/uhubctl.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_amd64.tar *'

clean:
	rm -f _gokrazy/extrafiles_*.tar
