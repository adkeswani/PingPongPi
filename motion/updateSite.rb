if ARGV.length != 2
    puts "Usage: #{$PROGRAM_NAME} captureFile captureTime"
    exit 1
end

gem 'multipart-post'
require 'net/http'
require 'rubygems'
require 'json'

CLIENT_LAST_CAPTURE_FILE = ARGV[0]
CLIENT_LAST_CAPTURE_TIME = ARGV[1]

HOST = '127.0.0.1'
PORT = '8080'
LAST_CAPTURE_TIME_URI = '/captures/0/time'
LAST_CAPTURE_TIME_KEY = 'lastCaptureTime'

def updateRequired(http)
    required = false;

    puts "### Requesting last capture time from #{LAST_CAPTURE_TIME_URI} ###"
    request = Net::HTTP::Get.new LAST_CAPTURE_TIME_URI
    response = http.request request
    puts "Response #{response.code} #{response.message}: #{response.body}"

    bodyJson = JSON.parse(response.body)
    if bodyJson[LAST_CAPTURE_TIME_KEY] < CLIENT_LAST_CAPTURE_TIME # Will require some casts here
        required = true;
    end

    return required
end

def update
    #payload = {
    #    "blah" => "blah"
    #}.to_json
    #params = { :lastcapturetime =>  }
    #uri.query = URI.encode_www_form params

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
