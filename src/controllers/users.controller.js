const { Pool } = require('pg');


// Conexion local
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    password: 'sololdu',
    database: 'edusmart',
    port: '5432'
});


//Conexión a Postgres heroku
/* process.env.DATABASE_URL = 'postgres://yurmkyxwvuozrr:512fc9b1da40e905cb6219292d72058824f7c34f02166c6f1da4319eb17e3352@ec2-3-222-49-168.compute-1.amazonaws.com:5432/dc4pailb7l1f52';

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: {
        rejectUnauthorized: false
    }
}); */


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


const getProgresoByModo = async(req, res) => {
    const id = parseInt(req.params.id);
    const modo = parseInt(req.params.modo);
    const response = await pool.query(`SELECT count(*) as id,nivel as title,SUM(aciertos) as aciertos,SUM(errores) as fallos,id_modo FROM datos_user as du,niveles as
    n WHERE du.id_usuario = ${id} and du.id_nivel = n.id_nivel and du.id_modo = ${modo} group by nivel,id_modo`);
    res.json(response.rows);
}

const getNiveles = async(req, res) => {
    const response = await pool.query('SELECT * FROM niveles ORDER BY id_nivel ASC');
    res.status(200).json(response.rows);
};

module.exports = {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    getProgresoByModo,
    getNiveles
};