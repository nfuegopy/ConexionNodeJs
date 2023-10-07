const express = require('express');
const router = express.Router();
const pool = require('../../../database');

// Ruta para listar usuarios
router.get('/usuarios', async (req, res) => {
    try {
        const [rows] = await pool.execute('CALL ListarUsuarios()');
        res.json({ success: true, usuarios: rows[0] });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para insertar usuario
router.post('/insertar-usuario', async (req, res) => {
    const { CI, Password } = req.body;
    try {
        await pool.execute('CALL InsertarUsuario(?, ?)', [CI, Password]);
        res.json({ success: true, message: 'Usuario insertado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para actualizar usuario
router.put('/actualizar-usuario', async (req, res) => {
    const { ID, Nombre_Usuario, Password } = req.body;
    try {
        await pool.execute('CALL ActualizarUsuario(?, ?, ?)', [ID, Nombre_Usuario, Password]);
        res.json({ success: true, message: 'Usuario actualizado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para eliminar usuario
router.delete('/eliminar-usuario', async (req, res) => {
    const { ID } = req.body;
    try {
        await pool.execute('CALL EliminarUsuario(?)', [ID]);
        res.json({ success: true, message: 'Usuario eliminado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

module.exports = router;
