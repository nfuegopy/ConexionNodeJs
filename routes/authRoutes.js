const express = require('express');
const router = express.Router();
const pool = require('../database');
const jwt = require('jsonwebtoken');

router.post('/login', async (req, res) => {
    const { username, password } = req.body;
  
    try {
      const [rows] = await pool.execute('CALL IniciarSesion(?, ?, @resultado)', [username, password]);
      const [resultado] = await pool.execute('SELECT @resultado');
      
      if (resultado[0]['@resultado'] == 1) {
          const token = jwt.sign({ username }, 'yourSecretKey', { expiresIn: '1h' }); /*token para mantener la sesion iniciada expira en 1 hora */
        res.json({ success: true });
      } else {
        res.json({ success: false, message: 'Nombre de usuario o contraseña incorrectos' });
      }
    } catch (error) {
      res.status(500).json({ success: false, message: 'Ocurrió un error en el servidor' });
    }
});

router.get('/user-details', async (req, res) => {
    const username = req.query.username;
    const [rows] = await pool.execute('CALL ObtenerNombreUsuario(?, @nombre, @apellido)', [username]);
    const [resultado] = await pool.execute('SELECT @nombre, @apellido');
    res.json({ nombre: resultado[0]['@nombre'], apellido: resultado[0]['@apellido'] });
});

module.exports = router;
