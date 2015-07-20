gem 'test-unit'
require 'test/unit'
require 'net/http'
require 'json'

HOST = '127.0.0.1'
PORT = '8080'
SITE_SCRIPT = './site.js'
LAST_CAPTURE_TIME_URI = '/captures/0/time'
TEST_LAST_CAPTURE_PATH = './testCapture'
TEST_TIME_FILE_PATH = File.join(TEST_LAST_CAPTURE_PATH, '/time');

Test::Unit.at_start do
    Dir.mkdir TEST_LAST_CAPTURE_PATH
    $sitePid = spawn "node #{SITE_SCRIPT} #{TEST_LAST_CAPTURE_PATH}", :out=>"/dev/null"
    sleep(3)
end

Test::Unit.at_exit do
    Process.kill "SIGINT", $sitePid
    Dir.rmdir TEST_LAST_CAPTURE_PATH
end

class SiteLastCaptureTimeTest < Test::Unit::TestCase
    def test_no_last_capture_time_file
        http = Net::HTTP.new(HOST, PORT)
        request = Net::HTTP::Get.new LAST_CAPTURE_TIME_URI
        response = http.request request

        body = JSON.parse response.body
        assert_equal "200", response.code
        assert_equal "0", body["lastCaptureTime"]
        assert_equal 1, body.size
    end

    def test_last_capture_time_file_exists
        File.open TEST_TIME_FILE_PATH, "w:UTF-8" do |timeFile|
            timeFile.write "1337\n"
        end

        http = Net::HTTP.new(HOST, PORT)
        request = Net::HTTP::Get.new LAST_CAPTURE_TIME_URI
        response = http.request request

        body = JSON.parse response.body
        assert_equal "200", response.code
        assert_equal "1337", body["lastCaptureTime"]
        assert_equal 1, body.size

        File.delete TEST_TIME_FILE_PATH
    end


    def test_error_opening_last_capture_time_file
        File.open TEST_TIME_FILE_PATH, "w:UTF-8" do |timeFile|
            timeFile.chmod 0200

            http = Net::HTTP.new(HOST, PORT)
            request = Net::HTTP::Get.new LAST_CAPTURE_TIME_URI
            response = http.request request

            assert_equal "500", response.code
            assert_equal "", response.body
        end

        File.delete TEST_TIME_FILE_PATH
    end
end

# Unopenable capture file




