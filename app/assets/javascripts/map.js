/*
mapを関数の外で定義(codeAddressでも使うため)
geocoderを用意
*/

//変数は必ず初めに定義する。（グローバル変数）
let map;
let geocoder;
//inputAddressはbooks/show.html.erbにて定義
let inputAddress;

function initMap(){
    console.log('initMap');

  // geocoderを初期化
  geocoder = new google.maps.Geocoder()
  codeAddress(inputAddress)
}

function codeAddress(inputAddress){
  console.log(inputAddress);
  // geocodingしたあとmapを移動
  geocoder.geocode( { 'address':inputAddress }, function(results, status) {
    console.log(status);
    console.log(results);
  // geocoder.geocode( { 'address': addr}, function(results, status) {
    if (status == 'OK') {


      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 15
      });
　　　// map.setCenterで地図が移動
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });

    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

