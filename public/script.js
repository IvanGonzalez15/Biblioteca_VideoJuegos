const loginDropdown = document.querySelector('.login-dropdown');
const loginForm = document.querySelector('#login-form');
const inputUsuario = document.querySelector('#usuario');
const inputPassword = document.querySelector('#password');
const loginMsg = document.querySelector('#login-msg');
const zonaPrivada = document.querySelector('#zona-privada');
const formularioBusqueda = document.querySelector('.searchbar');
const inputBusqueda = document.querySelector('#buscador');
const selectorOrden = document.querySelector('#orden-juegos');

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
const botonesFiltro = document.querySelectorAll('.btn-filtro');
let generoActual = 'todos';
let debounceBusqueda;

function actualizarZonaPrivada(esAdmin) {
    if (!zonaPrivada) return;

    zonaPrivada.classList.toggle('oculto', !esAdmin);
}

function pintarJuegos(juegos) {
    contenedor.innerHTML = '';

    if (!juegos.length) {
        contenedor.innerHTML = '<p>No se han encontrado juegos.</p>';
        return;
    }

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
                            </article>`;
    });
}

async function cargarJuegos() {
    const termino = inputBusqueda?.value.trim() || '';
    const orden = selectorOrden?.value || 'nombre';
    let url = `/api/juegos?orden=${encodeURIComponent(orden)}`;

    if (termino !== '') {
        url = `/api/buscar?q=${encodeURIComponent(termino)}&genero=${encodeURIComponent(generoActual)}&orden=${encodeURIComponent(orden)}`;
    } else if (generoActual !== 'todos') {
        url = `/api/juegos/genero/${encodeURIComponent(generoActual)}?orden=${encodeURIComponent(orden)}`;
    }

    try {
        const response = await fetch(url);
        const juegos = await response.json();
        pintarJuegos(juegos);
    } catch (err) {
        console.error('Error cargando juegos:', err);
    }
}

botonesFiltro.forEach((boton) => {
    boton.addEventListener('click', () => {
        botonesFiltro.forEach((b) => b.classList.remove('active'));
        boton.classList.add('active');

        generoActual = boton.dataset.cat;
        cargarJuegos();
    });
});

if (formularioBusqueda) {
    formularioBusqueda.addEventListener('submit', (event) => {
        event.preventDefault();
        cargarJuegos();
    });
}

if (inputBusqueda) {
    inputBusqueda.addEventListener('input', () => {
        clearTimeout(debounceBusqueda);
        debounceBusqueda = setTimeout(() => {
            cargarJuegos();
        }, 250);
    });
}

if (selectorOrden) {
    selectorOrden.addEventListener('change', cargarJuegos);
}

if (loginForm) {
    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const usuario = inputUsuario?.value.trim() || '';
        const password = inputPassword?.value || '';


        const response = await fetch('/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ usuario, password }),
        });

        const data = await response.json();

        if (data.success) {
            sessionStorage.setItem('admin', 'true');
            actualizarZonaPrivada(true);
            loginMsg.textContent = 'Sesion iniciada como admin';
            loginForm.reset();
            return;
        }

        sessionStorage.removeItem('admin');
        actualizarZonaPrivada(false);
        loginMsg.textContent = data.error || 'Error al iniciar sesion';
    });
}

actualizarZonaPrivada(sessionStorage.getItem('admin') === 'true');

cargarJuegos();
