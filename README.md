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

* Note the output folder needs to exist. I need to write a shell script to automate some of that nonsense. But I haven't.

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

### Notes

* The volume you mount to `/data` needs to contain the input file/folder and output file/folder.
* That volume should also have write permissions so Docker can put stuff there. I'd like to tell you I didn't `chmod -R 777 *` mine. But I can't.