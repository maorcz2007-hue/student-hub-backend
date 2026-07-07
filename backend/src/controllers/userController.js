const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// Get the current user's profile
exports.getProfile = async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.user.id },
      include: {
        studentProfile: true, // Assuming the user has a student profile
      }
    });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Exclude passwordHash from response
    const { passwordHash, ...userData } = user;
    res.json(userData);
  } catch (error) {
    console.error('Error fetching profile:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};

// Update the current user's profile
exports.updateProfile = async (req, res) => {
  try {
    const { fullName, email, bio, university, department } = req.body;

    // First update the core user table
    const updatedUser = await prisma.user.update({
      where: { id: req.user.id },
      data: {
        fullName: fullName,
        email: email,
      },
    });

    // Then update the student profile if provided
    let updatedStudent = null;
    if (bio || university || department) {
      updatedStudent = await prisma.student.upsert({
        where: { userId: req.user.id },
        update: {
          bio: bio,
          university: university,
          department: department,
        },
        create: {
          userId: req.user.id,
          studentId: `STU-${Date.now().toString().slice(-6)}`,
          bio: bio,
          university: university,
          department: department,
        }
      });
    }

    // Exclude passwordHash
    const { passwordHash, ...userData } = updatedUser;
    
    res.json({
      ...userData,
      studentProfile: updatedStudent
    });
  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({ message: 'Failed to update profile' });
  }
};
