#!/bin/bash
cd $(dirname $0)

APP_NAME="YViewApp.war"
BASE_DIR=$(pwd)
TOMCAT_VERSION=8.5.84
TOMCAT_PATH="/usr/local/tomcat"
YWIDGET_FILE="YWidget.jar"
YWIDGET_PATH="ywidget"
YWIDGET_REPO="https://github.com/andreburto/YWidget.git"

# Download and build the YWidget.jar file.
rm -Rf $BASE_DIR/$YWIDGET_PATH || echo "No such path."
git clone $YWIDGET_REPO $YWIDGET_PATH

# Clean up previous builds.
rm $BASE_DIR/$APP_NAME || echo "No such file."
find . -name *.class | xargs -I {} rm -f {}
find . -name *.jar | xargs -I {} rm -f {}
find . -name .git | xargs -I {} rm -Rf {}

# Ensure the needed directories exist.
mkdir -p WebContent/WEB-INF/classes/
mkdir -p WebContent/WEB-INF/lib/

# Build the YWidget jar
cd $BASE_DIR/$YWIDGET_PATH
find . -name *.java | xargs -I {} javac -verbose {}
jar -cf $BASE_DIR/$YWIDGET_PATH/$YWIDGET_FILE .
cd $BASE_DIR
cp $BASE_DIR/$YWIDGET_PATH/$YWIDGET_FILE WebContent/WEB-INF/lib/
rm -Rf $BASE_DIR/$YWIDGET_PATH

# Compile the Java files.
javac -cp $TOMCAT_PATH/lib/servlet-api.jar:WebContent/WEB-INF/lib/$YWIDGET_FILE -d WebContent/WEB-INF/classes src/xyz/yvonneshow/yview/*.java

# Build the WAR file.
jar cfv $BASE_DIR/$APP_NAME -C WebContent .

# Desploy the WAR file to the local Tomcat path.
cp $BASE_DIR/$APP_NAME $TOMCAT_PATH/webapps/
