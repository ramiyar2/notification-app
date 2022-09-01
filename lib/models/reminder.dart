// ignore_for_file: public_member_api_docs, sort_constructors_first
class Reminder {
  int? id;
  String? title;
  String? date;
  String? note;
  String? remindTime;
  int? isRead;
  Reminder(
      {this.id,
      this.title,
      this.date,
      this.note,
      this.remindTime,
      this.isRead});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date,
      'note': note,
      'remindTime': remindTime,
      'isRead': isRead,
    };
  }

  Reminder.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    date = map['date'];
    note = map['note'];
    remindTime = map['remindTime'];
    isRead = map['isRead'];
  }

  // Function for debuge mode only
  @override
  String toString() {
    return 'Task(id = $id,title = $title,date = $date,note: $note,remindTime = $remindTime,isRead = $isRead)';
  }
}
