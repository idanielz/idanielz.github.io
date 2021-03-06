#!/bin/bash - 

. ./Config.conf
echo "cd $PodPath"
cd $PodPath

echo "git tag -am"
sleep 3

git tag -am "add tag version $TagVersion" $TagVersion
git push origin --tags
sleep 3
pod repo push qyspec

sleep 3
echo "cd $MainCodePath"
cd $MainCodePath
git checkout .
git pull --rebase

sleep 3
echo "修改Podfile"
sed -i .bak "s/pod 'puma3', .*'$/pod 'puma3', '$TagVersion'/" Podfile
rm Podfile.bak

sleep 3
echo "提交Podfile"
git add Podfile
git commit -m "update Podfile puma3 version $TagVersion"
git push origin HEAD:refs/for/master
echo "gerrit 待审核"
