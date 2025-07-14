#!/bin/bash
echo $1 | entr sh -c "lualatex $1"
