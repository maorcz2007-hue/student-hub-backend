const express = require('express');
const router = express.Router();
const calendarController = require('../controllers/calendarController');
const authenticate = require('../middlewares/authMiddleware');

router.use(authenticate);

// GET /api/calendar/moodle
router.get('/moodle', calendarController.getMoodleEvents);

// PUT /api/calendar/moodle
router.put('/moodle', calendarController.updateMoodleUrl);

module.exports = router;
