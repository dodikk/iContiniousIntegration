# Original Script by  Pete Goodliffe
# from http://accu.org/index.php/journals/1594

# Modified by Juan Batiz-Benet to fit GHUnit
# Modified by Gabriel Handford for GHUnit

set -e

LAUNCH_DIR=$PWD

# Define these to suit your nefarious purposes
                 FRAMEWORK_NAME=CITestModel
               LIB_PROJECT_NALE=CITest-Model-Universal
                       LIB_NAME=libCITest_Model_Universal.a
              FRAMEWORK_VERSION=A

BUILD_TYPE=$1
if [ -z "$BUILD_TYPE" ] 
then
    BUILD_TYPE=Release
fi

# Where we'll put the build framework.
# The script presumes we're in the project root
# directory. Xcode builds in "build" by default
cd ../frameworks
    FRAMEWORK_BUILD_PATH=$PWD
cd "$LAUNCH_DIR"    


# This is the full name of the framework we'll
# build
FRAMEWORK_DIR=$FRAMEWORK_BUILD_PATH/$FRAMEWORK_NAME.framework
rm -rf "$FRAMEWORK_DIR"

# Build the canonical Framework bundle directory
# structure
echo "Framework: Setting up directories..."
mkdir -p $FRAMEWORK_DIR
mkdir -p $FRAMEWORK_DIR/Versions
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION/Resources
mkdir -p $FRAMEWORK_DIR/Versions/$FRAMEWORK_VERSION/Headers

echo "Framework: Creating symlinks..."
ln -s $FRAMEWORK_VERSION $FRAMEWORK_DIR/Versions/Current
ln -s Versions/Current/Headers $FRAMEWORK_DIR/Headers
ln -s Versions/Current/Resources $FRAMEWORK_DIR/Resources
ln -s Versions/Current/$FRAMEWORK_NAME $FRAMEWORK_DIR/$FRAMEWORK_NAME



# The trick for creating a fully usable library is
# to use lipo to glue the different library
# versions together into one file. When an
# application is linked to this library, the
# linker will extract the appropriate platform
# version and use that.
# The library file is given the same name as the
# framework with no .a extension.
UNIVERSAL_LIBRARY_DIR=$FRAMEWORK_BUILD_PATH/$LIB_PROJECT_NALE
UNIVERSAL_LIBRARY_FULL_PATH=$UNIVERSAL_LIBRARY_DIR/Lib/$LIB_NAME
UNIVERSAL_LIBRARY_HEADERS_PATH=$UNIVERSAL_LIBRARY_DIR/include/$LIB_PROJECT_NALE
UNIVERSAL_LIBRARY_PLIST_FULL_PATH=$UNIVERSAL_LIBRARY_DIR/Framework.plist



# Now copy the final assets over: your library
# header files and the plist file
echo "Framework: Copying assets into current version..."

cp "$UNIVERSAL_LIBRARY_PLIST_FULL_PATH" "$FRAMEWORK_DIR/Resources/Info.plist"

cd "$UNIVERSAL_LIBRARY_HEADERS_PATH"
    cp -R *.h "$FRAMEWORK_DIR/Headers/"
cd "$LAUNCH_DIR"

cp "$UNIVERSAL_LIBRARY_FULL_PATH" "$FRAMEWORK_DIR/Versions/Current/$FRAMEWORK_NAME"




echo ""
echo "The framework was built at: $FRAMEWORK_DIR"
echo ""

#open "$FRAMEWORK_BUILD_PATH"
