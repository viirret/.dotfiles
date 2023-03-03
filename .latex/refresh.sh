#!/bin/bash
echo $1 | entr sh -c "pdflatex $1"
