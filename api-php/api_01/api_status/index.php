<?php

// return the current status of the API

require_once('../_inc/init.php');

// integration keys
check_integration_key_get();

$res->set_status('success');
$res->response();