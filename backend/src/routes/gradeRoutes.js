const express = require('express');
const router = express.Router();
const gradeController = require('../controllers/gradeController');
const authenticate = require('../middlewares/authMiddleware');

router.use(authenticate);

router.get('/', gradeController.getGrades);

module.exports = router;
