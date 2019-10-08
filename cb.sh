#!/bin/sh

echo -e "\e[95m($(git status | grep 'On branch' | cut -d' ' -f3))"
