#!/usr/bin/python

import os
import BaseHTTPServer
import shutil
from optparse import OptionParser

class SimpleServer(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200) #successful GET request
        self.end_headers()
       
        if self.path != "/favicon.ico":
            if self.path == "/":
                pagename = ".server/index.html"
            else:
                pagename = ".server/" + str(self.path) + ".html"
            
            try:

                pagefile = open(pagename, "r")
                page = pagefile.read()

                self.wfile.write(page)
            
            except:

                self.wfile.write("404")
                print "File not found"


def main():


    server = BaseHTTPServer.HTTPServer(('localhost', 8080), SimpleServer)
    print "starting server"
    server.serve_forever()


if __name__ == "__main__":
    main()
