document.addEventListener("DOMContentLoaded", function() {

  // SmoothScroll
  // options: https://github.com/cferdinandi/smooth-scroll#global-settings

  // import SmoothScroll from 'smooth-scroll'

  new SmoothScroll('[data-scroll]', {
    speed:     500,
    easing:   'easeOutQuint',
    updateURL: false
  });

  // window.SmoothScroll = SmoothScroll

});

