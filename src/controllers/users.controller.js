const { Pool } = require('pg');

process.env.PG_USER = 'postgres';
process.env.PG_ENDPOINT = 'localhost';
process.env.PG_DB = 'edusmart';
process.env.PG_PASS = '123';
process.env.PG_PORT = 5432;
const pool = new Pool({
    user: process.env.PG_USER, //postgres user
    host: process.env.PG_ENDPOINT, //localhost (I also tried 127.0.0.1)
    database: process.env.PG_DB, //database name to connect to
    password: process.env.PG_PASS, //postgres user password
    port: process.env.PG_PORT //5432
});

const getUsers = async(req, res) => {
    const response = await pool.query('SELECT * FROM usuario ORDER BY id_usuario ASC');
    res.status(200).json(response.rows);
};

const getUserById = async(req, res) => {
    const id = parseInt(req.params.id);
    const response = await pool.query('SELECT * FROM usuario WHERE id_usuario = $1', [id]);
    res.json(response.rows);
};

const createUser = async(req, res) => {
    console.log(req.body);
    const { nombreP, nombreH, fechaN, genero, usuario, password } = req.body;
    const response = await pool.query('INSERT INTO usuario (nombre_padre,nombre_hijo,nacimiento,id_gen,usuario,password) VALUES ($1, $2, $3, $4, $5, $6)', [nombreP, nombreH, fechaN, genero, usuario, password]);

    res.json({
        message: 'Usuario registrado',
        estado: true,
        body: {
            user: { nombreP, nombreH, fechaN, genero, usuario, password }
        }
    })
};

const updateUser = async(req, res) => {
    const id = parseInt(req.params.id);
    const { name, email } = req.body;

    const response = await pool.query('UPDATE users SET name = $1, email = $2 WHERE id = $3', [
        name,
        email,
        id
    ]);
    res.json('User Updated Successfully');
};

const deleteUser = async(req, res) => {
    const id = parseInt(req.params.id);
    await pool.query('DELETE FROM users where id = $1', [
        id
    ]);
    res.json(`User ${id} deleted Successfully`);
};

module.exports = {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser
};