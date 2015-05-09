$(document).ready(function() {
  // or with jQuery
  $('.photo-container').justifiedGallery({
    rowHeight: 470,
    lastRow: 'justify',
    margins: 15,
    captions: $('.portfolio-image').length > 0
  });

});
