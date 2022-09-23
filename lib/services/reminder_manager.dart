import 'package:notification_app/services/get_time.dart';
import 'package:workmanager/workmanager.dart';

import '../models/task.dart';

notifyManagment(DateTime dateTime, Task task) {
  if (!dateTime.isBefore(DateTime.now())) {
    if (!getTime(dateTime).isNegative) {
      print('$task /**/ will be called');
      Workmanager().registerOneOffTask(
          '${task.id.toString}', '${task.title.toString}',
          tag: '${task.id.toString}',
          inputData: task.toJson(),
          initialDelay: getTime(dateTime));
    } else {
      return;
    }
  } else {
    return;
  }
}
