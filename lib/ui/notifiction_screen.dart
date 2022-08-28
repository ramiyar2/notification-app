import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifictionScreen extends StatefulWidget {
  NotifictionScreen({Key? key, required this.txt}) : super(key: key);
  String txt;

  @override
  State<NotifictionScreen> createState() => _NotifictionScreenState();
}

class _NotifictionScreenState extends State<NotifictionScreen> {
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
        child: Expanded(
          child: ListTile(
            title: Text(widget.txt.toString().split('-')[0]),
            subtitle: Text(widget.txt.toString().split('-')[1]),
            leading: Text(widget.txt.toString().split('-')[2]),
          ),
        ),
      ),
    );
  }
}
