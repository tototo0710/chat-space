$(function(){
  function buildHTML(message){
    var insertImage = '';
  if (message.image.url) {
    insertImage = `<img src="${message.image.url}">`
  }
    var html = `<dl class='messages__message'>
                  <dt class='member'>
                    <span class='name'>${message.name}</span>
                    <time class='time'>${message.created_at}</time>
                  </dt>
                    <dd class='content'>${message.body}</dd>
                    <dd class='image'>${insertImage}</dd>
                </dl>`
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      html = buildHTML(data);
      $('.messages').append(html)
      $('.input').val('')
    })
    .fail(function(){
        alert('error');
    })
  });
});
