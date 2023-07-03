#!/bin/bash

# start php-fpm
service php-fpm start

# start nginx
nginx -g 'daemon off;'