require('dotenv').config();
const express = require('express');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

const pool = new Pool({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

pool.connect((err, client, release) => {
    if (err) {
        console.error('Error conectando a PostgreSQL:', err.message);
    } else {
        console.log('Conectado a PostgreSQL correctamente');
        release();
    }
});

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

async function cargarDatosBase() {
    const [juegosResult, generosResult, developersResult] = await Promise.all([
        pool.query('SELECT * FROM public.getvideogames();'),
        pool.query('SELECT * FROM public.getgenres();'),
        pool.query('SELECT * FROM public.getdevelopers();'),
    ]);

    return {
        juegos: juegosResult.rows,
        generos: generosResult.rows,
        developers: developersResult.rows,
    };
}

function enriquecerJuego(juego, generos, developers) {
    const genero = generos.find((item) => item.id === juego.genre_id);
    const developer = developers.find((item) => item.id === juego.developer_id);

    return {
        id: juego.id,
        name: juego.name,
        description: juego.description,
        genre: genero?.name || '',
        developer: developer?.name || '',
        image: juego.image || '',
        platform: '',
        release_date: juego.release_date,
    };
}

function ordenarJuegos(juegos, orden = 'nombre') {
    return [...juegos].sort((a, b) =>
        orden === 'fecha'
            ? new Date(b.release_date) - new Date(a.release_date)
            : a.name.localeCompare(b.name)
    );
}

app.get('/api/juegos', async (req, res) => {
    const { orden = 'nombre' } = req.query;

    try {
        const { juegos, generos, developers } = await cargarDatosBase();
        const resultado = juegos.map((juego) => enriquecerJuego(juego, generos, developers));

        res.json(ordenarJuegos(resultado, orden));
    } catch (err) {
        console.error('Error en /api/juegos:', err.message);
        res.status(500).json({ error: 'Error al obtener los juegos' });
    }
});

app.get('/api/juegos/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const { juegos, generos, developers } = await cargarDatosBase();
        const juego = juegos.find((item) => item.id === Number(id));

        if (!juego) {
            return res.status(404).json({ error: 'Juego no encontrado' });
        }

        const genero = generos.find((item) => item.id === juego.genre_id);
        const developer = developers.find((item) => item.id === juego.developer_id);
        const juegoBase = enriquecerJuego(juego, generos, developers);

        res.json({
            id: juegoBase.id,
            name: juegoBase.name,
            description: juegoBase.description,
            genero: genero?.name || '',
            desarrolladora: developer?.name || '',
            image: juegoBase.image,
            plataforma: '',
            fecha: new Date(juego.release_date).toLocaleDateString('es-ES'),
            anio: new Date(juego.release_date).getFullYear(),
        });
    } catch (err) {
        console.error('Error en /api/juegos/:id:', err.message);
        res.status(500).json({ error: 'Error al obtener el juego' });
    }
});

app.get('/api/juegos/genero/:nombre', async (req, res) => {
    const { nombre } = req.params;
    const { orden = 'nombre' } = req.query;

    try {
        const { juegos, generos, developers } = await cargarDatosBase();
        const resultado = juegos
            .map((juego) => enriquecerJuego(juego, generos, developers))
            .filter((juego) => juego.genre.toLowerCase() === nombre.toLowerCase());

        res.json(ordenarJuegos(resultado, orden));
    } catch (err) {
        console.error('Error en /api/juegos/genero:', err.message);
        res.status(500).json({ error: 'Error al filtrar por genero' });
    }
});

app.get('/api/buscar', async (req, res) => {
    const { q, genero = 'todos', orden = 'nombre' } = req.query;

    if (!q || q.trim() === '') {
        return res.status(400).json({ error: 'Introduce un termino de busqueda' });
    }

    try {
        const termino = q.trim().toLowerCase();
        const { juegos: juegosBase, generos, developers } = await cargarDatosBase();
        let juegos = juegosBase
            .map((juego) => enriquecerJuego(juego, generos, developers))
            .filter((juego) =>
                juego.name.toLowerCase().includes(termino) ||
                juego.description.toLowerCase().includes(termino) ||
                juego.genre.toLowerCase().includes(termino) ||
                juego.developer.toLowerCase().includes(termino)
            );

        if (genero !== 'todos') {
            juegos = juegos.filter((juego) => juego.genre.toLowerCase() === genero.toLowerCase());
        }

        res.json(ordenarJuegos(juegos, orden));
    } catch (err) {
        console.error('Error en /api/buscar', err.message);
        res.status(500).json({ error: 'Error en la busqueda' });
    }
});

app.post('/api/login', (req, res) => {
    const { usuario, password } = req.body;

    if (!usuario || !password) {
        return res.status(400).json({ error: 'Falta usuario y contrasena' });
    }

    if (password === process.env.ADMIN_PASSWORD && usuario === process.env.ADMIN_NAME) {
        res.json({ success: true, admin: true });
    } else {
        res.status(401).json({ success: false, admin: false, error: 'Contrasena incorrecta' });
    }
});

app.post('/api/insert', async (req, res) => {
    
});

app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto: ${PORT}`);
});
