#!/bin/bash

echo check http connection is forbidden
curl -k http://youkim.42.fr

echo checking TLS version
curl -vI https://youkim.42.fr
