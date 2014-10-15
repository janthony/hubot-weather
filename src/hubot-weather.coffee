# Description:
#   Hubot script to show weather for some city
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot weather in <city> - Show today forecast for interested city.
#    or trigger from a robot as
#   robot.emit "weather", msg, { city: "<city>" }
#   
# Author:
#   skibish
# Updated: 
#  	janthony
module.exports = (robot) ->
 robot.on "weather", (msg, weatherQuery) ->
    robot.http("http://api.openweathermap.org/data/2.5/weather?q=#{weatherQuery.city}&units=metric")
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        data = JSON.parse(body)
        if data.message
          msg.send "#{data.message}"
        else
          msg.send "Forecast for today in #{data.name}, #{data.sys.country}\nCondition: #{data.weather[0].main}, #{data.weather[0].description}\nTemperature (min / max): #{data.main.temp_min}°C / #{data.main.temp_max}°C\nHumidity: #{data.main.humidity}%\nType: #{data.sys.type}\n\nLast updated: #{new Date(data.dt * 1000)}"

  robot.respond /weather in (.*)/i, (msg) ->
    msg.http("http://api.openweathermap.org/data/2.5/weather?q=#{msg.match[1]}&units=metric")
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        data = JSON.parse(body)
        if data.message
          msg.send "#{data.message}"
        else
          msg.send "Forecast for today in #{data.name}, #{data.sys.country}\nCondition: #{data.weather[0].main}, #{data.weather[0].description}\nTemperature (min / max): #{data.main.temp_min}°C / #{data.main.temp_max}°C\nHumidity: #{data.main.humidity}%\nType: #{data.sys.type}\n\nLast updated: #{new Date(data.dt * 1000)}"
