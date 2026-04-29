const loginDropdown = document.querySelector('.login-dropdown');
const loginForm = document.querySelector('#login-form');
const inputUsuario = document.querySelector('#usuario');
const inputPassword = document.querySelector('#password');
const loginMsg = document.querySelector('#login-msg');
const zonaPrivada = document.querySelector('#zona-privada');
const inputBusqueda = document.querySelector('#buscador');
const selectorOrden = document.querySelector('#orden-juegos');

document.addEventListener('click', (e) => {
    if (loginDropdown?.open && !loginDropdown.contains(e.target)) loginDropdown.open = false;
});
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') loginDropdown.open = false;
});

const contenedor = document.querySelector('#contenedor-juegos');
const botonesFiltro = document.querySelectorAll('.btn-filtro');
let generoActual = 'todos';

function pintarJuegos(juegos) {
    contenedor.innerHTML = '';

    if (!juegos.length) {
        contenedor.innerHTML = '<p>No se han encontrado juegos.</p>';
        return;
    }

    const isAdmin = sessionStorage.getItem('admin') === 'true';

  juegos.forEach((juego) => {
    const btnBorrar = isAdmin ? `<button class="btn-borrar" data-id="${juego.id}">X</button>` : '';
    const valoracionHtml = juego.valoration ? `<span class="game-card-rating">${juego.valoration}</span>` : '';
    contenedor.innerHTML += `
    <article class="game-card">
      <a class="game-card-link" href="juego.html?id=${juego.id}">
        <div class="game-card-media">
          <img src="${juego.image}" alt="${juego.name}">
          ${valoracionHtml}
        </div>

        <div class="game-card-body">
          <div class="game-card-head">
            <h4>${juego.name}</h4>
            ${btnBorrar}
          </div>

          <p class="game-card-meta">${juego.genre}</p>
          <p class="game-card-text">${juego.description}</p>

          <div class="game-card-tags">
            <span>${juego.plataform || ''}</span>
          </div>
        </div>
      </a>
    </article>`;
  });
}

contenedor.addEventListener('click', async (e) => {
    if (e.target.classList.contains('btn-borrar')) {
        const id = e.target.dataset.id;
        if (confirm('Borrar este juego?')) {
            const res = await fetch('/api/juegos/' + id, { method: 'DELETE' });
            const data = await res.json();
            if (data.success) cargarJuegos();
        }
    }
});

//Cargar todos los juegos, el orden, generos, busqueda
async function cargarJuegos() {
    const termino = inputBusqueda.value.trim();
    const orden = selectorOrden.value.trim() || 'nombre';
    let url = '/api/juegos?orden=' + encodeURIComponent(orden);

    if (termino !== '') {
        url = '/api/buscar?q=' + encodeURIComponent(termino) + '&genero=' + encodeURIComponent(generoActual);
    } else if (generoActual !== 'todos') {
        url = '/api/juegos/genero/' + encodeURIComponent(generoActual) + '?orden=' + encodeURIComponent(orden);
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

if (inputBusqueda) {
    inputBusqueda.addEventListener('input', () => {
        cargarJuegos();
    });
}

if (selectorOrden) {
    selectorOrden.addEventListener('change', cargarJuegos);
}

if (loginForm) {
    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const usuario = inputUsuario.value.trim();
        const password = inputPassword.value;

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
            zonaPrivada.classList.toggle('oculto', false);
            loginMsg.textContent = 'Sesion iniciada como admin';
            loginForm.reset();
            cargarJuegos();
        } else {
            sessionStorage.removeItem('admin');
            zonaPrivada.classList.toggle('oculto', true);
            loginMsg.textContent = data.error || 'Error al iniciar sesion';
            cargarJuegos();
        }
    });
}

zonaPrivada.classList.toggle('oculto', sessionStorage.getItem('admin') !== 'true');
cargarJuegos();

// Modal insertar
const modalInsertar = document.querySelector('#form-add-juego');
const btnAdmin = document.querySelector('#btn-admin');
const btnCerrarModal = document.querySelector('#btn-cerrar-modal');

btnAdmin?.addEventListener('click', () => modalInsertar.classList.toggle('oculto', false));
btnCerrarModal?.addEventListener('click', () => {
    modalInsertar.classList.toggle('oculto', true);
    document.querySelector('#insert-form').reset();
});

document.querySelector('#insert-form')?.addEventListener('submit', async (e) => {
    e.preventDefault();

    const get = (id) => document.querySelector(id).value.trim();
    const juego = {
        name: get('#juego-nombre'),
        description: get('#juego-descripcion'),
        image: get('#juego-imagen'),
        genero: get('#juego-genero'),
        developer: get('#juego-developer'),
        release_date: document.querySelector('#juego-fecha').value,
        price: parseFloat(document.querySelector('#juego-precio').value) || null,
        duration: parseInt(document.querySelector('#juego-duracion').value) || null,
        valoration: parseInt(document.querySelector('#juego-valoracion').value) || null,
    };

    const res = await fetch('/api/insert', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(juego),
    });

    const data = await res.json();
    alert(data.success ? 'Juego anadido' : 'Error: ' + (data.error || ''));

    if (data.success) {
        modalInsertar.classList.toggle('oculto', true);
        document.querySelector('#insert-form').reset();
        cargarJuegos();
    }
});