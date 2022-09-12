import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_app/controller/controller.dart';
import 'package:intl/intl.dart';
import 'package:notification_app/models/task.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String reminderTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: context.theme.backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your title',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.teal,
                    width: 1,
                  ),
                ),
              ),
              controller: title,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Note',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Note',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.teal,
                    width: 1,
                  ),
                ),
              ),
              controller: note,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'date and time',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () => selectDate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat.yMd().format(selectedDate)),
                          const Icon(Icons.calendar_today_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () => selectTime(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(reminderTime),
                          const Icon(Icons.timer_rounded)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: checkData,
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Add task',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkData() {
    if (title.text.isNotEmpty || note.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else {
      Get.snackbar('Error', '404 Error');
    }
  }

  _addTaskToDb() async {
    try {
      int value = await _taskController.addTask(
        task: Task(
            title: title.text,
            note: note.text,
            date: DateFormat.yMd().format(selectedDate),
            remindTime: reminderTime),
      );
      print(value);
    } catch (e) {
      print(e);
    }
  }

  selectDate() async {
    DateTime? pikedTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (pikedTime != null) {
      setState(() => selectedDate = pikedTime);
    }
  }

  selectTime() async {
    TimeOfDay? pikedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pikedTime != null) {
      setState(() => reminderTime = pikedTime.format(context).toString());
    }
  }
}
