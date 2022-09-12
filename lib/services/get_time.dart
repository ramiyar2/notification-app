Duration getTime(DateTime taskDate) {
  var dateOfBirth = taskDate;
  var currentDate = DateTime.now();
  var different = dateOfBirth.difference(currentDate);
  print(different);
  return different;
}
