const express = require('express');
const router = express.Router();
const pool = require('../../../database');

// Ruta para listar personales
router.get('/personales', async (req, res) => {
    try {
        const [rows] = await pool.execute('CALL ListarPersonales()');
        res.json({ success: true, personales: rows });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para insertar personal
router.post('/insertar-personal', async (req, res) => {
    const { CI, Nombre, Apellido, Telefono, Email } = req.body;
    try {
        await pool.execute('CALL InsertarPersonal(?, ?, ?, ?, ?)', [CI, Nombre, Apellido, Telefono, Email]);
        res.json({ success: true, message: 'Personal insertado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para actualizar personal
router.put('/actualizar-personal', async (req, res) => {
    const { CI, Nombre, Apellido, Telefono, Email } = req.body;
    try {
        await pool.execute('CALL ActualizarPersonal(?, ?, ?, ?, ?)', [CI, Nombre, Apellido, Telefono, Email]);
        res.json({ success: true, message: 'Personal actualizado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

// Ruta para eliminar personal
router.delete('/eliminar-personal', async (req, res) => {
    const { CI } = req.body;
    try {
        await pool.execute('CALL EliminarPersonal(?)', [CI]);
        res.json({ success: true, message: 'Personal eliminado correctamente' });
    } catch (error) {
        res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});


module.exports = router;
