$(document).ready( function() {
  $('.jfu_upload_input').each(function () {
    var options = {
      dataType: 'json',
      done: function (e, data) {
        if( data.result.result == 1 ) {
          $(e.target).next().html('<li class="jfu_file">' + data.result.file_name + '</li>');
        }
      }
    };
    options = $.extend({}, options, $(this).data('options'));
    $(this).fileupload(options);
  });
});
