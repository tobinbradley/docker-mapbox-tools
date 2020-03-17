const spritezero = require('@mapbox/spritezero')
const fs = require('fs')
const glob = require('glob')
const path = require('path')

const spriteArgs = process.argv.slice(2)

// could be [1, 2, 4]
;[1, 2].forEach(function(pxRatio) {
  var svgs = glob
    .sync(path.resolve(path.join(spriteArgs[0], '*.svg')))
    .map(function(f) {
      return {
        svg: fs.readFileSync(f),
        id: path.basename(f).replace('.svg', '')
      }
    })
  var pngPath = path.resolve(
    path.join(spriteArgs[1], 'sprite@' + pxRatio + '.png')
  )
  var jsonPath = path.resolve(
    path.join(spriteArgs[1], 'sprite@' + pxRatio + '.json')
  )

  // Pass `true` in the layout parameter to generate a data layout
  // suitable for exporting to a JSON sprite manifest file.
  spritezero.generateLayout(
    { imgs: svgs, pixelRatio: pxRatio, format: true },
    function(err, dataLayout) {
      if (err) return
      fs.writeFileSync(jsonPath, JSON.stringify(dataLayout))
    }
  )

  // Pass `false` in the layout parameter to generate an image layout
  // suitable for exporting to a PNG sprite image file.
  spritezero.generateLayout(
    { imgs: svgs, pixelRatio: pxRatio, format: false },
    function(err, imageLayout) {
      spritezero.generateImage(imageLayout, function(err, image) {
        if (err) return
        fs.writeFileSync(pngPath, image)
      })
    }
  )
})
