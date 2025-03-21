#!/bin/python3

import os
import http.server
import socketserver

PORT = 9000

os.chdir("/data")

print("Esto es un programa Python que escucha en el puerto", PORT, "y sirve los ficheros del directorio /data")

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    httpd.serve_forever()

