const express = require('express');
const router = express.Router();
const assignmentController = require('../controllers/assignmentController');
const authenticate = require('../middlewares/authMiddleware');

router.use(authenticate);

router.get('/', assignmentController.getAssignments);
router.post('/', assignmentController.addAssignment);
router.delete('/:id', assignmentController.deleteAssignment);

module.exports = router;
