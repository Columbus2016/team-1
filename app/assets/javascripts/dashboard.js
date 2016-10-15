var CHART_OPTIONS = {
  responsive: true
};


function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function randomColorList(len) {
  var ary = [];
  for(var i = 0; i < len; i++) {
    ary.push(getRandomColor());
  }
  return ary;
}

function loadTypePie(arr) {
  var labels = arr.map(function(d, index) {
    return d[0];
  });
  var counts = arr.map(function(d, index) {
    return d[1];
  });
  var data = {
    labels: labels,
    datasets: [{data: counts, backgroundColor: randomColorList(labels.length)}],
  };
  var canvas = $("#typePie");
  var ctx = (canvas[0]).getContext("2d");
  ctx.canvas.height = 500;
  ctx.canvas.width = 500;
  new Chart(ctx,{
    type: "pie",
    data: data,
    options: CHART_OPTIONS
  });
}

function loadMonthPostLine(data) {
  console.log(data);
  var labels = data.map(function(a) {
    console.log(a[0]);
    return (new Date(a[0])).getMonth();
  });
  var vals = data.map(function(a) {
    return a[1];
  });
  new Chart($("#dayPostLine"),{
    type: "line",
    data: {
      labels: labels,
      datasets: [{
        label: "Post per Month",
        data: vals
      }]
    }
  });
}
function performGraph(data) {
  loadTypePie(data.by_cancer_type);
  loadMonthPostLine(data.posts_by_month);
}

$(document).on("turbolinks:load", function() {
  console.log("It starts");
  $("#filter-submit").removeAttr("data-disable-with");
  $("#dashboard_form").on("submit", function(event) {
    console.log("Begin submit event");
    event.preventDefault();
    console.log(event);
    var serialized = $("#dashboard_form").serialize();
    var url = "/dashboard.json?" + serialized;
    console.log("Getting w/ URL",url);
    $.getJSON(url).then(function(resp) {
      $("#main-footer").hide();
      $("#masthead").css("height", "calc(100vh - 40px)");
      $("#masthead").css("margin-bottom", "0px");
      performGraph(resp);
      $("#filter-submit").attr("disabled", false);
    });
    $.rails.enableElement($('input[type="submit"]'));
  });
});
