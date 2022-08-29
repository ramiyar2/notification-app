import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/models/reminder.dart';
import 'package:notification_app/services/last_notification.dart';
import 'package:notification_app/ui/add_task.dart';
import 'package:schedulers/schedulers.dart';
import '../controller/controller.dart';
import '../models/task.dart';
import '../services/notification_services.dart';
import 'last_notify.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final TaskController _taskController = Get.put(TaskController());
  late NotifyHelper notifyHelper;
  RxList<Task> taskList = <Task>[].obs;
  RxList<Reminder> notificationTaskList = <Reminder>[].obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getLastNotificationData();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIosPermision();
    notifyHelper.initializeNotify();
  }

  getData() async {
    var tasks = await TaskController().getTasks();
    setState(() => taskList = tasks);
  }

  getLastNotificationData() async {
    RxList<Reminder> notificationTasks = await ReminderController().getTasks();
    print(notificationTasks.length);
    setState(() => notificationTaskList = notificationTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.to(LastNotfiy()),
          icon: Stack(
            alignment: Alignment.topRight,
            children: [
              const Icon(Icons.notifications_rounded),
              notificationTaskList.length == 0
                  ? Container()
                  : SizedBox(
                      width: 15,
                      height: 15,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            notificationTaskList.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        backgroundColor: context.theme.backgroundColor,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await Get.to(() => AddTask());
              // _taskController.getTasks();
              getData();
              getLastNotificationData();
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'add task',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const Text(
            'your tasks ',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(() {
              if (taskList.isEmpty) {
                return Container(
                  child: const Text('no task'),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task = taskList[index];

                    String type = task.remindTime.toString().split(' ')[1];
                    var date = DateFormat.jm().parse(task.remindTime!);
                    var time = DateFormat('hh:mm').format(date);
                    int hour = int.parse(time.toString().split(':')[0]);
                    int minutes = int.parse(time.toString().split(':')[1]);

                    List<String> splitDate = task.date!.split('/');
                    DateTime dateTime = DateTime(
                        int.parse(splitDate[2]),
                        int.parse(splitDate[0]),
                        int.parse(splitDate[1]),
                        type == 'PM'
                            ? hour + 12
                            : hour == 12
                                ? 0
                                : hour,
                        minutes);
                    notifyScheduler(dateTime, task);
                    notifyHelper.scheduledNotify(
                        hour: type == 'PM'
                            ? hour + 12
                            : hour == 12
                                ? 0
                                : hour,
                        minutes: minutes,
                        task: task);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal,
                      ),
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          task.title!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          task.date!,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        trailing: Text(
                          task.remindTime!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
