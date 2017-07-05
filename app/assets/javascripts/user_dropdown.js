$(document).on('turbolinks:load', function(){
  $(document).ready(function() {
    $('.user_dropdown').hide();
  });

  $('.right-content__profile').on('click', function(e) {
    e.preventDefault();

    if($('.user_dropdown').attr('style') == "display: none;"){
      $('.user_dropdown').show();
    } else {
      $('.user_dropdown').hide();
    }
  });

  $('body.index').click(function(e) {
    if (!($.contains($('.user_dropdown')[0], e.target) || $.contains($('.right-content__profile')[0], e.target) )   ) {
      $('.user_dropdown').hide();
    }
  });
});
