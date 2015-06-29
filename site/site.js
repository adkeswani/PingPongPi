var http = require('http');

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) 
{
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

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.end("Hello World\n");
});

// Listen on port 8080, IP defaults to 127.0.0.1
server.listen(8080);

// Put a friendly message on the terminal
console.log("Server running at http://127.0.0.1:8080/");
