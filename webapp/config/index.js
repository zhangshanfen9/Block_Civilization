'use strict'
// Template version: 1.3.1
// see http://vuejs-templates.github.io/webpack for documentation.

const path = require('path')

module.exports = {
  dev: {

    // Paths
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',
    proxyTable: {},

    // Various Dev Server settings
    host: 'localhost', // can be overwritten by process.env.HOST
    port: 8080, // can be overwritten by process.env.PORT, if port is in use, a free one will be determined
    autoOpenBrowser: false,
    errorOverlay: true,
    notifyOnErrors: true,
    poll: false, // https://webpack.js.org/configuration/dev-server/#devserver-watchoptions-


    /**
     * Source Maps
     */

    // https://webpack.js.org/configuration/devtool/#development
    devtool: 'cheap-module-eval-source-map',

    // If you have problems debugging vue-files in devtools,
    // set this to false - it *may* help
    // https://vue-loader.vuejs.org/en/options.html#cachebusting
    cacheBusting: true,

    cssSourceMap: true
  },

  build: {
    // Template for index.html
    index: path.resolve(__dirname, '../dist/index.html'),

    // Paths
    assetsRoot: path.resolve(__dirname, '../dist'),
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',

    /**
     * Source Maps
     */

    productionSourceMap: true,
    // https://webpack.js.org/configuration/devtool/#production
    devtool: '#source-map',

    // Gzip off by default as many popular static hosts such as
    // Surge or Netlify already gzip all static assets for you.
    // Before setting to `true`, make sure to:
    // npm install --save-dev compression-webpack-plugin
    productionGzip: false,
    productionGzipExtensions: ['js', 'css'],

    // Run the build command with an extra argument to
    // View the bundle analyzer report after build finishes:
    // `npm run build --report`
    // Set to `true` or `false` to always turn it on or off
    bundleAnalyzerReport: process.env.npm_config_report
  },
  nodeInfo:
    [
      "enode://28f68561d09ba659a983d6524ca56b5946bc7ba578f2f79aaaae7cee137721f34d080a3e270ef3993e02328a7eb226d730ffee2206bc15d97519d84bc656c8c5@127.0.0.1:30303?discport=0",
      "enode://2b0d98fe1cc911840f70a2b0b4e6635bb94fa8e365d41208fe0c3a9bc3eac4f1971d4993e19af88389d95f81487f5486d3305ccac0743342f391466e3e6cbdd1@127.0.0.1:30304?discport=0"
    ],
  contractInterface: [{"constant":false,"inputs":[{"name":"_cityId","type":"uint256"},{"name":"_newName","type":"string"}],"name":"changeName","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_name","type":"string"}],"name":"createRandomCity","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"Id","type":"uint256"},{"name":"newName","type":"string"}],"name":"expansion","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"my_id","type":"uint256"},{"name":"target_Id","type":"uint256"}],"name":"Invade","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"to_id","type":"uint256"},{"name":"from_id","type":"uint256"}],"name":"mergeCity","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_cityId","type":"uint256"}],"name":"quickLevelUp","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[],"name":"reap","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_fee","type":"uint256"}],"name":"setPopuUpFee","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"civiId","type":"uint256"},{"indexed":false,"name":"name","type":"string"},{"indexed":false,"name":"economy","type":"uint256"},{"indexed":false,"name":"politics","type":"uint256"},{"indexed":false,"name":"military","type":"uint256"},{"indexed":false,"name":"message","type":"string"}],"name":"NewCity","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"civiId","type":"uint256"},{"indexed":false,"name":"name","type":"string"},{"indexed":false,"name":"economy","type":"uint256"},{"indexed":false,"name":"politics","type":"uint256"},{"indexed":false,"name":"military","type":"uint256"},{"indexed":false,"name":"message","type":"string"}],"name":"CityStatus","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"msg","type":"string"}],"name":"Success","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"msg","type":"string"}],"name":"Fail","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"msg","type":"string"}],"name":"StatusChange","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"index","type":"uint256"},{"indexed":false,"name":"msg","type":"string"}],"name":"NewCity","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"index","type":"uint256"},{"indexed":false,"name":"msg","type":"string"}],"name":"GrowCity","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"index","type":"uint256"},{"indexed":false,"name":"msg","type":"string"}],"name":"WeakenCity","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"},{"indexed":true,"name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"getcitiesByOwner","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getCitiesNum","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"Id","type":"uint256"}],"name":"getCityDetails","outputs":[{"name":"","type":"address"},{"name":"","type":"string"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"test","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"pure","type":"function"}],
	contractAddress: '0x2072e1d0f16e72c0d0c417c58bd23addbd0e619f'
}
