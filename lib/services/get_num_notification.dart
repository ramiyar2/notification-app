import 'package:get/get.dart';

import '../controller/controller.dart';
import '../models/reminder.dart';

getLastNotificationDataFun() async {
  RxList<Reminder> notificationTasks = await ReminderController().getTasks();
  print(notificationTasks.length);
  return notificationTasks;
}
