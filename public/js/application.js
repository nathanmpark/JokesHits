$(document).ready(function() {

  clickChecker();

});

var clickChecker = function(){
  $('.contact').on('click', function(event){
    event.preventDefault();

    var contact_id = $(this).attr('id');

    var request = $.ajax ({
      url: "/messages",
      method: "GET",
      dataType: "html",
      data: {contact_id: contact_id}
    });

    request.done(function(response){
      // debugger
      if (!$('#' + contact_id ).find('.message').length == 0){
        $('#' + contact_id + ' .message').toggle()
      }
      else {
        $('#' + contact_id).append(response)
      }
    });

  });
};
