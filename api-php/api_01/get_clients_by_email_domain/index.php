<?php

// return a client by domain

require_once ('../_inc/init.php');

// check if request method is valid
check_request_method($request_method, 'GET');

// integration key
check_integration_key_get();

// check if the requested id is present
if (!isset($_GET['domain']))
{
    missing_request_parameter('domain');
}

$params = [
    ':domain' => '%@' . $_GET['domain'] . '%'
];
$results = $db->execute_query("SELECT * FROM clientes WHERE email LIKE :domain", $params);

$res->set_status('success');
$res->set_response_data($results->results);

// aditional fields
$res->set_aditional_field('total_clients', $results->affected_rows);

$res->response();