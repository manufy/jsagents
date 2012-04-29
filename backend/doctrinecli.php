<?php

require 'bootstrap.php';
/*
$APPLICATION_ENV = "development";

// Composer Autoload (1)
require 'vendor/.composer/autoload.php';

$config = new Doctrine\ORM\Configuration();
// Configurar (2)

$config = new Doctrine\ORM\Configuration();

// Proxy Configuration (3)
$config->setProxyDir(__DIR__.'/proxies');
$config->setProxyNamespace('entities\proxies');
$config->setAutoGenerateProxyClasses(($APPLICATION_ENV == "development"));

// Mapping Configuration (4)
//$driverImpl = new Doctrine\ORM\Mapping\Driver\XmlDriver(__DIR__."/config/mappings/xml");
//$driverImpl = new Doctrine\ORM\Mapping\Driver\YamlDriver(__DIR__."/Models");
$driverImpl = $config->newDefaultAnnotationDriver(__DIR__."/entities");
$config->setMetadataDriverImpl($driverImpl);

// Caching Configuration (5)
if ($APPLICATION_ENV == "development") {
    $cache = new \Doctrine\Common\Cache\ArrayCache();
} else {
    $cache = new \Doctrine\Common\Cache\ApcCache();
}
$config->setMetadataCacheImpl($cache);
$config->setQueryCacheImpl($cache);

// database configuration parameters (6)
$conn = array(
    'driver' => 'pdo_sqlite',
    'path' => __DIR__ . '/database.sqlite',
);

// obtaining the entity manager (7)
$evm = new Doctrine\Common\EventManager();
$entityManager = \Doctrine\ORM\EntityManager::create($conn, $config, $evm);

*/

$helperSet = new \Symfony\Component\Console\Helper\HelperSet(array(
 'db' => new \Doctrine\DBAL\Tools\Console\Helper\ConnectionHelper($entityManager->getConnection()),
 'em' => new \Doctrine\ORM\Tools\Console\Helper\EntityManagerHelper($entityManager)
));
\Doctrine\ORM\Tools\Console\ConsoleRunner::run($helperSet);
?>