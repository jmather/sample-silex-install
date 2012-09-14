<?php
require_once dirname(__FILE__).'/../vendor/autoload.php';

$app = new \Silex\Application();

require dirname(__FILE__).'/../config/config.php';

$app->register(new Silex\Provider\MonologServiceProvider(), array(
    'monolog.logfile' => __DIR__.'/../log/system.log',
));

$app->mount('/', new \Acme\DemoController());

$app->run();
