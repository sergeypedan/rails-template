const { environment } = require('@rails/webpacker')
const webpack = require('webpack')


// Coffee
const coffee = require('./loaders/coffee')
environment.loaders.prepend('coffee', coffee)


// TypeScript
const typescript = require('./loaders/typescript')
environment.loaders.prepend('typescript', typescript)


// Vue
const vue = require('./loaders/vue')
const { VueLoaderPlugin } = require('vue-loader')
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)


// jQuery & Bootstrap dependencies
environment.plugins.append(
	'Provide',
	new webpack.ProvidePlugin({
		$:               'jquery',
		jQuery:          'jquery',
		jquery:          'jquery',
		'window.jQuery': 'jquery',
		Popper:         ['popper.js', 'default']
	})
)
// 'window.Tether': "tether"


module.exports = environment
