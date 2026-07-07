const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const ical = require('node-ical');

exports.getMoodleEvents = async (req, res) => {
  try {
    // 1. Get the user's saved moodleIcalUrl
    const settings = await prisma.userSettings.findUnique({
      where: { userId: req.user.id }
    });

    if (!settings || !settings.moodleIcalUrl) {
      return res.status(400).json({ message: 'No Moodle iCal URL configured for this user.' });
    }

    const url = settings.moodleIcalUrl;

    // 2. Fetch and parse the iCal data
    const events = await ical.async.fromURL(url);
    
    // 3. Process the events into a simpler JSON format
    const processedEvents = [];
    for (const key in events) {
      const event = events[key];
      if (event.type === 'VEVENT') {
        processedEvents.push({
          id: event.uid,
          title: event.summary,
          description: event.description || '',
          startTime: event.start,
          endTime: event.end,
          location: event.location || '',
        });
      }
    }

    // Sort events by start time
    processedEvents.sort((a, b) => new Date(a.startTime) - new Date(b.startTime));

    res.json({ events: processedEvents });
  } catch (error) {
    console.error('Error syncing Moodle calendar:', error);
    res.status(500).json({ message: 'Failed to sync Moodle calendar. Check the URL.' });
  }
};

exports.updateMoodleUrl = async (req, res) => {
  try {
    const { moodleIcalUrl } = req.body;
    
    await prisma.userSettings.upsert({
      where: { userId: req.user.id },
      update: { moodleIcalUrl },
      create: {
        userId: req.user.id,
        moodleIcalUrl
      }
    });

    res.json({ message: 'Moodle URL updated successfully' });
  } catch (error) {
    console.error('Error updating Moodle URL:', error);
    res.status(500).json({ message: 'Server Error' });
  }
};
