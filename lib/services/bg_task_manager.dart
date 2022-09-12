import 'package:workmanager/workmanager.dart';

import '../controller/controller.dart';
import '../models/reminder.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Reminder reminder = Reminder.fromJson(inputData!);
    await ReminderController().addTask(
      reminder: Reminder(
          id: reminder.id,
          title: reminder.title,
          date: reminder.date,
          note: reminder.note,
          remindTime: reminder.remindTime,
          isRead: 0),
    );
    print('Workmanager called');
    return Future.value(true);
  });
}
