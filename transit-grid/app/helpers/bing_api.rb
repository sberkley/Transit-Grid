#!/usr/bin/env ruby
require 'net/http'
require 'json'

module BingApi
  
  # type should be Transit or Walking
  def getGeneralRoute(type, wp0, wp1, time)
    
    bing_api_key = TransitGrid::Application::BING_API_KEY
    uri = URI("http://dev.virtualearth.net/REST/V1/Routes/#{type}" )
    params = { :"wp.0" => wp0, :"wp.1" => wp1,
     :timeType => "Departure", :dateTime => time,
     :key => bing_api_key }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    return JSON.parse(res.body)
    
  end
  
  def getTransitRoute(wp0, wp1, time)
    getGeneralRoute("Transit",wp0, wp1, time)
  end
  
  def getWalkingRoute(wp0, wp1, time)
    getGeneralRoute("Walking",wp0, wp1, time)
  end
  
  def checkResponse(route)
    code = route["statusCode"]
    if code == 200 
      return "ok"
    else
      route["errorDetails"].each do |error|
        if error == "Walking is a better option."
          return "walk"
        end
      end
      return "error"
    end
  end
  
  def getTime(route)
    return -1 unless route.has_key? "resourceSets" #&& !route["resourceSets"][0].nil?
    rs= route["resourceSets"][0]
    return -1 unless rs.has_key? "resources" #&& !rs["resources"][0].nil?
    r = rs["resources"][0]
    time = r["travelDuration"]/60
  end
  
  def calculateTrip(wp0, wp1, time)
    transitRoute = getTransitRoute(wp0, wp1, time)
    puts transitRoute
    case checkResponse(transitRoute)
    when "ok"
      return getTime(transitRoute)
    when "walk"
      walkingRoute = getWalkingRoute(wp0, wp1, time)
      puts walkingRoute
      return getTime(walkingRoute) if checkResponse(walkingRoute) == "ok"
      return -1
    when "error"
      return -1
    end
  end  
end


#puts "Starting Bing API test"
#time = calculateTrip("969 Columbus Ave, New York", "511 W 113th St, New York", "11:11:00AM")
#969 Columbus = [40.800125, -73.9618]
#511 W 113th = [40.805389, -73.963066]

#puts "Trip takes #{time} minutes"
