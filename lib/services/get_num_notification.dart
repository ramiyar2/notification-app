import 'package:get/get.dart';

import '../controller/controller.dart';
import '../models/reminder.dart';

getLastNotificationData() async {
  RxList<Reminder> notificationTasks = await ReminderController().getTasks();
  print(notificationTasks.length);
  return notificationTasks;
}
