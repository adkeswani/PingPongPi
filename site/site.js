if (process.argv.length != 3)
{
    if (process.argv.length >= 2)
    {
        console.log("Usage: %s %s absCapturePath", process.argv[0], process.argv[1]);
    }
    process.exit();
}

var http = require('http');
var url = require('url');
var fs = require('fs');
var path = require('path');

var LAST_CAPTURE_PATH = process.argv[2];
var LAST_CAPTURE_TIME_FILE_PATH = path.join(LAST_CAPTURE_PATH, '/time');

var LAST_CAPTURE_URI = '/captures/0';
var LAST_CAPTURE_TIME_URI = LAST_CAPTURE_URI.concat('/time');

function respondWithLastCaptureTime(response)
{
    console.log('### Responding with last capture time ###');

    fs.readFile(LAST_CAPTURE_TIME_FILE_PATH, 'utf8', function(err, data)
    {
        if ((err == null) || (err.code == 'ENOENT'))
        {
            response.writeHead(200, {'Content-Type': 'application/json'});
            var lastCaptureTimeJson;
            if (err)
            {
                lastCaptureTimeJson = JSON.stringify({lastCaptureTime: '0'});
            }
            else
            {
                lastCaptureTimeJson = JSON.stringify({lastCaptureTime: data.trim()});
            }
            response.end(lastCaptureTimeJson);
            console.log('Responded with 200. %s', lastCaptureTimeJson);
        }
        else
        {
            response.writeHead(500, 'Could not stat last capture file');
            console.log('Responded with 500. Could not read last capture time file.');
        }
    });
}

function respondWithLastCapturePage(response)
{
    console.log('### Responding with last capture page ###');
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.end('Hello World 2\n');
    console.log('Responded with page containing');
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
        console.log('### Received GET request ###');
        console.log(request.headers);

        // We expect no data, so lose any if it is provided
        request.unpipe();
        request.resume();

        request.on('end', function() { 
            urlObj = url.parse(request.url);
            if (urlObj.pathname == LAST_CAPTURE_TIME_URI)
            {
                respondWithLastCaptureTime(response);
            }
            else
            {
                respondWithLastCapturePage(response);
            }
        });

        console.log('Finished responding to GET request');
    }
}
);

// Listen on port 8080, IP defaults to 127.0.0.1
server.listen(8080);

// Put a friendly message on the terminal
console.log('Server running at http://127.0.0.1:8080/');
