require 'net/http'
require 'rubygems'
require 'json'

@host = '127.0.0.1'
@port = '8080'

def post
    payload = {
        "blah" => "blah"
    }.to_json

    request = Net::HTTP::Post.new('/', initheader = {'Content-Type' =>'application/json'})
    # request.basic_auth @user, @pass
    request.body = payload

    response = Net::HTTP.new(@host, @port).start {|http| http.request(request)}
    puts "Response #{response.code} #{response.message}: #{response.body}"
end

post
