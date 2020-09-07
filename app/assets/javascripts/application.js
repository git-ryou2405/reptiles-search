//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .


/* flashフェードアウト */
$(function(){
  setTimeout("$('.flash').fadeOut('slow')",2000);
});

// file_field 画像プレビュー
$( document ).on('turbolinks:load', function() {
  let prev_img = "";
  
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      
      reader.onload = function (e) {
        $(prev_img).attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  
  $('[id^=post_img]').change(function(){                              // id: post_imgと一致
    let id = event.target.id[8]
    $(`#prev_img${id}`).removeClass('hidden').addClass('select_img'); // 指定した要素へ
    $(`.before_img${id}`).remove();                                   // 要素を削除
    
    // 3、4枚目表示判定
    if (id === '1') {
      if (document.getElementById('before_img2') != null) {
      } else {
        $('#post_img3_4').removeClass('hidden');
      }
    } else if (id === '2') {
      if (document.getElementById('before_img1') != null) {
      } else {
        $('#post_img3_4').removeClass('hidden');
      }
    }
    
    prev_img = `#prev_img${id}`;
    readURL(this);
  });
});

/* スライダー */
var mySwiper = new Swiper('.swiper-container', {
  loop: true,
  speed: 1500,
  effect: 'slide',
  autoplay: { 
      delay: 4000,
      disableOnInteraction: false,
  },
  navigation: { 
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev'
  },
  pagination: {
  el: '.swiper-pagination',
  type: 'bullets',
  clickable: true
}
});

/* スムーススクロール */
$('a[href^="#"]').on('click', function(e) {
  e.preventDefault();
  var pc_offset = 0;
  var sp_offset = 0;
  var speed = 400;
  var href = $(this).attr("href");
  var target = $(href == "#" || href == "" ? 'html' : href);
  var offset = window.innerWidth > 767 ? pc_offset : sp_offset;
  var position = target.offset().top - offset
  $('body,html').animate({scrollTop:position}, speed, 'swing');
});

// アコーディオン
$('.menu-ttl').click(function() {
  $('menu-list').slideToggle();
});

// レスポンシブデバイスジャッジ
function deviceJudgment() {
  var ua = navigator.userAgent;
  if (ua.indexOf('iPhone') > 0 || ua.indexOf('iPod') > 0 || ua.indexOf('Android') > 0 && ua.indexOf('Mobile') > 0) {
      $('head').prepend('<meta name="viewport" content="width=device-width,initial-scale=1">');
  } else {
      $('head').prepend('<meta name="viewport" content="width=1200">');
  }
}
deviceJudgment();



// /* Geocodingで緯度経度を取得 */
// $(function () {
//   function Callback(latlng) {
//     console.log(latlng.addr);
//     console.log(latlng.lat);
//     console.log(latlng.lng);
    
//     var googlemap = "https://maps.google.co.jp/maps?output=embed&q=" + latlng.lat + "," + latlng.lng;
//     console.log(googlemap);
    
//     /* Ajax通信により値をコントローラーへ渡す */
//     $.ajax({
//       url: "http://localhost:3000/users/" + gon.userid,
//       type: "GET", // WebAPIを指定
//       data: { gmap: googlemap } // 受け渡しパラメータオブジェクト
//     })
//       .done(function (data, textStatus, jqXHR) {
//         // サーバー通信成功した場合はこの中の処理が起動
//         // 引数のdataオブジェクトの中にはRailsから受け取ったパラメータが格納されている
//         console.log("接続が成功");
//         console.log(googlemap);
//       })
//       .fail(function() {
//         // サーバーエラーが起きた場合はこの中の処理が起動
//         console.log("接続失敗");
//       });
//   }
  
//   function errorCallback(error) {
//     console.log(error);
//   }
  
//   getLatLng(gon.address, Callback, errorCallback );
  
//   document.getElementById('exec').addEventListener('click', () => {
//     if (document.getElementById('address').value) {
//       getLatLng(document.getElementById('address').value, (latlng) => {
//         map.setCenter(latlng)
//       })
//     }
//   })
// });
