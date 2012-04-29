<?php

require 'bootstrap.php';
echo "Connection ";
print_r($entityManager->getConnection(0)->getParams());


?>