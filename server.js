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

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Ver todos los juegos
app.get('/api/juegos', async (req, res) => {
    const result = await pool.query('SELECT * FROM public.getvideogames_completo()');

    const orden = req.query.orden;
    const juegos = result.rows;

    if (orden === 'fecha') {
        for (let i = 0; i < juegos.length; i++) {
            for (let j = i + 1; j < juegos.length; j++) {
                const fechaI = new Date(juegos[i].release_date);
                const fechaJ = new Date(juegos[j].release_date);
                if (fechaJ > fechaI) {
                    const temp = juegos[i];
                    juegos[i] = juegos[j];
                    juegos[j] = temp;
                }
            }
        }
    } else {
        for (let i = 0; i < juegos.length; i++) {
            for (let j = i + 1; j < juegos.length; j++) {
                if (juegos[j].name < juegos[i].name) {
                    const temp = juegos[i];
                    juegos[i] = juegos[j];
                    juegos[j] = temp;
                }
            }
        }
    }

    res.json(juegos);
});

// Filtrar por género
app.get('/api/juegos/genero/:nombre', async (req, res) => {
    const result = await pool.query('SELECT * FROM public.getvideogames_completo()');
    const juegos = [];

    for (let i = 0; i < result.rows.length; i++) {
        if (result.rows[i].genre.toLowerCase() === req.params.nombre.toLowerCase()) {
            juegos.push(result.rows[i]);
        }
    }
    res.json(juegos);
});

// Ver un juego por su ID
app.get('/api/juegos/:id', async (req, res) => {
    const id = Number(req.params.id);

    const result = await pool.query('SELECT * FROM public.getvideogames_completo()');

    let juego = null;
    for (let i = 0; i < result.rows.length; i++) {
        if (result.rows[i].id === id) {
            juego = result.rows[i];
            break;
        }
    }

    if (!juego) return res.status(404).json({ error: 'No encontrado' });

    // Convertir release_date a string si es un objeto por problemas de pg
    let fechaStr = '';
    if (juego.release_date) {
        if (typeof juego.release_date === 'string') {
            fechaStr = juego.release_date;
        } else {
            fechaStr = juego.release_date.toISOString().split('T')[0];
        }
    }

    let año = '';
    if (fechaStr) {
        año = fechaStr.split('-')[0];
    }

  res.json({
    id: juego.id,
    name: juego.name,
    description: juego.description,
    genero: juego.genre,
    desarrolladora: juego.developer,
    image: juego.image,
    plataforma: '',
    fecha: fechaStr,
    año: año,
    precio: juego.price,
    valoracion: juego.valoration,
    duracion: juego.duration,
  });
});

// Buscar juegos
app.get('/api/buscar', async (req, res) => {
    const q = req.query.q;
    if (!q) return res.status(400).json({ error: 'Falta busqueda' });

    const result = await pool.query('SELECT * FROM public.getvideogames_completo()');
    const juegos = [];
    const palabra = q.toLowerCase();

    for (let i = 0; i < result.rows.length; i++) {
        const j = result.rows[i];
        if (j.name.toLowerCase().includes(palabra) || j.description.toLowerCase().includes(palabra) || j.genre.toLowerCase().includes(palabra)) {
            juegos.push(j);
        }
    }
    res.json(juegos);
});

// Login de admin
app.post('/api/login', (req, res) => {
    const usuario = req.body.usuario;
    const password = req.body.password;

    if (password === process.env.ADMIN_PASSWORD && usuario === process.env.ADMIN_NAME) {
        res.json({ success: true, admin: true });
    } else {
        res.json({ success: false, admin: false, error: 'Incorrecto' });
    }
});

// Insertar juego nuevo
app.post('/api/insert', async (req, res) => {
    const nombre = req.body.name;
    const descripcion = req.body.description;
    const duracion = req.body.duration;
    const fecha = req.body.release_date;
    const precio = req.body.price;
    const genero_nombre = req.body.genero;
    const developer_nombre = req.body.developer;
    const valoracion = req.body.valoration;
    const imagen = req.body.image;

    if (!nombre || !descripcion || !genero_nombre || !developer_nombre) {
        return res.json({ success: false, error: 'Faltan datos' });
    }

    // Insertar genero si no existe
    await pool.query(
        'INSERT INTO genre (name) VALUES ($1) ON CONFLICT (name) DO NOTHING',
        [genero_nombre]
    );

    // Obtener ID del genero
    const generoResult = await pool.query('SELECT id FROM genre WHERE name = $1', [genero_nombre]);
    const genero_id = generoResult.rows[0].id;

    // Insertar developer si no existe (con todos los campos obligatorios)
    await pool.query(
        'INSERT INTO developer (name, description, year_fundation, country) VALUES ($1, $2, $3, $4) ON CONFLICT (name) DO NOTHING',
        [developer_nombre, 'Descripcion no disponible', 2000, 'Desconocido']
    );

    // Obtener ID del developer
    const developerResult = await pool.query('SELECT id FROM developer WHERE name = $1', [developer_nombre]);
    const developer_id = developerResult.rows[0].id;

    // Insertar el juego
    await pool.query(
        'SELECT insert_videogame($1, $2, $3, $4, $5, $6, $7, $8, $9)',
        [nombre, descripcion, duracion, fecha, precio, genero_id, developer_id, valoracion, imagen]
    );
    res.json({ success: true });
});

// Eliminar juego
app.delete('/api/juegos/:id', async (req, res) => {
    const id = Number(req.params.id);

    if (!id) {
        return res.json({ success: false, error: 'ID invalido' });
    }

    await pool.query('DELETE FROM videogame WHERE id = $1', [id]);
    res.json({ success: true });
});

app.listen(PORT, () => console.log('Servidor en puerto ' + PORT));