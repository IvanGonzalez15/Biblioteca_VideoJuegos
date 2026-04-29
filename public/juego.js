const params = new URLSearchParams(window.location.search);
const id = params.get('id');

async function cargarJuego() {
	if (!id) {
		document.getElementById('juego-titulo').textContent = 'ID no valido';
		return;
	}

	const response = await fetch('/api/juegos/' + id);
	const juego = await response.json();

	if (juego.error) {
		document.getElementById('juego-titulo').textContent = 'Juego no encontrado';
		return;
	}

	document.getElementById('juego-titulo').textContent = juego.name;
	document.getElementById('juego-descripcion-corta').textContent = juego.description;
	document.getElementById('juego-portada').src = juego.image;
	document.getElementById('juego-portada').alt = juego.name;

	document.getElementById('juego-tags').innerHTML =
		'<span class="tag">' + juego.genero + '</span>' +
		'<span class="tag">' + juego.plataforma + '</span>' +
		'<span class="tag">' + juego.año + '</span>';

	const precioStr = juego.precio ? juego.precio + ' EUR' : 'No disponible';
	const duracionStr = juego.duracion ? juego.duracion + ' horas' : 'No disponible';
	const valoracionStr = juego.valoracion ? juego.valoracion + '/10' : 'No disponible';
	const plataformaStr = juego.plataforma || 'No disponible';

	document.getElementById('juego-meta').innerHTML =
		'<div class="meta-item"><span class="meta-label">Lanzamiento</span><strong>' + juego.fecha + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Genero</span><strong>' + juego.genero + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Desarrolladora</span><strong>' + juego.desarrolladora + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Plataformas</span><strong>' + plataformaStr + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Precio</span><strong>' + precioStr + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Valoracion</span><strong>' + valoracionStr + '</strong></div>' +
		'<div class="meta-item"><span class="meta-label">Duracion</span><strong>' + duracionStr + '</strong></div>';
}

cargarJuego();