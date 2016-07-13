#!/bin/bash - 

. ./avConfig.conf
#1. 更新最新pod
echo "cd $AVPodPath"
cd $AVPodPath
git checkout .
git pull --rebase

#2. 更新最新av代码
echo "cd $AVCodePath"
cd $AVCodePath
git checkout .
git pull --rebase

#3. 将mklib.sh拷贝到scripts目录
cp /Users/zhangjidong/Desktop/myPodShell/libav/mklib.sh $AVCodePath/scripts

#4. 打包
echo "cd $AVCodePath/scripts"
cd $AVCodePath/scripts
echo "mklib Debug"
sleep 2
sh mklib.sh Debug
echo "mklib Release"
sleep 2
sh mklib.sh Release
sleep 2

#5. 修改spec文件
echo "cd $AVPodPath"
cd $AVPodPath
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
echo "git add Debug Release *.podspec"
sleep 3
git add Debug Release *.podspec
git commit -m "update libav.a $TagVersion"
git push origin HEAD:refs/for/master

