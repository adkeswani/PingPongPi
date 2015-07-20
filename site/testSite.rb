gem 'test-unit'
require 'test/unit'
require 'net/http'

HOST = '127.0.0.1'
PORT = '8080'
SITE_SCRIPT = './site.js'
TEST_LAST_CAPTURE_PATH = './testCapture'
LAST_CAPTURE_TIME_URI = '/captures/0/time'

Test::Unit.at_start do
    $sitePid = spawn "node #{SITE_SCRIPT} TEST_LAST_CAPTURE_PATH"
end

Test::Unit.at_exit do
    Process.kill "SIGINT", $sitePid
end

class SiteLastCaptureTimeTest < Test::Unit::TestCase
    def test_no_last_capture_time_file
        http = Net::HTTP.new(HOST, PORT)
        request = Net::HTTP::Get.new LAST_CAPTURE_TIME_URI
        response = http.request request
        puts "Response #{response.code} #{response.message}: #{response.body}"
        assert_equal 200, response.code
    end

    def test_last_capture_time_file_exists
        #assert_equal 200, response.code
        return
    end


    def test_error_opening_last_capture_time_file
        #assert_equal 200, response.code
        return
    end
end

# Unopenable capture file




