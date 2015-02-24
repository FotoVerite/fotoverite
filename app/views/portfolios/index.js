$('.photo-container').append('<%= j render @portfolios %>');
<% if @portfolios.next_page %>
  $('.pagination').replaceWith('<%= j will_paginate @portfolios %>');
<% else %>
  $(window).off('scroll');
  $('.pagination').remove();
<% end %>
 $('.photo-container').justifiedGallery('norewind');

