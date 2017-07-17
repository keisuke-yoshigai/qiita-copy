$(document).on('turbolinks:load', function(){
  var $cheetSheetMarkdown = $('.main-new__body__right__cheetsheet__markdown');
  var $cheetSheetMarkdownImage = $('.main-new__body__right__cheetsheet__image');
  var $cheetSheetTitle = $('.main-new__body__right__cheetsheet__title');
  var $cheetSheetExample = $('.main-new__body__right__cheetsheet__example');


  $('.main-new__body__left__text__input').on('keyup', function(e){
    e.preventDefault();
    var input = $(this).val();

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
        $cheetSheetMarkdownImage.empty();
      }
    })
    .fail(function(){
      console.log('fail');
    });
  });

  $('#file_field').on('change', function(){
    var selectedFile = this.files[0]; //filesでinputタグで選択されたユーザーのローカルのファイル情報を取得。
    var fileReader = new FileReader();  //FileReaderオブジェクトを生成し、fileReaderに格納。
    fileReader.onload = function(event){  // fileReaderに読み込みが成功した後の動作を定義
      var loadedImageUrl = event.target.result; // eventオブジェクトの実際にイベントが発生したDOM要素をtargetプロパティで取得。ここではFileReaderオブジェクトが取れている。その後、resultに格納されている文字列情報をloadedImageUrlに格納している。
      var imgTag = "<img class='addImage' src=" + loadedImageUrl + ">"  // loadedImageUrlをsrcとするimgタグをappendするために文字列として生成しimgTagに格納。
      $cheetSheetTitle.hide();
      $cheetSheetExample.hide();
      $cheetSheetMarkdownImage.append(imgTag);
    }
    fileReader.readAsDataURL(selectedFile); //selectedFileのファイルを読み込み、そのファイルデータを表す文字列がresultに格納される。
  });
});

