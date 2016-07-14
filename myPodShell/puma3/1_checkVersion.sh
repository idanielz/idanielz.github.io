#!/bin/bash

echo "cd /Users/zhangjidong/KP/iQiYi_workspace/svn/puma3"
cd /Users/zhangjidong/KP/iQiYi_workspace/svn/puma3
git checkout .
git pull --rebase
more puma3.podspec|grep s.version
