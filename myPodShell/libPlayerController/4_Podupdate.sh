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
sed -i .bak "s/\'libPlayerPhone\'\, \'.*\'\, \:/\'libPlayerPhone\'\, \'$TagVersion\'\, \:/" Podfile
sed -i .bak "s/\'libPlayerPhone_debug\'\, \'.*\'\, \:/\'libPlayerPhone_debug\'\, \'$TagVersion\'\, \:/" Podfile
sed -i .bak "s/\'libPlayerPad\'\, \'.*\'\, \:/\'libPlayerPad\'\, \'$TagVersion\'\, \:/" Podfile
sed -i .bak "s/\'libPlayerPad_debug\'\, \'.*\'\, \:/\'libPlayerPad_debug\'\, \'$TagVersion\'\, \:/" Podfile
rm Podfile.bak

sleep 3
echo "提交Podfile"
git add Podfile
git commit -m "update Podfile libPlayer version $TagVersion"
git push origin HEAD:refs/for/master
echo "gerrit 待审核"

cd $CodePath
echo "rm -rf build"
rm -rf build
git checkout .