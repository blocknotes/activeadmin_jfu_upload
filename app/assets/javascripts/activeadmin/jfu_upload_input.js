$(document).ready( function() {
  $('.jfu_upload_input').each(function () {
    var options = {
      dataType: 'json',
      add: function (e, data) {
        // data.context = $('<p/>').text('Uploading...').appendTo(document.body);
        // data.submit();
        $(e.target).next().html('<li class="jfu_loading">Uploading...</li>');
        data.submit();
      },
      done: function (e, data) {
        if( data.result.result == 1 ) {
          $(e.target).next().html('<li class="jfu_file">' + data.result.file_name + '</li>');
        }
      },
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        console.log(progress);
        // $('#progress .bar').css(
        //   'width',
        //   progress + '%'
        // );
      }
    };
    options = $.extend({}, options, $(this).data('options'));
    $(this).fileupload(options);
  });
});
