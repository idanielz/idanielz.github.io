#!/bin/bash - 
#===============================================================================
#
#          FILE:  mklib.sh
# 
#         USAGE:  ./mklib.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: cissusnar@gmail.com 
#       COMPANY: 
#       CREATED: 2012/03/19 17时06分21秒 CST
#      REVISION:  ---
#===============================================================================


#alias bsimlib='xcodebuild -arch i386 -sdk /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk/'
#alias barmlib='xcodebuild -arch armv7 -sdk /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/'
. ./config.conf 

BUILDDATE=$(date +%s)
IphoneDEBUGDIR='/Users/zhangjidong/KP/iQiYi_workspace/svn/avlib/Debug/'
IphoneRELEASEDIR='/Users/zhangjidong/KP/iQiYi_workspace/svn/avlib/Release/'

BASESDKPATH='/Applications/Xcode.app/Contents/Developer/Platforms/'
ARMSDKPATH="${BASESDKPATH}iPhoneOS.platform/Developer/SDKs/"
SIMSDKPATH="${BASESDKPATH}iPhoneSimulator.platform/Developer/SDKs/"
LASTARMSDK=$(ls $ARMSDKPATH | sort | tail -n 1)
LASTSIMSDK=$(ls $SIMSDKPATH | sort | tail -n 1)
ARMSDK="${ARMSDKPATH}${LASTARMSDK}"
SIMSDK="${SIMSDKPATH}${LASTSIMSDK}"
#OUT_LIB='avlib.a'
OUT_PATH="$LIBDIRNAME"
CONFIG_ARG='Debug'
#GCC_PREPROCESSOR_DEFINITIONS=\"BUILDDATE=${BUILDDATE}\""
if [[ $1 == "Debug" ]]
then
	CONFIG_ARG="$1"
elif [[ $1 == "Release" ]]
then
	CONFIG_ARG="$1"
else
	CONFIG_ARG="Debug"
fi
compile_it()
{
	echo $@
	$@ clean
	if ( $@ 2>&1 )
	then
		echo 编译成功
	else
		echo 编译失败
		exit 0
	fi
}
#carm6="xcodebuild -configuration ${CONFIG_ARG} -arch armv6 -sdk ${ARMSDK}" 
carm7="xcodebuild -configuration ${CONFIG_ARG} -arch armv7 -sdk ${ARMSDK}"
#GCC_PREPROCESSOR_DEFINITIONS=\"BUILDDATE=${BUILDDATE}\""
#carm7s="xcodebuild -configuration ${CONFIG_ARG} -arch armv7s -sdk ${ARMSDK}"
#GCC_PREPROCESSOR_DEFINITIONS=\"BUILDDATE=${BUILDDATE}\""
csim="xcodebuild -configuration ${CONFIG_ARG} -sdk iphonesimulator"
#GCC_PREPROCESSOR_DEFINITIONS=\"BUILDDATE=${BUILDDATE}\""
carm64="xcodebuild -configuration ${CONFIG_ARG} -arch arm64 -sdk ${ARMSDK}"

echo -e "created by 张熙文cissusnar@gmail.com"
echo -e "build配置:${CONFIG_ARG}\n"
echo -e "配置信息使用:\n\t./mklib.sh Release //编译release \n\t./mklib.sh Debug //编译debug环境 \n\t默认使用Debug环境"

sleep 3

mkdir -p ~/${OUT_PATH}

cd ..
echo "remove old build files"
rm -rf build
echo "build true env(archv6 arm) library"

### for armv7
compile_it $carm7
if [[ $CONFIG_ARG == "Debug" ]]
then
    mv build/Debug-iphoneos build/armv7-iphones
elif [[ $CONFIG_ARG == "Release" ]]
then
    mv build/Release-iphoneos build/armv7-iphones
fi

### for armv7s
#echo "build carm7s library"
#compile_it $carm7s
#if [[ $CONFIG_ARG == "Debug" ]]
#then
#    mv build/Debug-iphoneos build/armv7s-iphones
#elif [[ $CONFIG_ARG == "Release" ]]
#then
#    mv build/Release-iphoneos build/armv7s-iphones
#fi

### for simulator
#echo "build simulator library"
#compile_it $csim
#if [[ $CONFIG_ARG == "Debug" ]]
#then
#    mv build/Debug-iphoneos build/i386-iphones
#elif [[ $CONFIG_ARG == "Release" ]]
#then
#    mv build/Release-iphoneos build/i386-iphones
#fi

### for arm64
echo "build arm64 library"
compile_it $carm64
if [[ $CONFIG_ARG == "Debug" ]]
then
    mv build/Debug-iphoneos build/arm64-iphones
elif [[ $CONFIG_ARG == "Release" ]]
then
    mv build/Release-iphoneos build/arm64-iphones
fi

echo "build simulator library"
compile_it $csim

echo "build done"

rm -rf build/NewAVPlayer.build

cd build
echo "scan done library"
ALLLIBS=$(find . -name "*.a")
COLL_STRING='-create '
for tmp_lib in $ALLLIBS
do
	COLL_STRING="${COLL_STRING} $tmp_lib"
done
echo "combine library"
if ( lipo $COLL_STRING -output $OUT_LIB 2>&1)
then
	echo 合成成功
	cp -rf $OUT_LIB ~/${OUT_PATH}
    if [[ $1 == "Debug" ]]
    then
        cp -rf $OUT_LIB $IphoneDEBUGDIR
    elif [[ $1 == "Release" ]]
    then
        cp -rf $OUT_LIB $IphoneRELEASEDIR
    fi
	echo "copy $OUT_LIB to ~/${OUT_PATH}"
	echo $BUILDDATE > ~/${OUT_PATH}/build.txt
else
	echo 合成错误
	exit 0
fi
exit 1
