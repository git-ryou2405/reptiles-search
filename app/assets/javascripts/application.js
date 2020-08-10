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
