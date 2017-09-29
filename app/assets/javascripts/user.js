$(function() {

  var user_list = $("#user-search-result");
  var chat_member_list = $("#chat-group-users");

  function appendUser(user) {
   var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${user.name}</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    user_list.append(html);
  }

  function appendNoUser(user) {
    var html = `<div class='listview__element--right-icon'>${ user }</div>`
    user_list.append(html);
  }

  function appendChatUser(id, name) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${id}'>
                  <input name='group[user_ids][]' type='hidden' value='${id}'>
                  <p class='chat-group-user__name'>${name}</p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                </div>`
    chat_member_list.append(html);
  }

  $("#user-search-field").on("keyup", function() {
    var input = $.trim($(this).val());
    $.ajax({
      type: 'GET',
      url: '/users/',
      data: ('keyword=' + input),
      dataType: 'json',
      processData: false,
      contentType: false,
    })
    .done(function(users) {
     $("#user-search-result").empty();
     if (users.length !== 0) {
      debugger;
       users.forEach(function(users){
         appendUser(users);
       });
     }
     else {
       appendNoUser("一致するユーザーがいません");
     }
   })
    .fail(function() {
      alert('ユーザー検索に失敗しました');
    })
  });
    $("#user-search-result").on("click", ".user-search-add", function(){
      var use_id = $(this).attr('data-user-id');
      var use_name = $(this).attr('data-user-name');
      appendChatUser(use_id, use_name);
      $(this).parent().remove();
      $("#user-search-field").val("")
    });
    $("#chat-group-users").on("click", ".user-search-remove", function(){
      $(this).parent().remove();
    });
});


