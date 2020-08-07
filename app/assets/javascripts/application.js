//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .


/* flashフェードアウト */
$(function(){
  setTimeout("$('.flash').fadeOut('slow')", 2000);
});

/* アコーディオン */
$('.block-trigger').click(function() {
  if ($(this).find('.wrap-trigger').hasClass('list-open')){
      $(this).find('.wrap-trigger').removeClass('list-open')
      $(this).find('.arrow').removeClass('arrow-active')
  } else {
      $(this).find('.wrap-trigger').addClass('list-open')
      $(this).find('.arrow').addClass('arrow-active')
  }
});
