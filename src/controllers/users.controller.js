const { Pool } = require('pg');

/* const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    password: '123',
    database: 'edusmart',
    port: '5432'
});
 */
process.env.DATABASE_URL = 'postgres://postgres:123@localhost:5432/edusmart';

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
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