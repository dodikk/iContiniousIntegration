#
# /bin/bash
#
######################

LAUNCH_DIR=$PWD

cd ../
    PROJECT_ROOT=$PWD
cd "$LAUNCH_DIR"


cd "../tools"
   TOOLS_DIR=$PWD
cd "$LAUNCH_DIR"

mkdir -p ../deployment
cd "../deployment"
   DEPLOYMENT_DIR=$PWD
cd "$LAUNCH_DIR"

######################
/bin/bash "$PWD/CleanTestReports.sh"

"$TOOLS_DIR/iphonesim" launch "$DEPLOYMENT_DIR/CITest.app" 4.2 ipad

/bin/bash "$PWD/CopyTestReports.sh"
/bin/bash "$PWD/KillSimulator.sh"

