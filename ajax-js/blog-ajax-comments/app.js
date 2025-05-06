document.querySelector('#btn').addEventListener('click', () => {

    fetch('http://localhost/recursos_online/api/v1/get_all_comments/')
    .then(response => {
        if (response.status === 200) {
            return response.json();
        } else{
            throw Error('dados indisponiveis');
        }
    })
    .then(response => {
        
        let chat = document.querySelector('#chat');
        chat.innerHTML = null;

        response.results.forEach(post => {
            // new post
            let new_post = document.createElement('div');
            new_post.classList.add('col-12','card','bg-ligh','p-2','mb-3');

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

            let new_post_author = document.createElement('p');
            new_post_author.textContent = post.username;
            chat.appendChild(new_post);
        });

    })
    .catch(() => {
        document.querySelector('#error').classList.remove('d-none');
    })

});