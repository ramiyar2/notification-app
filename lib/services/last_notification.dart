import 'package:notification_app/controller/controller.dart';
import 'package:notification_app/models/task.dart';
import 'package:schedulers/schedulers.dart';

import '../models/reminder.dart';

notifyScheduler(DateTime dateTime, Task task) {
  final scheduler = TimeScheduler();
  if (!dateTime.isBefore(DateTime.now())) {
    print('scheduler called $dateTime');
    scheduler.run(
      () async {
        print('scheduler done');
        int value = await ReminderController().addTask(
          reminder: Reminder(
              id: task.id,
              title: task.title,
              date: task.date,
              note: task.note,
              remindTime: task.remindTime,
              isRead: 0),
        );
        print(value);
      },
      dateTime,
    );
  } else {
    print('scheduler will not called $dateTime < ${DateTime.now()}');
  }
}
