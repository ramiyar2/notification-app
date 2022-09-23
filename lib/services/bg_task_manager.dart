import 'package:workmanager/workmanager.dart';

import '../controller/controller.dart';
import '../models/reminder.dart';

import 'notification_services.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    Reminder reminder = Reminder.fromJson(inputData!);
    NotifyHelper().displayNotify(task: reminder);
    await ReminderController().addTask(
      reminder: Reminder(
          id: reminder.id,
          title: reminder.title,
          date: reminder.date,
          note: reminder.note,
          remindTime: reminder.remindTime,
          isRead: 0),
    );
    return Future.value(true);
  });
}
