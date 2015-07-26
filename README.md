# PingPongPi
Use raspberry pi to detect when a ping pong table is in use and update a web page accordingly.

motion/motionUpdateSiteTask - Input is the directory containing the captures and the interval in seconds between checking for the latest capture. Calls motion/getLastCapture and motion/updateSite.rb.

motion/getLastCapture.py - Input is the directory containing the captures and output is the absolute path to the latest capture and the time it was captured (in seconds since epoch). NOTE: Depends on the filename format specified by motion.conf.

motion/updateSite.rb - Input is the absolute path to the latest capture and the time it was captured. Makes HTTP requests to the site to check if the latest capture is more recent than the one being shown by the site, then updates the site if necessary.

site/site.js - Responds to GET requests with a page showing the latest capture and the time it was captured, or JSON containing the time of the last capture. Accepts POST requests containing new captures and the URL-encoded time it was captured.
