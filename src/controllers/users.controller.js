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
    const response = await pool.query(`SELECT count(*) as id,nivel as title,SUM(aciertos) as aciertos,SUM(errores) as fallos,id_modo,n.id_nivel 
    FROM datos_user as du,niveles as
    n WHERE du.id_usuario = ${id} and du.id_nivel = n.id_nivel and du.id_modo = ${modo} group by nivel,id_modo,n.id_nivel ORDER BY n.id_nivel`);
    res.json(response.rows);
}

const getNiveles = async(req, res) => {
    const response = await pool.query('SELECT * FROM niveles ORDER BY id_nivel ASC');
    res.status(200).json(response.rows);
};


const getLevelsLeer = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QL.ID_PREGUNTA,PALABRA,OP1,OP2,OP3,OP4,ANSWER,CONTESTADA FROM Q_LEER AS QL
    LEFT JOIN DATOS_USER AS DU 
    ON QL.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 1
    WHERE QL.ID_NIVEL = ${nivel}  AND ACIERTOS IS NULL 
    ORDER BY QL.ID_PREGUNTA ASC`);
    res.json(response.rows);
}

const getAnsweredLeer = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QL.ID_PREGUNTA,PALABRA,OP1,OP2,OP3,OP4,ANSWER,CONTESTADA FROM Q_LEER AS QL
    LEFT JOIN DATOS_USER AS DU 
    ON QL.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 1
    WHERE QL.ID_NIVEL = ${nivel}  AND ACIERTOS IS NOT NULL 
    ORDER BY QL.ID_PREGUNTA ASC`);
    res.json(response.rows);
}


const getLevelsEscribir = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QE.ID_PREGUNTA,IMAGEN,ANSWER,ANSWER2 FROM Q_ESCRIBIR AS QE
    LEFT JOIN DATOS_USER AS DU 
    ON QE.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 2
    WHERE QE.ID_NIVEL = ${nivel}  AND ACIERTOS IS NULL 
    ORDER BY QE.ID_PREGUNTA ASC`);
    res.json(response.rows);
}

const getAnsweredEscribir = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QE.ID_PREGUNTA,IMAGEN,ANSWER,ANSWER2 FROM Q_ESCRIBIR AS QE
    LEFT JOIN DATOS_USER AS DU 
    ON QE.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 2
    WHERE QE.ID_NIVEL = ${nivel}  AND ACIERTOS IS NOT NULL 
    ORDER BY QE.ID_PREGUNTA ASC`);
    res.json(response.rows);
}

const getLevelsComp = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QC.ID_PREGUNTA,AUDIO,OP1,OP2,OP3,OP4,ANSWER FROM Q_COMP AS QC
    LEFT JOIN DATOS_USER AS DU 
    ON QC.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 3
    WHERE QC.ID_NIVEL = ${nivel}  AND ACIERTOS IS NULL 
    ORDER BY QC.ID_PREGUNTA ASC`);
    res.json(response.rows);
}

const getAnsweredComp = async(req, res) => {
    const id = parseInt(req.params.id);
    const nivel = parseInt(req.params.nivel);
    const response = await pool.query(`SELECT QC.ID_PREGUNTA,AUDIO,OP1,OP2,OP3,OP4,ANSWER FROM Q_COMP AS QC
    LEFT JOIN DATOS_USER AS DU 
    ON QC.ID_PREGUNTA = DU.ID_PREGUNTA AND DU.ID_USUARIO = ${id} AND DU.ID_MODO = 3
    WHERE QC.ID_NIVEL = ${nivel}  AND ACIERTOS IS NOT NULL 
    ORDER BY QC.ID_PREGUNTA ASC`);
    res.json(response.rows);
}
const getrespuestaContestada = async(req, res) => {
    const idU = parseInt(req.params.idU);
    const nivel = parseInt(req.params.nivel);
    const acierto = parseInt(req.params.acierto);
    const error = parseInt(req.params.error);
    const idP = parseInt(req.params.idP);
    const modo = parseInt(req.params.modo);

    const response = await pool.query(`INSERT INTO public.datos_user( id_usuario, id_nivel, aciertos, errores, id_pregunta, id_modo) VALUES (${idU},${nivel},${acierto},${error},${idP},${modo});`);
    res.json({ ok: true });
}

module.exports = {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    getProgresoByModo,
    getNiveles,
    getAnsweredLeer,
    getLevelsLeer,
    getAnsweredEscribir,
    getLevelsEscribir,
    getLevelsComp,
    getAnsweredComp,
    getrespuestaContestada
};