import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_app/controller/controller.dart';
import 'package:notification_app/models/reminder.dart';

class NotifictionScreen extends StatefulWidget {
  const NotifictionScreen({Key? key, required this.txt}) : super(key: key);
  final String txt;

  @override
  State<NotifictionScreen> createState() => _NotifictionScreenState();
}

class _NotifictionScreenState extends State<NotifictionScreen> {
  @override
  void initState() {
    super.initState();
    makeTaskRead();
  }

  makeTaskRead() async {
    await ReminderController().makeTaskRead(Reminder(
      id: int.parse(widget.txt.toString().split('-')[4]),
      title: widget.txt.toString().split('-')[0],
      date: widget.txt.toString().split('-')[2],
      remindTime: widget.txt.toString().split('-')[3],
      isRead: 1,
      note: widget.txt.toString().split('-')[1],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: context.theme.backgroundColor,
        title: Text(widget.txt.toString().split('-')[0]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(25.0),
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.title_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.txt.toString().split('-')[0],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.note_add_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Your Note',
                        style: TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.txt.toString().split('-')[1],
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.calendar_month_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Date',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.txt.toString().split('-')[2],
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15)),
                      ],
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.access_time_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Time',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.txt.toString().split('-')[3],
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
