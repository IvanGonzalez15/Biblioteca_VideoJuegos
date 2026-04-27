const params = new URLSearchParams(window.location.search);
const id = params.get('id');

async function cargarJuego() {
	if (!id) {
		document.querySelector('#juego-titulo').textContent = 'ID no válido';
		return;
	}

	const response = await fetch(`/api/juegos/${id}`);

	const juego = await response.json();

	document.querySelector('#juego-titulo').textContent = juego.name;
	document.querySelector('#juego-descripcion-corta').textContent = juego.description;
	document.querySelector('#juego-portada').src = juego.image;
	document.querySelector('#juego-portada').alt = juego.name;

	document.querySelector('#juego-tags').innerHTML = `
		<span class="tag">${juego.genero}</span>
		<span class="tag">${juego.plataforma}</span>
		<span class="tag">${juego.anio}</span>`;

	document.querySelector('#juego-meta').innerHTML = `
		<div class="meta-item">
			<span class="meta-label">Lanzamiento</span>
			<strong>${juego.fecha}</strong>
		</div>
		<div class="meta-item">
			<span class="meta-label">Genero</span>
			<strong>${juego.genero}</strong>
		</div>
		<div class="meta-item">
			<span class="meta-label">Desarrolladora</span>
			<strong>${juego.desarrolladora}</strong>
		</div>
		<div class="meta-item">
			<span class="meta-label">Plataformas</span>
			<strong>${juego.plataforma}</strong>
		</div>
		`;
}

cargarJuego();
