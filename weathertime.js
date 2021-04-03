// set date and time
const now = new Date()
//shows user date
now ;

//have user set city
api.openweathermap.org/data/2.5/weather?q=Melbourne,au&callback=test&appid={95d45e22e25beabfd8f355a8a82456c9}

//importing openweathermap api
// reference https://stackoverflow.com/questions/36174177/show-local-weather-using-openweathermap-api

var getWeather = function(data) {
    $.getJSON('http://api.openweathermap.org/data/2.5/weather', {
        lat: data.lat,
        lon: data.lon,
        units: "metric",
        appid: "95d45e22e25beabfd8f355a8a82456c9"
    }, showWeather, 'jsonp');
};

var showWeather = function(data) {
    $("#test").text("this shows local weather")
    $("#temp").text(data.main.temp)
    $("#description").text(data.weather[0].description)
    $("#place").text(data.name)
};

$(document).ready(function() {
    $("#btn").click(function() {
        $.getJSON('http://ip-api.com/json', getWeather)
    })
})
