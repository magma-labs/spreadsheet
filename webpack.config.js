const path = require('path')
const webpack = require('webpack')
const CopyPlugin = require('copy-webpack-plugin')

const iconsPath = process.env.ASSETS_PATH || path.resolve(__dirname, 'dist/icons')

module.exports = {
  entry: './app/javascript/spreadsheet/index.js',
  output: {
    filename: 'spreadsheet.js',
    path: path.resolve(__dirname, 'dist')
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
            plugins: [
              '@babel/plugin-transform-runtime',
              'babel-plugin-macros',
              '@babel/plugin-syntax-dynamic-import',
              '@babel/plugin-transform-destructuring',
              [
                '@babel/plugin-proposal-class-properties',
                {
                  loose: true
                }
              ],
              [
                '@babel/plugin-proposal-object-rest-spread',
                {
                  useBuiltIns: true
                }
              ],
              [
                '@babel/plugin-transform-regenerator',
                {
                  async: false
                }
              ]
            ]
          }
        }
      },
      {
        test: /\.s[ac]ss$|\.css$/i,
        use: [
          'style-loader',
          'css-loader',
          {
            loader: 'postcss-loader',
            options: {
              postcssOptions: {
                plugins: [
                  require('tailwindcss')('./tailwind.config.js'),
                  require('postcss-import'),
                  require('postcss-flexbugs-fixes'),
                  require('postcss-preset-env')({
                    autoprefixer: {
                      flexbox: 'no-2009'
                    },
                    stage: 3
                  }),
                  require('@fullhuman/postcss-purgecss')({
                    content: [
                      './app/**/.html.erb',
                      './app/helpers/**/*.rb',
                      './app/javascript/**/*.js',
                      './app/javascript/**/*.vue',
                      './app/javascript/**/*.jsx',
                    ],
                    defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || []
                  })
                ],
              },
            },
          },
          {
            loader: 'sass-loader',
            options: { sourceMap: true }
          },
        ],
      },
    ],
  },
  plugins: [
    new CopyPlugin({
      patterns: [
        {
          from: path.resolve(
            __dirname,
            'node_modules/@shoelace-style/shoelace/dist/shoelace/icons'
          ),
          to: iconsPath
        }
      ]
    }),
    new webpack.DefinePlugin({
      'process.env.ASSETS_PATH': JSON.stringify(iconsPath)
    })
  ]
}
