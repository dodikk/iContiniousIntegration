#
# /bin/bash
#
######################

LAUNCH_DIR=$PWD

cd ../
    PROJECT_ROOT=$PWD
cd "$LAUNCH_DIR"

BUILD_STYLE=$1
#BUILD_STYLE=Release
LIB_NAME=libCITest_Model_Universal.a

LIB_ROOT_DIR=$PROJECT_ROOT/lib/CITest-Model-Universal

DEPLOYMENT_HEADERS_DIR=$PROJECT_ROOT/frameworks/CITest-Model-Universal/include/CITest-Model-Universal
DEPLOYMENT_BINARY_DIR=$PROJECT_ROOT/frameworks/CITest-Model-Universal/Lib

cd "$LIB_ROOT_DIR"
#    xcodebuild -project CITest-Model-Universal.xcodeproj -alltargets -configuration $BUILD_STYLE -sdk iphoneos4.2 clean build
#    xcodebuild -project CITest-Model-Universal.xcodeproj -alltargets -configuration $BUILD_STYLE -sdk iphonesimulator4.2 clean build

    xcodebuild -project CITest-Model-Universal.xcodeproj -target CITest-Model-Universal -configuration $BUILD_STYLE -sdk iphoneos4.3 build 
    xcodebuild -project CITest-Model-Universal.xcodeproj -target CITest-Model-Universal -configuration $BUILD_STYLE -sdk iphonesimulator4.3 build
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
cd "$LAUNCH_DIR"



# combine lib files for various platforms into one
lipo -create "${LIB_BUILD_DIR}/${BUILD_STYLE}-iphoneos/${LIB_NAME}" "${LIB_BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/${LIB_NAME}" -output "${DEPLOYMENT_BINARY_DIR}/${LIB_NAME}"
