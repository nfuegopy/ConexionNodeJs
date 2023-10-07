const express = require('express');
const cors = require("cors");
const app = express();

// Importamos las rutas que vamos a utilizar 
const authRoutes = require('./routes/authRoutes');
const dataRoutes = require('./routes/seguridad/Personal/PersonalRoutes');
const UserRoutes = require('./routes/seguridad/Usuario/UsuarioRoute');


app.use(cors());
app.use(express.json());
app.use('/auth', authRoutes);
app.use('/data', dataRoutes);
app.use('/user', UserRoutes);


app.listen(3000, () => console.log('Server running on port 3000'));
