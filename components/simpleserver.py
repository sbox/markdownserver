

import os
import sys
import BaseHTTPServer
import shutil
from optparse import OptionParser

home = sys.argv[1]

class SimpleServer(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200) #successful GET request
        self.end_headers()
       
        if self.path != "/favicon.ico":
            if self.path == "/":
                pagename =  home + "/.mdserver/index.html"
            else:
                pagename =  home + "/.mdserver/" + str(self.path) + ".html"
            
            try:

                pagefile = open(pagename, "r")
                page = pagefile.read()

                self.wfile.write(page)
            
            except:

                self.wfile.write("404 - The file "+pagename+" was not found.")
                print "File not found"


def main():


    server = BaseHTTPServer.HTTPServer(('localhost', 8080), SimpleServer)
    print "starting server"
    server.serve_forever()


if __name__ == "__main__":
    main()
