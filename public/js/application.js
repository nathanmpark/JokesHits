$(document).ready(function() {
  $('.contact').on('click', function(event){
    event.preventDefault();
    var contact_id = $(this).attr('id');
    $.ajax ({
      url: "/messages",
      method: "GET",
      data: {contact_id: contact_id},
      success: function(response) {
        console.log((!$('.contact').find('.message').length == 0));
        if (!$('.contact').find('.message').length == 0) {
            $('.message').toggle()
              } else {
           $('#' + contact_id).append(response)
        }
      },
    })
  })
});
