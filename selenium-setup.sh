#!/bin/sh

basedir=$(dirname $0)

if [ `id -u` -ne '0' ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

SELENIUM_DIR="/usr/share/selenium"
STANDALONE_VERSION="2.32.0"
STANDALONE_URL="http://selenium.googlecode.com/files/selenium-server-standalone-${STANDALONE_VERSION}.jar"
ARCH=$(uname -i)
if [ "$ARCH" == "x86_64" ]; then ARCH="64"; else ARCH="32"; fi
CHROME_DRIVER_VERSION="0.9"
CHROME_DRIVER_URL="http://chromedriver.googlecode.com/files/chromedriver2_linux${ARCH}_${CHROME_DRIVER_VERSION}.zip"

echo "Setting up Selenium"

# Add Opera repository
command -v opera >/dev/null 2>&1 || {
  echo "Opera is not installed - adding repository"
  wget -q -O - http://deb.opera.com/archive.key | sudo apt-key add -
  echo "deb http://deb.opera.com/opera/ stable non-free" >>/etc/apt/sources.list.d/opera.list
}

# Add Google Chrome repository
command -v google-chrome >/dev/null 2>&1 || {
  echo "Google Chrome is not installed - adding repository"
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
}

apt-get update
command -v java >/dev/null 2>&1 || {
  echo "no JRE - installing now" >&2
  apt-get -y install openjdk-7-jre icedtea-7-plugin
}
apt-get -y install xvfb\
  x11-xkb-utils\
  xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic\
  xserver-xorg-core\
  unzip\
  x11vnc

# Install Selenium Standalone Server
if [ ! -d "$SELENIUM_DIR" ]; then
  mkdir "$SELENIUM_DIR"
fi
wget -O "$SELENIUM_DIR/selenium-server-standalone.jar" "$STANDALONE_URL"

# Create configuration
if [ ! -d /etc/selenium ]; then
  mkdir /etc/selenium
fi
cp $basedir/config/* /etc/selenium/

# Install services
cp $basedir/services/* /etc/init.d/

# Install Chrome, Firefox & Opera
apt-get -y install google-chrome-stable firefox opera

# Install Google Chrome WebDriver
if [ ! -d "$SELENIUM_DIR/driver" ]; then
  mkdir "$SELENIUM_DIR/driver"
fi
wget -O "$SELENIUM_DIR/driver/chromedriver.zip" "$CHROME_DRIVER_URL"
unzip "$SELENIUM_DIR/driver/chromedriver.zip" -d "$SELENIUM_DIR/driver"
rm "$SELENIUM_DIR/driver/chromedriver.zip"
