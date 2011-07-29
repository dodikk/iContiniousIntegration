#
#/bin/bash
#
######

PROJECT_NAME=CITest
TARGET_NAME=CITest
OS_VERSION=5.0
###

LAUNCH_DIR=$PWD

cd "../certificates"
   CERTIFICATES_DIR=$PWD
cd "$LAUNCH_DIR"

cd "../app/$PROJECT_NAME"
   PROJECT_DIR=$PWD
cd "$LAUNCH_DIR"

mkdir -p ../deployment
cd "../deployment"
   DEPLOYMENT_DIR=$PWD
cd "$LAUNCH_DIR"
###

#DEVELOPER_NAME="iPhone Developer: Oleksandr Dodatko (ABCDEFG123456)"
DEVELOPER_NAME="iPhone Developer: Nick Hencher (T248B93756)"
PROVISONING_PROFILE=$CERTIFICATES_DIR/CITest.mobileprovision
BUILD_DIR=$(cat /tmp/CITestBuild/CI_TEST_PRODUCT_DIR.txt)

cd "$PROJECT_DIR"
    echo -----------------------------    
    BUILD_CMD_SIMULATOR="xcodebuild -project $PROJECT_NAME.xcodeproj -target $TARGET_NAME -configuration Release -parallelizeTargets -sdk iphonesimulator$OS_VERSION clean build"
    echo $BUILD_CMD_SIMULATOR
    $BUILD_CMD_SIMULATOR
    cp -r "$BUILD_DIR/Release-iphonesimulator/${PROJECT_NAME}.app" "${DEPLOYMENT_DIR}"


    echo -----------------------------
    BUILD_CMD_DEVICE="xcodebuild -project $PROJECT_NAME.xcodeproj -target $TARGET_NAME -configuration Release -parallelizeTargets -sdk iphoneos$OS_VERSION clean build"
    echo $BUILD_CMD_DEVICE
    $BUILD_CMD_DEVICE
    
    /usr/bin/xcrun -sdk iphoneos PackageApplication -v "${BUILD_DIR}/Release-iphoneos/${PROJECT_NAME}.app" -o "${DEPLOYMENT_DIR}/${PROJECT_NAME}.ipa" #--sign "${DEVELOPER_NAME}" --embed "${PROVISONING_PROFILE}"
cd "$LAUNCH_DIR"


cd "${DEPLOYMENT_DIR}"
   zip -r "${PROJECT_NAME}.zip" "${PROJECT_NAME}.app" "${PROJECT_NAME}.ipa"
cd "$LAUNCH_DIR"


