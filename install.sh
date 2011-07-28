#!/bin/bash

echo Checking for python...

p=$(which python);


if [ $p ]; then
    echo Python installation found. Checking version...
    v=$(./version.py | head -n1 | cut -d'.' -f1)
    
    mkdir tmp

    echo Prepending server with python location...
    echo \#!$p > tmp/simpleserver
    
    echo Copying code...
    cat components/simpleserver.py >> tmp/simpleserver
    
    if [ $v = "2" ]; then
        echo Python version is 2.*
    elif [ $v = "3" ]; then
        echo Python version is 3.*
        echo Converting code...
        
        2to3 -w tmp/simpleserver
    fi;
    
    echo Copying server wrapper...
    cp components/startmdserver tmp
    
    echo Setting permissions...
    chmod +x tmp/*

    echo Copying files...
    mv tmp/* /usr/bin/

    echo Cleaning up...
    rm -r tmp

    echo Installation complete!
    echo
    echo Usage Instructions
    echo 1. Navigate to a directory containing markdown files.
    echo 2. Run the command \"startmdserver\".
    echo 3. In your web browser, visit localhost:8080.
    echo
    
else

    echo "Error: Python is not installed. Please install python.";

fi;
