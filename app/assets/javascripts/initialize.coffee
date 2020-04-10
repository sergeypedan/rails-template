$(document).ready ->

	console.log "Initializing smoothScroll"
	smoothScroll.init({
		speed:     500,
		easing:    'easeOutQuint',
		updateURL: false
	})
