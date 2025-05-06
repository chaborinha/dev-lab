document.querySelector('#btn').addEventListener('click', () => {

    const req = new XMLHttpRequest();
    req.open('GET', 'http://localhost/recursos_online/api/v1/get_all_comments/', false);
    req.send();

    if (req.status !== 200) {
        document.querySelector('#error').classList.remove('d-none');
    } else {

        let dados = JSON.parse(req.response);

        if (dados.message === 'error') {
            document.querySelector('#error').classList.remove('d-none');
        } else {
            let chat = document.querySelector('#chat');
            chat.innerHTML = null;

            dados.results.forEach(post => {
                // new post
                let new_post = document.createElement('div');
                new_post.classList.add('col-12', 'card', 'bg-ligh', 'p-2', 'mb-3');

                let html = '';
                html += '<div class="row">';

                html += '<div class="col-6">';
                html += `<p><strong>${post.username}</strong></p>`;
                html += '</div>';

                html += '<div class="col-6">';
                html += `<p><strong>${post.created_at}</strong></p>`;
                html += '</div>';

                html += '<div class="row"><div class="col-12">';
                html += '<hr class="p-0 m-0 mb-2">';
                html += `<p class="ps-5">${post.comment}</p>`;
                html += '</div></div>';

                html += '</div>';

                new_post.innerHTML = html;

                chat.appendChild(new_post);
            });
        }

    }

});