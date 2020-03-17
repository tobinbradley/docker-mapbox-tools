# Dockerized Mapbox Tools

Compiling Mapbox C tools and be a pain in the butt. Let's fix that.

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

* I need something here to make output folders and loop through fonts etc.

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools \
build-glyphs OpenSans-Bold.ttf "glyphs/Open Sans Bold"
```

## spritezero

Inputs are fold with SVG files and an output folder

```bash
docker run -it -u `id -u $USER` --volume $(pwd):/data tobin/mapboxtools \
sprite.sh svg sprites
```
