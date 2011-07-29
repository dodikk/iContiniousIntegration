#
# /bin/bash
#
######################

LAUNCH_DIR=$PWD

cd ../
    PROJECT_ROOT=$PWD
cd "$LAUNCH_DIR"

BUILD_STYLE=$1
if [ -z "$BUILD_STYLE" ]
then
    BUILD_STYLE=Release
fi


echo BUILD_STYLE : $BUILD_STYLE

#BUILD_STYLE=Release
LIB_NAME=libCITest_Model_Universal.a

LIB_ROOT_DIR=$PROJECT_ROOT/lib/CITest-Model-Universal

DEPLOYMENT_ROOT_DIR=$PROJECT_ROOT/frameworks/CITest-Model-Universal
DEPLOYMENT_HEADERS_DIR=$DEPLOYMENT_ROOT_DIR/include/CITest-Model-Universal
DEPLOYMENT_BINARY_DIR=$DEPLOYMENT_ROOT_DIR/Lib

cd "$LIB_ROOT_DIR"
    xcodebuild -project CITest-Model-Universal.xcodeproj -target CITest-Model-Universal -configuration $BUILD_STYLE -sdk iphoneos5.0 clean build 
    xcodebuild -project CITest-Model-Universal.xcodeproj -target CITest-Model-Universal -configuration $BUILD_STYLE -sdk iphonesimulator5.0 clean build
cd "$LAUNCH_DIR"

LIB_BUILD_DIR=$(cat /tmp/CITestBuild/CI_TEST_UNIVERSAL_LIB_PRODUCT_DIR.txt)
##########################################
# make a new output folder
rm -r -f "${DEPLOYMENT_HEADERS_DIR}"
rm -r -f "${DEPLOYMENT_BINARY_DIR}"

mkdir -p "${DEPLOYMENT_HEADERS_DIR}"
mkdir -p "${DEPLOYMENT_BINARY_DIR}"

cd "$LIB_ROOT_DIR"
   cp *.h "${DEPLOYMENT_HEADERS_DIR}"
   cp Framework.plist "$DEPLOYMENT_ROOT_DIR"
cd "$LAUNCH_DIR"



# combine lib files for various platforms into one
lipo -create "${LIB_BUILD_DIR}/${BUILD_STYLE}-iphoneos/${LIB_NAME}" "${LIB_BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/${LIB_NAME}" -output "${DEPLOYMENT_BINARY_DIR}/${LIB_NAME}"
