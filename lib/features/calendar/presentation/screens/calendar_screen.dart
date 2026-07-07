import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final _events = <DateTime, List<_CalendarEvent>>{};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Mock events
    final today = DateTime.now();
    _events[DateTime(today.year, today.month, today.day)] = [
      _CalendarEvent('Data Structures', '09:00 - 10:30', AppColorSchemes.primaryBlue, 'class'),
      _CalendarEvent('Linear Algebra', '11:00 - 12:30', AppColorSchemes.primaryPurple, 'class'),
      _CalendarEvent('Physics Lab', '14:00 - 16:00', AppColorSchemes.primaryGreen, 'lab'),
    ];
    _events[DateTime(today.year, today.month, today.day + 1)] = [
      _CalendarEvent('HW3 Due', '23:59', AppColorSchemes.primaryRed, 'deadline'),
      _CalendarEvent('AI Class', '10:00 - 11:30', AppColorSchemes.primaryOrange, 'class'),
    ];
  }

  List<_CalendarEvent> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Calendar'), backgroundColor: Colors.transparent),
      body: Column(
        children: [
          GlassCard(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.only(bottom: 8),
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() { _selectedDay = selectedDay; _focusedDay = focusedDay; });
              },
              onFormatChanged: (format) => setState(() => _calendarFormat = format),
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.20), shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                markerSize: 6,
                markersMaxCount: 3,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonDecoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                formatButtonTextStyle: TextStyle(color: theme.colorScheme.primary, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _getEventsForDay(_selectedDay ?? _focusedDay)
                  .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(children: [
                        Container(width: 4, height: 40, decoration: BoxDecoration(color: e.color, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 14),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                            Text(e.time, style: theme.textTheme.bodySmall),
                          ],
                        )),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: e.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                          child: Text(e.type, style: TextStyle(color: e.color, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ]),
                    ),
                  ))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Iconsax.add)),
    );
  }
}

class _CalendarEvent {
  final String title, time, type;
  final Color color;
  _CalendarEvent(this.title, this.time, this.color, this.type);
}
