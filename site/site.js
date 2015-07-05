var http = require('http');
var url = require('url');

var LAST_CAPTURE_PATH = '/lastCapture';
var LAST_CAPTURE_TIME_PATH = LAST_CAPTURE_PATH.concat('/time');

function respondWithLastCaptureTime(response)
{
    response.writeHead(200, {"Content-Type": "application/json"});
    var lastCaptureTimeVar = new Date();
    var lastCaptureTimeJson = JSON.stringify({lastCaptureTime: lastCaptureTimeVar})
    response.end(lastCaptureTimeJson);
}

function respondWithLastCapturePage(response)
{
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World 2\n");
}

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) 
{

/*
    if (request.method == 'POST') 
    {
        var body = '';
        request.on('data', function (data) { 
            body += data.toString();

            // Ensure we are not being flooded with data (1e6 == 1MB)
            if (body.length > 1e6) { 
                request.connection.destroy();
            }
        });

        request.on('end', function() { 
            var bodyJson = JSON.parse(body);
            console.log(bodyJson);

            // Look at URL, redirect appropriate method
        });
    }
*/

    if (request.method == 'GET')
    {
        // We expect no data, so lose any if it is provided
        request.unpipe();
        request.resume();

        request.on('end', function() { 
            urlObj = url.parse(request.url);
            if (urlObj.pathname == LAST_CAPTURE_TIME_PATH)
            {
                respondWithLastCaptureTime(response);
            }
            else
            {
                respondWithLastCapturePage(response);
            }
        });
    }
}
);

// Listen on port 8080, IP defaults to 127.0.0.1
server.listen(8080);

// Put a friendly message on the terminal
console.log("Server running at http://127.0.0.1:8080/");
