document.querySelector("#btn").addEventListener('click', () => {

    const req = new XMLHttpRequest();

    // sincrona
    req.open('GET', "http://localhost/recursos_online/api/v1/get_all_users", false)
    req.send();

    //console.log(req.response);

    // pegar os dados e passar para objeto de JS
    if (req.status === 200) {
        let dados = JSON.parse(req.response);
        if (dados.message == 'error') {
            document.querySelector("#error").classList.remove("d-none");
        } else {
            let table_users = document.querySelector("#table_users");
            table_users.innerHTML = null;
            dados.results.forEach(user => {
                let tr = document.createElement('tr');
                let html = `<td>${user.username}</td>`;
                html += `<td>${user.email}</td>`;
                html += `<td>${user.created_at}</td>`;
                tr.innerHTML = html;
                table_users.appendChild(tr);
            })
            document.querySelector("#tabela").classList.remove("d-none");
        }
    } else {
        document.querySelector("#error").classList.remove("d-none");
    }


})