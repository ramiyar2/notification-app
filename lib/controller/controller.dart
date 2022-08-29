import 'package:get/get.dart';
import 'package:notification_app/db/db.dart';
import '../models/reminder.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  Future<int> addTask({required Task task}) {
    return HelperDb.putData(task: task, isNotify: false);
  }

  Future<RxList<Task>> getTasks() async {
    final List<Map<String, dynamic>> dbTasks =
        await HelperDb.quary(isNotify: false);
    // another way
    // var list = List.generate(
    //     dbTasks.length,
    //     (index) => Task(
    //           id: dbTasks[index]['id'],
    //           title: dbTasks[index]['title'],
    //           date: dbTasks[index]['date'],
    //           remindTime: dbTasks[index]['remindTime'],
    //         ));
    tasks.assignAll(dbTasks.map((data) {
      return Task.fromJson(data);
    }).toList());
    // print(tasks);
    return tasks;
  }
}

class ReminderController extends GetxController {
  RxList<Reminder> reminderList = <Reminder>[].obs;

  addTask({required Reminder reminder}) {
    return HelperDb.putData(reminder: reminder, isNotify: true);
  }

  getTasks() async {
    final List<Map<String, dynamic>> dbTasks =
        await HelperDb.quary(isNotify: true);
    print('get data $dbTasks');
    reminderList.assignAll(dbTasks.map((data) {
      return Reminder.fromJson(data);
    }).toList());
    // print(tasks);
    return reminderList;
  }

  deletTask({required Reminder reminder}) async {
    await HelperDb.delete(reminder, isNotify: true);
  }
}
