# Noid Live Image Maker

[![Build noid images](https://github.com/noid-linux/noid-mklive/actions/workflows/gen-images.yml/badge.svg)](https://github.com/noid-linux/noid-mklive/actions/workflows/gen-images.yml) [![Download Noid Linux](https://img.shields.io/sourceforge/dt/noid-linux.svg)](https://sourceforge.net/projects/noid-linux/files/latest/noid-xfce.iso/download)

The Noid Linux live image maker

> [!IMPORTANT]
> **Username**: `train`  
> **Password**: `noidlinux`

## Building an ISO

```bash
git clone --recurse-submodules https://github.com/noid-linux/noid-mklive
./mknoid.sh xfce output.iso   # or: kde, gnome
```

Requires running as root inside a privileged container (or on Void
Linux directly). See the GitHub Actions workflow in
`.github/workflows/gen-image.yml` for the reference build environment.

## Acknowledgments

- Void Linux Team for their excellent distribution

## License

This project is licensed under the same terms as Void Linux's void-mklive.
