$('.photo-container').append('<%= j render(:partial => "photo", :collection => @photos) %>');
<% if @photos.next_page %>
  $('.pagination').replaceWith('<%= j will_paginate @photos %>');
<% else %>
  $(window).off('scroll');
  $('.pagination').remove();
<% end %>
  $('.photo-container').justifiedGallery('norewind');
  $lightBox.deleteTargets()

 var activityIndicatorOn = function()
    {
      $( '<div id="imagelightbox-loading"><div></div></div>' ).appendTo( 'body' );
    },
    activityIndicatorOff = function()
    {
      $( '#imagelightbox-loading' ).remove();
    },


    // OVERLAY

    overlayOn = function()
    {
      $( '<div id="imagelightbox-overlay"></div>' ).appendTo( 'body' );
    },
    overlayOff = function()
    {
      $( '#imagelightbox-overlay' ).remove();
    }

  $lightBox = $('.photo-container a').imageLightbox(
    {
      onStart:   function() { overlayOn(); },
      onEnd:     function() { overlayOff(); activityIndicatorOff(); },
      onLoadStart: function() { activityIndicatorOn(); },
      onLoadEnd:   function() { activityIndicatorOff(); }
    });
