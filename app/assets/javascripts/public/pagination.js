jQuery(function() {
  $('.pagination').hide();
  if($('#infinite-scrolling').size() > 0) {
     $(window).on('scroll', function(){
        var nextUrl = $('.pagination .next_page').attr('href');
        if(nextUrl && $(window).scrollTop() > $(document).height() - $(window).height() - 660) {
          var $spinner = $('<div class="spinner"><span></span><span></span><span></span></div>');
          var spinner = {
            active : false,
            phase : 0,
            timeslot : 150,
            $el : $spinner,
            $points : $spinner.find('span'),
            intervalId : null
          };
          $('.pagination').html($spinner);
          startLoadingSpinnerAnimation(spinner);
          $.getScript(nextUrl);
          $('.pagination').hide();
          return null;
        }
        return null;
     });
  }
  return null;
});

function startLoadingSpinnerAnimation(spinnerContext) {
      clearInterval(spinnerContext.intervalId);
      spinnerContext.intervalId = setInterval(function () {
        if (spinnerContext.phase < spinnerContext.$points.length)
          spinnerContext.$points.eq(spinnerContext.phase).fadeTo(spinnerContext.timeslot, 1);
        else
          spinnerContext.$points.eq(spinnerContext.phase - spinnerContext.$points.length)
                        .fadeTo(spinnerContext.timeslot, 0);
        spinnerContext.phase = (spinnerContext.phase + 1) % (spinnerContext.$points.length * 2);
      }, spinnerContext.timeslot);
    }