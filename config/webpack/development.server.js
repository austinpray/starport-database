// Note: You must restart bin/webpack-dev-server for changes to take effect

const { resolve } = require('path')
const merge = require('webpack-merge')
const devConfig = require('./development.js')
const { devServer, publicPath, paths } = require('./configuration.js')

module.exports = merge(devConfig, {
  devServer: {
    host: '0.0.0.0',
    port: 8080,
    compress: true,
    inline: false,
    historyApiFallback: true,
    contentBase: resolve(paths.output, paths.entry),
    publicPath
  }
})
