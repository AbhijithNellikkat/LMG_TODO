import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

class ScreenCalendar extends StatelessWidget {
  const ScreenCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController<Object?> _controller = EventController();

    _controller.add(
      CalendarEventData(
        title: "Read Book",
        description: "Read 20 pages",
        date: DateTime(2025, 11, 28),
      ),
    );
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        automaticallyImplyLeading: false,
        title: Text(
          "Calendar",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: MonthView(
          headerStyle: HeaderStyle(decoration: BoxDecoration(color: kwhite)),
          controller: _controller,
          borderColor: klightgrey,
          showWeekTileBorder: false,
          // showWeekends: false,
          borderSize: 0.5,
          cellAspectRatio: 0.6,

          onCellTap: (events, date) {
            showModalBottomSheet(
              context: context,
              builder: (_) => _TodoListForDay(events: events, date: date),
            );
          },
        ),
      ),
    );
  }
}

class _TodoListForDay extends StatelessWidget {
  final List<CalendarEventData<Object?>> events;
  final DateTime date;

  const _TodoListForDay({required this.events, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Todos on ${date.day}-${date.month}-${date.year}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: events.isEmpty
                ? const Center(child: Text("No todos for this day"))
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final e = events[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(e.title),
                          subtitle: Text(e.description ?? ''),
                          trailing: const Icon(Iconsax.arrow_right_3),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
