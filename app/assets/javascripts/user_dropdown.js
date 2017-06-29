$(document).on('turbolinks:load page:change', function() {
  function buildHTML(data){
    var list_front = "<ul class='user_dropdown'>";
    var my_page = "<li><a href='/users/" + data.user_id +  "' class='user_dropdown__my-page'><i class='fa fa-fw fa-user'></i>マイページ</a></li>";
    var setting = "<li><a href='/' class='user_dropdown__setting' data-method='get'><i class='fa fa-fw fa-cog'></i>設定</a></li>";
    var help = "<li><a href='/' class='user_dropdown__help' data-method='get'><i class='fa fa-fw fa-question'></i>ヘルプ</a></li>";
    var logout = "<li><a data-method='delete' href='/users/sign_out' class='user_dropdown__logout'><i class='fa fa-fw fa-sign-out'></i>ログアウト</a></li>";
    var list_back = "</ul>";

    html = list_front + my_page + setting + help + logout + list_back
    return html;
  }

  $('.right-content__profile').on('click', function(e) {
    e.preventDefault();
    $.ajax( {
      type: "GET",
      url: "/",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      if($('.right-content__profile ul').length == 0){
        $('.right-content__profile').append(html);
      }
      else{
        $('.right-content__profile ul').remove();
      }
      preHtml = html;
    })
    .fail(function() {
      console.log('fail');
    });
  });
  $(document).click(function(e) {
    if (!$.contains($('.right-content__profile')[0], e.target)) {
      $('.right-content__profile ul').remove();
    }
  });
});
