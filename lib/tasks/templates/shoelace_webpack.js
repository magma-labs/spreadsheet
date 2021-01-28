const path = require('path')
const CopyPlugin = require('copy-webpack-plugin')

environment.plugins.append(
  'CopyPlugin',
  new CopyPlugin({
    patterns: [
      {
        from: path.resolve(
          __dirname,
          '../../node_modules/@shoelace-style/shoelace/dist/shoelace/icons'
        ),
        to: path.resolve(__dirname, '../../public/packs-test/js/icons')
      }
    ]
  })
)
