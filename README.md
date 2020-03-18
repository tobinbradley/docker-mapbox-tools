# Dockerized Mapbox Tools

Compiling Mapbox C tools can be painful. Let's fix that.

## Build the Docker image

```bash
docker build -t tobin/mapboxtools:latest .
```

## Interactive shell

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools
```

## tippecanoe

See [mapbox/tippecanoe](https://github.com/mapbox/tippecanoe) for documentation.

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools \
tippecanoe -zg -o greenways.mbtiles --drop-densest-as-needed greenways.geojson
```

## fontnik

`font.sh <input folder> <output folder>`

The helper script scans the input folder for `*.ttf` fonts and places the font glyphs in the output folder.

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools \
font.sh fonts glyphs
```

## spritezero

`sprite.sh <input folder> <output folder>`

The helper script scans `*.svg` in the input folder and places 1x and 2x sprites in the output folder.

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools \
sprite.sh svg sprites
```

### Notes

* The volume you mount should have write permissions set so Docker can put stuff there. I'd like to tell you I didn't `chmod -R 777 *` mine. But I did.
* The NodeJS version being used by the Docker image is 10, as that seems to be the latest Node release their are prebuilt `spritezero` and `fontnik` binaries for.