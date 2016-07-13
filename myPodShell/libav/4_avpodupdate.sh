#!/bin/bash - 

. ./avConfig.conf
echo "cd $AVPodPath"
cd $AVPodPath

echo "git tag -am"
sleep 3

git tag -am "add tag version $TagVersion" $TagVersion
git push origin --tags
pod repo push qyspec

sleep 3
echo "cd $MainCodePath"
cd $MainCodePath
git checkout .
git pull --rebase

sleep 3
echo "修改Podfile"
sed -i .bak "s/\'avlib\'\, \'.*\'\, \:/\'avlib\'\, \'$TagVersion\'\, \:/" Podfile
sed -i .bak "s/\'avlib_debug\'\, \'.*\'\, \:/\'avlib_debug\'\, \'$TagVersion\'\, \:/" Podfile
rm Podfile.bak

sleep 3
echo "提交Podfile"
git add Podfile
git commit -m "update Podfile avlib version $TagVersion"
git push origin HEAD:refs/for/master
echo "gerrit 待审核"
