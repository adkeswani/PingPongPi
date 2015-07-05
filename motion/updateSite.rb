require 'net/http'
require 'rubygems'
require 'json'

HOST = '127.0.0.1'
PORT = '8080'
LAST_CAPTURE_TIME_PATH = '/lastCapture/time'

def updateRequired(http)
    request = Net::HTTP::Get.new LAST_CAPTURE_TIME_PATH
    response = http.request request
    puts "Response #{response.code} #{response.message}: #{response.body}"
    return false
end

def update
    #payload = {
    #    "blah" => "blah"
    #}.to_json

    #request = Net::HTTP::Get.new('/lastCapture/time', initheader = {'Content-Type' =>'application/json'})
    # request.basic_auth @user, @pass
    #request.body = payload

    #response = Net::HTTP.new(@host, @port).start {|http| http.request(request)}
    # puts "Response #{response.code} #{response.message}: #{response.body}"
    return
end


Net::HTTP.start(HOST, PORT) do |http|
    if updateRequired(http)
        update
    end
end
