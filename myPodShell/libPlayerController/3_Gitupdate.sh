#!/bin/bash - 

. ./Config.conf
MYPATH=`pwd`
#1. 更新最新pod
echo "cd $PodPath"
cd $PodPath
git checkout .
git pull --rebase

#2. 更新最新代码
echo "cd $CodePath"
cd $CodePath
git checkout .
git pull --rebase

#3. 将mklib.sh拷贝到scripts目录
cp $MYPATH/mklib.sh $CodePath/scripts

#4. 打包
echo "cd $CodePath/scripts"
cd $CodePath/scripts
echo "mklib Debug"
sleep 2
sh mklib.sh Debug
echo "mklib Release"
sleep 2
sh mklib.sh Release
sleep 2

echo "mklib PadDebug"
sleep 2
sh mklib.sh PadDebug
echo "mklib PadRelease"
sleep 2
sh mklib.sh PadRelease
sleep 2

#5. 修改spec文件
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

#6. Git提交
echo "git add debug release padDebug padReleasee *.podspec"
sleep 3
git add debug release padDebug padRelease *.podspec
echo "git commit $TagVersion"

git commit -m "update libplayer.a $TagVersion"
echo "git push"

git push origin HEAD:refs/for/master