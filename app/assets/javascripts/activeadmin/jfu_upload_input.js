$(document).ready( function() {
  $('.jfu_upload_input').each(function () {
    var options = {
      dataType: 'json',
      add: function(e, data) {
        data.context = $(e.target).next().html('<li class="jfu_info jfu_loading"> Uploading... </li>');
        data.submit();
        data.context.focus();
      },
      done: function(e, data) {
        if( data.result.result == 1 ) {
          $(e.target).next().html('<li class="jfu_info jfu_done"> Upload complete! </li>');  // data.result.file_name
        }
      },
      progressall: function(e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $(e.target).next().html('<li class="jfu_info jfu_progress" style="width:' + progress + '%"> ' + progress + '% ... </li>');
      }
    };
    options = $.extend({}, options, $(this).data('options'));
    $(this).fileupload(options);
  });
});
