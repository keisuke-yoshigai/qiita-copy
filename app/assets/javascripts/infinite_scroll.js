$(document).on('turbolinks:load', function(){
  if ($('.next')[0]) {
    $(".main__body__posts").infiniteScroll({
        loading: {
          img: "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
          msgText: "loading..."
        },
        hideNav: '.pagination',
        path: '.next > a',
        append: '.main__body__posts__post, #post-hr',
        history: false,
        status: '.page-load-status'
    });
  }
});
