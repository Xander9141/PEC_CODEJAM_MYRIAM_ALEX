const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const cors = require('cors');
const bcrypt = require('bcryptjs');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors({
  origin: 'http://localhost:8080', // Ajusta esto si tu frontend está en un puerto diferente
  credentials: true
}));

// Configura la conexión a la base de datos
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'reserva_espacios_comunes'
});

// Conectar a la base de datos
db.connect((err) => {
    if (err) {
        console.error('Error al conectar a la base de datos:', err);
        return;
    }
    console.log('Conectado a la base de datos MySQL');
});

// Ruta para el registro de usuarios
app.post('/api/register', async (req, res) => {
    console.log('Recibida solicitud de registro:', req.body);
    const { nombre, email, password, rol } = req.body;
    
    try {
        const hashedPassword = await bcrypt.hash(password, 10);
        console.log('Contraseña hasheada correctamente');

        const insertQuery = 'INSERT INTO usuarios (nombre, email, contraseña, rol) VALUES (?, ?, ?, ?)';
        db.query(insertQuery, [nombre, email, hashedPassword, rol], (err, result) => {
            if (err) {
                console.error('Error al insertar usuario en la base de datos:', err);
                res.status(500).json({ success: false, message: 'Error al registrar el usuario', error: err.message });
                return;
            }
            console.log('Usuario insertado correctamente:', result);
            res.status(201).json({ success: true, message: 'Usuario registrado exitosamente' });
        });
    } catch (error) {
        console.error('Error al hashear la contraseña:', error);
        res.status(500).json({ success: false, message: 'Error en el servidor', error: error.message });
    }
});

// Ruta para validar el inicio de sesión
app.post('/api/login', async (req, res) => {
    const { email, password } = req.body;
    
    const query = 'SELECT * FROM usuarios WHERE email = ?';
    db.query(query, [email], async (err, results) => {
        if (err) {
            console.error('Error al ejecutar la consulta:', err);
            res.status(500).json({ success: false, message: 'Error en el servidor' });
            return;
        }

        if (results.length > 0) {
            const user = results[0];
            const passwordMatch = await bcrypt.compare(password, user.contraseña);
            if (passwordMatch) {
                res.json({ success: true, user: { id: user.id, email: user.email, nombre: user.nombre, rol: user.rol } });
            } else {
                res.json({ success: false, message: 'Email o contraseña incorrectos' });
            }
        } else {
            res.json({ success: false, message: 'Email o contraseña incorrectos' });
        }
    });
});

// Manejador de errores global
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});