/* eslint no-console:0 */
"use strict"

import "jquery"
window.$ = jQuery

import "bootstrap"

import "stylesheets/admin-style.sass"

import "modules/bs4-tabs-listener.coffee"

// Rails UJS
import Rails from "rails-ujs"
Rails.start()

import "modules/admin/ajax-form-helper.coffee"
import "modules/admin/sortable.js"

// YouTube labnol
import "vendor/youtube-labnol-extended-1.2/script.js"
import "vendor/youtube-labnol-extended-1.2/style.sass"

import "selectize/dist/js/selectize.js"
import "selectize/dist/css/selectize.css"
// import "selectize/dist/css/selectize.default.css"
import "selectize/dist/css/selectize.bootstrap3.css"
$("select[multiple="multiple"]").selectize()
