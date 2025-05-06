window.onload = () => {

    fetch('http://localhost/recursos_online/api/v1/get_all_users')
        .then(response => {
            if (response.status === 200) {
                return response.json();
            } else {
                throw Error('Recurso indisponivel');
            }
        })
        .then(dados => {

            if (dados.status === 'success') {

                if (dados.affected_rows === 0) {
                    document.querySelector('.error.opacity-75').textContent = 'Não existem users para serem apresentados';
                    document.querySelector('#table_users').classList.add('d-none');
                } else {

                    let html = '';
                    dados.results.forEach(user => {
                        html += '<tr>';
                        html += `<td>${user.username}</td>`;
                        html += `<td>${user.email}</td>`;
                        html += `<td>${user.created_at}</td>`;
                        html += `<td><span class="detalhes" onclick="view_details(${user.id})">Detalhes</span></td>`;
                        html += '</tr>';
                    });

                    // coloca os dados na tabela
                    let e = document.querySelector('#table_users table tbody').innerHTML = html;

                    document.querySelector('.error.opacity-75').textContent = '';
                    document.querySelector('#table_users').classList.remove('d-none');

                }
            } else {
                throw Error('não foi possivel carregar dados dos utilizadores.');
            }
        })
}

function view_details(id) {

    fetch('http://localhost/recursos_online/api/v1/get_user_details/?id=' + id)
        .then(response => {
            if (response.status === 200) {
                return response.json();
            } else {
                throw Error('Não foi possivel encontrar o utilizador');
            }
        })
        .then(user => {
            document.querySelector("#detail_username").textContent = user.username;
            document.querySelector("#detail_email").textContent = user.email;
            document.querySelector("#detail_created_at").textContent = user.created_at;
            document.querySelector("#user_details").classList.remove('d-none');
        })

}