Getting started with Selenium Grid
==================================

(Selenium)[http://seleniumhq.org/] automates browsers.
Primarily it is for automating web applications for testing purposes, but is certainly not limited to just that.

Selenium Grid allows you to run your tests against various predefined environments and browsers in parallel.
It allows you to distribute tests on multiple machines and in as a result dramatically speeds up in-browser web testing.

This project will help you to quickly and easily set up Selenium Grid so you can concentrate on writing test, not on configuration.

Installation
============

You can install everything in one simple step:

``` sh
curl https://raw.github.com/Publero/selenium-grid/master/install.sh | sudo sh
```

How to use Selenium Grid
========================

Selenium Grid consists of 2 parts: Selenium Server and WebDriver(s).

**Selenium Server** provides API to controll the browsers and runs two modes: hub mode and node mode.
To make simple we provided services for both modes.

Selenium server in hub mode (I will reffer to it as the Hub) is what your test framework will connect to
(usually thru some language binding - there are many available).
To start it run:

``` sh
sudo service selenium-server-hub start
```

Selenium server in node mode (I will reffer to them as a Node) uses one of multiple WebDrivers to control browsers.
There can be multiple Nodes associated with single Hub. That's how you can distribute testing to multiple machines.
We however set up a Node on the same machine as the Hub and configured it to support Google Chrome, Firefox, and Opera,
up to 3 paralell instances of each. You can start it by running:
``` sh
sudo service selenium-server-node start
```

**Note: You don't need a desktop environment to use Selenium Grid. Node uses virtual screen instead.**
