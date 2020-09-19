'use strict'

import 'jquery'

function activate_a_tab(tab_id) {
  if (tab_id) $("[href=\"#" + tab_id + "\"]").tab('show')
}

function bs4_tabs_at_page() {
  return document.querySelectorAll('a[data-toggle="tab"]').length > 0
}

// Returns "lectures" or ""
function tab_id_from_current_URL() {
  return new URL(window.location.href).hash.replace("#", "")
}

function update_href(hash) {
  var url = new URL(window.location.href)
  url.hash = hash
  window.location.href = url.href
}

document.addEventListener('DOMContentLoaded', function() {
  if (bs4_tabs_at_page()) activate_a_tab(tab_id_from_current_URL())
})


$(document).on('shown.bs.tab', function (event) {
  update_href(event.target.getAttribute("href"))
})
