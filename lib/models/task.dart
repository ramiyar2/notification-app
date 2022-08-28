// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int? id;
  String? title;
  String? date;
  String? remindTime;
  Task({this.id, this.title, this.date, this.remindTime});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date,
      'remindTime': remindTime,
    };
  }

  Task.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    date = map['date'];
    remindTime = map['remindTime'];
  }

  // Function for debuge mode only
  @override
  String toString() {
    return 'Task(id = $id,title = $title,date = $date,remindTime = $remindTime)';
  }
}
