const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const authMiddleware = require('../middlewares/authMiddleware');

// All user routes should be protected
router.use(authMiddleware);

// GET /api/users/profile
router.get('/profile', userController.getProfile);

// PUT /api/users/profile
router.put('/profile', userController.updateProfile);

module.exports = router;
