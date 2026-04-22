const loginDropdown = document.querySelector('.login-dropdown');

if (loginDropdown) {
    document.addEventListener('click', (event) => {
        if (!loginDropdown.open) return;
        if (loginDropdown.contains(event.target)) return;
        loginDropdown.open = false;
    });

    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            loginDropdown.open = false;
        }
    });
}

const contenedor = document.querySelector('#contenedor-juegos');

async function cargarJuegos() {
    const response = await fetch('/api/juegos');
    const juegos = await response.json();

    contenedor.innerHTML = '';

    juegos.forEach((juego) => {
        contenedor.innerHTML += `<article class="game-card">
                                <a class="game-card-link" href="juego.html?id=${juego.id}">
                                    <div class="game-card-media">
                                        <img src="${juego.image}" alt="${juego.name}">
                                    </div>

                                    <div class="game-card-body">
                                        <div class="game-card-head">
                                            <h4>${juego.name}</h4>
                                        </div>

                                        <p class="game-card-meta">${juego.genre}</p>
                                        <p class="game-card-text">${juego.description}</p>

                                        <div class="game-card-tags">
                                            <span>${juego.platform}</span>
                                        </div>
                                    </div>
                                </a>
                            </article>`
    });
}

cargarJuegos();





