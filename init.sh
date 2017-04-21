#!/bin/bash


/etc/init.d/php5-fpm start
nginx
/etc/init.d/php5-fpm stop
