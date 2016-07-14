#!/bin/sh

oldVersion=`more avlib.podspec|grep "  s.version"|awk -F '"' '{print $2}'`
lastNum=`echo $oldVersion|awk -F '.' '{print $3}'`
lastNum=`expr $lastNum + 1`
lastNum=`printf "%03d" $((lastNum+0))`
result=`echo $oldVersion|awk -F '.' '{print $1"."$2}'`.$lastNum
echo $result

#sed -i .bak "s/s.version.*\"$/s.version      = \"$result\"/" avlib.podspec
#rm avlib.podspec.bak
