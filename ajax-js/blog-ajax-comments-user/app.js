window.onload = () => {
    // buscar os dados dos users
    fetch('http://localhost/recursos_online/api/v1/get_all_users')
        .then(response => {
            if (response.status === 200) {
                return response.json();
            } else {
                throw Error('Recurso indisponivel');
            }
        })
        .then(dados => {
            if (dados.status == 'success') {
                let select_users = document.querySelector('#select_users');
                dados.results.forEach(user => {
                    let option = document.createElement('option');
                    option.value = user.id;
                    option.textContent = user.username;
                    select_users.appendChild(option);
                });
            } else {
                throw Error('erro');
            }
        })
        .catch(err => {
            console.log('erro');
        })

    // adicionar evento change ao select
    select_users.addEventListener('change', () => {

        let id = select_users.value;

        if (id !== 0) {
            fetch('http://localhost/recursos_online/api/v1/get_all_comments_from_user/?id=' + id)
                .then(response => {
                    if (response.status === 200) {
                        return response.json();
                    } else {
                        throw Error('Recurso indisponivel');
                    }
                })
                .then(data => {
                    let posts = data.results;
                    let users_posts = document.querySelector('#user_posts');
                    let no_posts = document.querySelector('#no_posts');
                    users_posts.innerHTML = null;

                    if (posts.length == 0) {
                        users_posts.classList.add('d-none');
                        no_posts.classList.remove('d-none');
                    } else {
                        posts.forEach(post => {
                            let html = '<div class="row border rounded py-2 bg-light my-3">';
                            html += `<div class"col-6"><strong>@${post.username}</strong></div>`;
                            html += `<div class"col-6"><strong>${post.created_at}</strong></div>`;
                            html += `<div class"col">${post.comment}</div>`;
                            html += '</div>';

                            let post_div = document.createElement('div');
                            post_div.innerHTML = html;
                            users_posts.appendChild(post_div);
                        })

                        // adicionar total de posts
                        let total_info = document.createElement('div');
                        total_info.classList.add('text-end');
                        total_info.classList.add('mt-3');
                        total_info.innerHTML = `N.º de posts: <strong>${posts.length}</strong>`;
                        users_posts.appendChild(total_info);

                        users_posts.classList.remove("d-none");
                        no_posts.classList.add('d-none');
                    }
                })
                .catch(() => {
                    console.log('erro');
                })
        } 
    })
}