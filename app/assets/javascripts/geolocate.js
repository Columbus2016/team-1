$(document).on("turbolinks:load", function() {
  console.log("Callback runs");
  var box = $("#geolocation-input");
  console.log("Box is", box);
  box.on("input", function(event){
    console.log("Change with value",event.target.value);
    
    if(event.target.value.length !== 5) 
      return;
    $.getJSON("https://maps.googleapis.com/maps/api/geocode/json?address=" + event.target.value +
      "&key=AIzaSyB8uV_x6Nz9qqDJr81I7EAxXRNZgvvcGJg").then(function(json) {
        console.log(json)
        var r = json.results[0].geometry.location;
        var lat = r.lat, long = r.lng;
        console.log("GOT LOCATIONS", lat, long);
        $("#location_lat").val(lat);
        $("#location_long").val(long);
      });
    });
  console.log("Exits successfully");
});
