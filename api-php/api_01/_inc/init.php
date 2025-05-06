<?php

// defines the content response header as json
header("Content-Type: application/json; charset=UTF-8");

require_once('config.php');
require_once('Database.php');
require_once('Response.php');
require_once('Helper.php');

// set api timezone
date_default_timezone_set('America/Sao_Paulo');

// prepare any response
$res = new Response();

// check if API is enabled or in maintenance
if (!API_ACTIVE)
{
    $res->set_status('error');
    $res->set_error_message(API_MESSAGE);
    $res->response();
}

// get request method (http verb)
$request_method = $_SERVER['REQUEST_METHOD'];

// check for HTTP Basic Auth credentials
if (!isset($_SERVER['PHP_AUTH_USER']))
{
    $res->set_status('error');
    $res->set_error_message('Missing authentication credentials.');
    $res->response();
}

// set mysql config
$mysql_config = [
    'host' => MYSQL_HOST,
    'database' => MYSQL_DATABASE,
    'username' => MYSQL_USER,
    'password' => MYSQL_PASS
];

// create database object
$db = new Database($mysql_config);

// check if request has valid credentials
$username = $_SERVER['PHP_AUTH_USER'];
$password = $_SERVER['PHP_AUTH_PW'];
$params = [
    ':username' => $username
];
$results = $db->execute_query("SELECT * FROM users WHERE username = :username", $params);
if ($results->affected_rows == 0)
{
    $res->set_status('error');
    $res->set_error_message('Invalid credentials.');
    $res->response();
}

if (!password_verify($password, $results->results[0]->passwrd))
{
    $res->set_status('error');
    $res->set_error_message('Invalid credentials.');
    $res->response();
}
