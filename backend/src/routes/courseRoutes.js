const express = require('express');
const router = express.Router();
const courseController = require('../controllers/courseController');
const authenticate = require('../middlewares/authMiddleware');

router.use(authenticate);

router.get('/', courseController.getCourses);
router.post('/', courseController.addCourse);
router.delete('/:id', courseController.deleteCourse);

module.exports = router;
