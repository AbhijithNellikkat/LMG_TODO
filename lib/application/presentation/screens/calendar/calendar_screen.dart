import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';
import 'package:lmg_todo/application/presentation/utils/constants.dart';

import '../../../controller/todo_controller.dart';

class ScreenCalendar extends StatelessWidget {
  const ScreenCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();
    final eventController = EventController();

    /// Convert todos to calendar events
    for (var todo in controller.todos) {
      eventController.add(
        CalendarEventData(
          title: todo.title,
          description: todo.description,
          date: todo.createdAt,
        ),
      );
    }

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
        child: Obx(() {
          eventController.removeWhere((e) => true);

          controller.todos.forEach((todo) {
            eventController.add(
              CalendarEventData(
                title: todo.title,
                description: todo.description,
                date: todo.createdAt,
                event: todo,
              ),
            );
          });

          return MonthView(
            controller: eventController,
            headerStyle: HeaderStyle(decoration: BoxDecoration(color: kwhite)),
            borderColor: klightgrey,
            showWeekTileBorder: false,
            borderSize: 0.5,
            cellAspectRatio: 0.6,

            cellBuilder: (date, event, isToday, isInMonth, hideDaysNotInMonth) {
              Color bgColor = kwhite;
              if (!isInMonth) {
                bgColor = klightgrey;
              } else if (event.isNotEmpty) {
                bgColor = kprimary.withOpacity(0.2);
              } else if (isToday) {
                bgColor = Colors.yellow.shade200;
              }

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: bgColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isInMonth ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (event.isNotEmpty)
                      Badge.count(
                        count: event.length,
                        backgroundColor: kprimary,
                        child: Icon(Iconsax.task),
                      ),
                  ],
                ),
              );
            },

            onCellTap: (events, date) {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (_) => _TodoListForDay(events: events, date: date),
              );
            },
          );
        }),
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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(screenBgImage),
          fit: BoxFit.cover,
        ),
      ),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Todos on ${date.day}-${date.month}-${date.year}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 15.sp,

              fontWeight: FontWeight.w500,
            ),
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
                          title: Text(
                            e.title,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: 14.sp,

                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          subtitle: Text(e.description ?? ''),

                          onTap: () {},
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
