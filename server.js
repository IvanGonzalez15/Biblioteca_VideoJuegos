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
        release(); // libera la conexión de vuelta al pool
    }
});

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/api/juegos', async (req, res) => {
    const { orden } = req.query;

    const ordenesPermitidos = {
        nombre: 'v."Name"',
        fecha: 'v."Release_Date"',
        nota: 'v."Valoration"',
    };

    const orderBy = ordenesPermitidos[orden] || 'v."Name"';

    try {
        const result = await pool.query(`AQUI TAMBIEN SELECT`);
        res.json(result.rows);
    } catch (err) {
        console.error('Error en /api/juegos:', err.message);
        res.status(500).json({ error: 'Error al obtener los juegos' });
    }
});

app.get('/api/juegos/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const result = await pool.query();

        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Juego no encontrado' });
        }
        res.json(result.rows[0]);
    } catch (err) {
        console.error('Error en /api/juegos/:id:', err.message);
        res.status(500).json({ error: 'Error al obtener el juego' });
    }
});

app.get('/api/juegos/genero/:nombre', async (req, res) => {
    const { nombre } = req.params;

    try {
        const result = await pool.query(`#AQUI SELECT O LO QUE SEA NOSE`);
        res.json(result.rows);
    } catch (err) {
        console.error('Error en /api/juegos/genero:', err.message);
        res.status(500).json({ error: 'Error al filtrar por genero' });
    }
});


app.get('/api/buscar', async (req, res) => {
    const { q } = req.query;

    if (!q || q.trim() === '') {
        return res.status(400).json({ error: 'Introduce un termino de busqueda' });
    }

    try {
        const result = await pool.query(`#AQUI EL SELECT`);
        res.json(result.rows);
    } catch (err) {
        console.error('Error en /api/buscar', err.message);
        res.status(500).json({ error: 'Erroe en la busqueda' });
    }
});

app.post('/api/login', (req, res) => {
    const { password } = req.body;

    if (password === process.env.ADMIN_PASSWORD) {
        res.json({ admin: true });
    } else {
        res.status(401).json({ admin: false, error: 'Contraseña incorrecta' });
    }
});

app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto:${PORT}`);
});