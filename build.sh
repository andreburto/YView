#!/bin/bash
cd $(dirname $0)

APP_NAME="YViewApp.war"
BASE_DIR=$(pwd)
TOMCAT_PATH="$HOME/bin/apache-tomcat-8.5.84/"
YWIDGET_FILE="YWidget.jar"
YWIDGET_PATH="ywidget"
YWIDGET_REPO="https://github.com/andreburto/YWidget.git"

# Clean up previous builds.
rm $BASE_DIR/$APP_NAME || echo "No such file."
find . -name *.class | xargs -I {} rm -f {}
find . -name *.jar | xargs -I {} rm -f {}

# Ensure the needed directories exist.
mkdir -p WebContent/WEB-INF/classes/
mkdir -p WebContent/WEB-INF/lib/

# Download and build the YWidget.jar file.
git clone $YWIDGET_REPO $YWIDGET_PATH
$BASE_DIR/$YWIDGET_PATH/build.sh
cp $BASE_DIR/$YWIDGET_PATH/$YWIDGET_FILE WebContent/WEB-INF/lib/
rm -Rf $BASE_DIR/$YWIDGET_PATH

# Compile the Java files.
javac -cp $TOMCAT_PATH/lib/servlet-api.jar:WebContent/WEB-INF/lib/$YWIDGET_FILE -d WebContent/WEB-INF/classes src/xyz/yvonneshow/yview/*.java

# Build the WAR file.
jar cfv $BASE_DIR/$APP_NAME -C WebContent .

# Desploy the WAR file to the local Tomcat path.
cp $BASE_DIR/$APP_NAME $TOMCAT_PATH/webapps/
