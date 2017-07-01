$(function(){
  $('.main-new__body__left__text__input').on('keyup', function(e){
    e.preventDefault();
    var input = $(this).val();
    var $cheetSheetMarkdown = $('.main-new__body__right__cheetsheet__markdown');
    var $cheetSheetTitle = $('.main-new__body__right__cheetsheet__title');
    var $cheetSheetExample = $('.main-new__body__right__cheetsheet__example');

    $.ajax({
      type: 'GET',
      url: location.href,
      dataType: 'json',
      data:{ input: input }
    })
    .done(function(data){
      console.log('done');
      if(data){
        $cheetSheetTitle.hide();
        $cheetSheetExample.hide();
        $cheetSheetMarkdown.empty();
        $cheetSheetMarkdown.append(data.html);
      }
      if($cheetSheetMarkdown.children().length == 0){
        $cheetSheetMarkdown.empty();
        $cheetSheetTitle.show();
        $cheetSheetExample.show();
      }
    })
    .fail(function(){
      console.log('fail');
    });
  });
});

