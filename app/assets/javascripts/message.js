$(function(){
  function buildHTML(message){
    var insertImage = ""
  if (message.image.url) {
    insertImage = `<img src="${message.image.url}" width="300">`
  }
    var html = `<dl class='messages__message' data-message-id="${message.id}">
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
      $('.button').val('')
      $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
    })
    .fail(function(){
        alert('error');
    })
    return false;
  });
    var interval = setInterval(function() {
      if (window.location.href.match(/\/groups\/\d+\/messages/)) {
        $.ajax({
        url: location.href,
        dataType: 'json',
        processData: false,
        contentType: false
        })
        .done(function(json) {
          var insertHTML = '';
          var id = $('.messages__message:last').data('messageId');
          json.forEach(function(message) {
            if (message.id > id ) {
              insertHTML += buildHTML(message);
            }
          });
          $('.messages').append(insertHTML)
          $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
        })
        .fail(function(json) {
          alert('自動更新に失敗しました');
        });
     } else {
    clearInterval(interval);
   }} , 5 * 1000 );
});
