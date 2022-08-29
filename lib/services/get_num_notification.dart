import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../models/reminder.dart';

class GetNotification extends StatefulWidget {
  const GetNotification({Key? key}) : super(key: key);

  @override
  State<GetNotification> createState() => _NotificationState();
}

class _NotificationState extends State<GetNotification> {
  RxList<Reminder> notificationTaskList = <Reminder>[].obs;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 2), (Timer t) => getLastNotificationData());
  }

  getLastNotificationData() async {
    RxList<Reminder> tasks = await ReminderController().getTasks();
    print('notificationTaskList.length = ${notificationTaskList.length}');
    setState(() => notificationTaskList = tasks);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
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
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
