// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int? id;
  String? title;
  String? date;
  String? remindTime;
  String? note;
  Task({this.id, this.title, this.date, this.note, this.remindTime});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date,
      'note': note,
      'remindTime': remindTime,
    };
  }

  Task.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    date = map['date'];
    note = map['note'];
    remindTime = map['remindTime'];
  }

  // Function for debuge mode only
  @override
  String toString() {
    return 'Task(id = $id,title = $title,date = $date,note: $note, remindTime = $remindTime)';
  }
}
