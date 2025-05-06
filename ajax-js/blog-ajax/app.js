document.querySelector("#btn").addEventListener('click', () => {

    fetch('http://localhost/recursos_online/api/v1/get_all_users')
        .then(response => {
            if (response.status === 200) {
                return response.json();
            } else {
                throw Error('dados indisponiveis');
            }
        })
        .then(dados => {
            let users = dados.results;
            let table_users = document.querySelector("#table_users");

            table_users.innerHTML = null

            users.forEach(user => {
                let tr = document.createElement('tr');
                let html = `<td>${user.username}</td>`;
                html += `<td>${user.email}</td>`;
                html += `<td>${user.created_at}</td>`;
                tr.innerHTML = html;
                table_users.appendChild(tr);
            });
            document.querySelector("#tabela").classList.remove("d-none");
        })
        .catch(() => {
            document.querySelector("#error").classList.remove("d-none");
        })

})