const { Router } = require('express');
const router = Router();

const {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    getProgresoByModo,
    getNiveles,
    getLevelsEscribir,
    getAnsweredEscribir,
    getLevelsLeer,
    getAnsweredLeer,
    getLevelsComp,
    getAnsweredComp
} = require('../controllers/users.controller');

router.get('/users', getUsers);
router.get('/users/:id', getUserById);
router.post('/users', createUser);
router.put('/users/:id', updateUser)
router.delete('/users/:id', deleteUser);
router.get('/niveles/:id/:modo', getProgresoByModo);
router.get('/niveles', getNiveles);
router.get('/questions/read/:id/:nivel', getLevelsLeer);
router.get('/answered/read/:id/:nivel', getAnsweredLeer);
router.get('/questions/write/:id/:nivel', getLevelsEscribir);
router.get('/answered/write/:id/:nivel', getAnsweredEscribir);
router.get('/questions/comp/:id/:nivel', getLevelsComp);
router.get('/answered/comp/:id/:nivel', getAnsweredComp);

module.exports = router;