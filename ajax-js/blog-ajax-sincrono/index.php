<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajax</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
    
    <div class="container mt-5">

        <!-- main -->
        <div class="row mb-3">
            <div class="col-12 text-center">
                <h3>Carregar todos os dados dos users</h3>
                <button class="btn btn-primary" id="btn">Carregar</button>
            </div>
        </div>

        <!-- table -->
        <div class="row d-none" id="tabela">
            <div class="col-12">
                <table class="table table-striped">
                    <thead class="table-dark">
                        <th>Username</th>
                        <th>Email</th>
                        <th>Criado em</th>
                    </thead>
                    <tbody id="table_users"></tbody>
                </table>
            </div>
        </div>

        <!-- error -->
        <p class="text-danger p-1 text-center d-none" id="error">Não foram encontrados registos.</p>

    </div>

    <script src="app.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>