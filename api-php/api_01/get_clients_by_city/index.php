<?php

// return a client by city

require_once ('../_inc/init.php');

// check if request method is valid
check_request_method($request_method, 'GET');

// integration key
check_integration_key_get();

// check if the requested id is present
if (!isset($_GET['city']))
{
    missing_request_parameter('city');
}

$params = [
    ':city' => $_GET['city']
];
$results = $db->execute_query("SELECT * FROM clientes WHERE cidade = :city", $params);

$res->set_status('success');
$res->set_response_data($results->results);

// aditional fields
$res->set_aditional_field('total_clients', $results->affected_rows);

$res->response();