import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_app/controller/controller.dart';
import 'package:notification_app/models/reminder.dart';

import 'notifiction_screen.dart';

class LastNotfiy extends StatefulWidget {
  const LastNotfiy({Key? key}) : super(key: key);

  @override
  State<LastNotfiy> createState() => _LastNotfiyState();
}

class _LastNotfiyState extends State<LastNotfiy> {
  RxList<Reminder> taskList = <Reminder>[].obs;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var tasks = await ReminderController().getTasks();
    setState(() => taskList = tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Your Notification ',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
                if (taskList.isEmpty) {
                  return const Text('no tasks');
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Reminder task = taskList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              task.isRead == 0 ? Colors.teal : Colors.black87,
                        ),
                        width: double.infinity,
                        child: ListTile(
                          onTap: () async {
                            await Get.to(NotifictionScreen(
                                txt:
                                    '${task.title}-${task.note}-${task.date}-${task.remindTime}-${task.id}'));
                            getData();
                          },
                          title: Text(
                            task.title!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            task.date!,
                            style: const TextStyle(color: Colors.white54),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              ReminderController().deletTask(reminder: task);
                              getData();
                            },
                            icon: const Icon(Icons.task_alt_outlined,
                                color: Colors.white),
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
      ),
    );
  }
}
