$(document).on('turbolinks:load', function(){
  $like_btn = $('.post-main__header__good-btn');
  $good_num = $('.post-main__header__evaluation__good');

  function buildPushedBotton(data){
    var pushed_btn_html = "<div class='post-main__header__good-btn--pushed' like_id=" + data.like_id + " post_id=" + data.post_id+"><i class='fa fa-thumbs-o-up'></i><span>いいね済みです</span></div>"
    return pushed_btn_html;
  }

  function buildPushBotton(data){
    var html = "<div class='post-main__header__good-btn--push' like_id=" + data.like_id + " post_id=" + data.post_id + "><i class='fa fa-thumbs-o-up'></i><span>いいね</span></div>"
    return html;
  }

  function buildGoodNumber(data){
    var good_num_html = "<i class='fa fa-thumbs-o-up'></i><span>" + data.likes_count + "</span><p>いいね</p>";
    return good_num_html;
  }

  $('.post-main__header__good-btn--push').on('click',function(e){
    e.preventDefault();
    var post_id = Number($(this).parent().attr('post_id'));
    var post_id = Number($(this).parent().attr('post_id'));
    var url = '/posts/' + post_id + '/likes';

    $.ajax({
      type: 'POST',
      url: url,
      dataType:'json'
    })
    .done(function(data){
      var pushed_btn_html = buildPushedBotton(data);
      $like_btn.empty();
      $like_btn.append(pushed_btn_html);
      var good_num_html = buildGoodNumber(data);
      $good_num.empty();
      $good_num.append(good_num_html);
    })
    .fail(function(){
      console.log('fail');
    });
  });

  $(document).on('click', ".post-main__header__good-btn--pushed",function(e){
    e.preventDefault();
    var post_id = Number($(this).parent().attr('post_id'));
    var like_id = Number($(this).attr('like_id'));
    var url = '/posts/' + post_id + '/likes/' + like_id;
    $.ajax({
      type: 'DELETE',
      url: url,
      dataType:'json'
    })
    .done(function(data){
      var push_btn_html = buildPushBotton(data);
      $like_btn.empty();
      $like_btn.append(push_btn_html);
      var good_num_html = buildGoodNumber(data);
      $good_num.empty();
      $good_num.append(good_num_html);
    })
    .fail(function(){
      console.log('fail');
    });
  });
});
