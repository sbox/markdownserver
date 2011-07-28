#!/bin/bash

v=$(./version.py | head -n1 | cut -d'.' -f1)

p=$(which python);


if [ $p ]; then
    
    mkdir tmp
    echo \#!$p > tmp/simpleserver
    
    cat components/simpleserver.py >> tmp/simpleserver
    
    if [ $v = "2" ]; then
        echo Python version is 2.*
    elif [ $v = "3" ]; then
        echo Python version is 3.*
        echo Converting code...

        2to3 tmp/simpleserver
    
    fi;

    cp components/startmdserver tmp

    chmod +x tmp/*

    mv tmp/* /usr/bin/
    rm -r tmp

else

    echo "Error: Python is not installed. Please install python.";

fi;
