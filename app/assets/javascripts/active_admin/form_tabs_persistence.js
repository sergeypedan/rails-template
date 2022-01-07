function update_href(hash) {
	var url = new URL(window.location.href)
	url.hash = hash
	window.location.href = url.href
}

function extract_hash_from_URL(string) {
	if (string.startsWith('#')) return string
	if (string.startsWith('http')) return new URL(string).hash
	throw new Error('Invalid URL')
}

document.addEventListener('DOMContentLoaded', function() {
	$(document).on('click', '.ui-tabs-anchor', function(event) {
		console.log('activated', this.href)
		update_href(extract_hash_from_URL(this.href))
	})
})
