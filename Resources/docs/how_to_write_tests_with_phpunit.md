How to write Selenium tests with PHPUnit
========================================

If your project is written in PHP, you probably use PHPUnit for testing.
It would be nice to be able to write functional tests in PHP too.

For one because you use same language for application and for testing,
you can combine code coverage from unit tests and functional tests,
and you can use same resources to get test data (e.g. same model to access DB)
as your application.

There are many bindings you can use, but we chose PHPUnit_Selenium extension.
Nice thig here is, that if Hub is down for some reason, the tests are skipped.
A simple example of such test:

``` php
<?php

/**
 * @group functional
 */
class DemoSeleniumTest extends \PHPUnit_Extensions_Selenium2TestCase
{
    /**
     * @var array;
     */
    public static $browsers = [
        ['browserName' => 'firefox', 'port' => 4444, 'host' => 'localhost'],
        ['browserName' => 'chrome', 'port' => 4444, 'host' => 'localhost'],
        ['browserName' => 'opera', 'port' => 4444, 'host' => 'localhost'],
    ];

    protected function setUp()
    {
        parent::setUp();

        $this->setBrowserUrl('http://www.example.com/');
    }

    public function testTitle()
    {
        $this->url('http://www.example.com/');
        $this->assertEquals('Example WWW Page', $this->title());
    }
}

```

As you can see, there is only one simple test verifing the page title.
This test is run for each browser, so some test paraleliztionis recomended.

It's good idea to assign Selenium tests to group (in this case `functional`).
That allows you to run only functional tests with `phpunit <other_options> --group functional`,
or exclude them from testing.

For more information on PHPUnit and Selenium see http://www.phpunit.de/manual/current/en/selenium.html.
