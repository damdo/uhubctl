
## uhubctl for gokrazy

This package is a [frozen](https://github.com/gokrazy/freeze) version of
`uhubctl`, coming from Ubuntu devel, packaged for [gokrazy](https://gokrazy.org/) instances.

## Architecture support

Currently:
- `GOARCH=arm64` only (multiarch tuple `aarch64-linux-gnu`)
- `GOARCH=amd64` only (multiarch tuple `amd64-linux-gnu`)

Please use the tuples from https://wiki.debian.org/Multiarch/Tuples when adding
support for more architectures.
