#!/bin/bash

cd dist
git init 
git add *
git commit -m "Initial commit"
git remote add origin https://github.com/angular-kr/angular-kr.github.io.git
git push --force origin master