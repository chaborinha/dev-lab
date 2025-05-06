<?php

require_once('../_inc/init.php');

// check if request method is valid
check_request_method($request_method, 'GET');

// integration key
check_integration_key_get();

// check if the requested id is present
$results = $db->execute_query(
    "SELECT 'Homens' sexo, COUNT(*) total FROM clientes WHERE sexo = 'm' " . 
    "UNION " . 
    "SELECT 'Mulheres' sexo, COUNT(*) total FROM clientes WHERE sexo = 'f'"
);

$res->set_status('success');
$res->set_response_data($results->results);

$res->response();