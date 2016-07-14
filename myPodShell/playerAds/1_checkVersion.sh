#!/bin/bash

echo "cd /Users/zhangjidong/KP/iQiYi_workspace/svn/playerAds"
cd /Users/zhangjidong/KP/iQiYi_workspace/svn/playerAds
git checkout .
git pull --rebase
more playerAds.podspec|grep s.version
