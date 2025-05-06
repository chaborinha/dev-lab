<?php

// add new client

require_once('../_inc/init.php');

// get JSON data
$data = json_decode(file_get_contents("php://input"), true);

// check if request method is valid
check_request_method($request_method, 'POST');

// check for required fields
$required_fields = ['nome', 'sexo', 'data_nascimento', 'email', 'telefone', 'morada', 'cidade', 'ativo'];
if(!check_required_fields_in_json($data, $required_fields)){
    $res->set_status('error');
    $res->set_error_message('Missing fields.');
    check_integration_key_json($data);
    $res->response();
}

// integration key
check_integration_key_json($data);

// check if there is already another client with the same name
$params = [
    'nome' => $data['nome']
];
$results = $db->execute_query("SELECT id from clientes WHERE nome = :nome", $params);
if($results->affected_rows != 0){
    $res->set_status('error');
    $res->set_error_message('There is another client with the same name.');
    $res->response();
}

// params
$params = [
    'nome' => $data['nome'],
    'sexo' => $data['sexo'],
    'data_nascimento' => $data['data_nascimento'],
    'email' => $data['email'],
    'telefone' => $data['telefone'],
    'morada' => $data['morada'],
    'cidade' => $data['cidade'],
    'ativo' => $data['ativo']
];

$db->execute_non_query(
    "INSERT INTO clientes VALUES(" . 
    "0, " . 
    ":nome, " . 
    ":sexo, " . 
    ":data_nascimento, " . 
    ":email, " . 
    ":telefone, " . 
    ":morada, " . 
    ":cidade, " . 
    ":ativo)"
    , $params
);

$res->response();
