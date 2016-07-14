#!/bin/bash - 

. ./Config.conf
MYPATH=`pwd`
#1. 更新最新pod
echo "cd $PodPath"
cd $PodPath
git checkout .
git pull --rebase

#2. 将mklib.sh拷贝到scripts目录
cp $LibPath/* $PodPath


#3. 修改spec文件
echo "cd $PodPath"
cd $PodPath
echo "修改spec文件"
sleep 2
for spec in `ls *.podspec`;
do
    echo "修改 $spec"
    cmd=`echo "sed -i .bak 's/s\.version.*\"$/s.version      = \"$TagVersion\"/'" $spec`
    echo "\t\t $spec...Done"
    sh -c "$cmd"
    rm $spec".bak"
done

#4. Git提交
echo "git add ."
sleep 3
git add .
git commit -m "update libPlayerAds.a $TagVersion"
git push origin HEAD:refs/for/master

