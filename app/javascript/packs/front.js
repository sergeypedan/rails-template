"use strict"

import "jquery"


// Bootstrap

// import "bootstrap/dist/js/bootstrap.js"

// import "bootstrap/js/dist/util.js"
import "bootstrap/js/dist/alert.js"
// import "bootstrap/js/dist/button.js"
import "bootstrap/js/dist/collapse.js"

import "stylesheets/site-bootstrap.sass"
import "stylesheets/site-style.sass"
import "stylesheets/site-vendor.sass"

$("[data-toggle='collapse']").click(function() {}) // for some strange reason this is necessary for collspses to work @ mobile


// Rails UJS
import Rails from "rails-ujs"
Rails.start()



// Slick carousel
import "slick-carousel-no-font-no-png"

document.addEventListener("DOMContentLoaded", () => {
	$("[data-behavior="slick-carousel"]").slick()
})


// YouTube labnol
import "vendor/youtube-labnol-extended-1.2/script.js"
import "vendor/youtube-labnol-extended-1.2/style.sass"


// SmoothScroll
import SmoothScroll from "smooth-scroll"

// options: https://github.com/cferdinandi/smooth-scroll#global-settings
var scroll = new SmoothScroll("[data-scroll]", { speed: 500, easing: "easeOutQuint", updateURL: false })
window.SmoothScroll = SmoothScroll


// Prism
import "prismjs/prism"
import "prismjs/components/prism-bash"
import "prismjs/components/prism-css"
import "prismjs/components/prism-sass"
import "prismjs/components/prism-javascript"
import "prismjs/components/prism-json"
import "prismjs/components/prism-markup"
import "prismjs/components/prism-ruby"
import "prismjs/components/prism-yaml"

// import "prismjs/themes/prism-solarizedlight"
import "prismjs/themes/prism-tomorrow"


import "modules/admin/ajax-form-helper.coffee"


// Stimulus
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

