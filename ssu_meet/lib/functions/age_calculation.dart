
int AgeCalculation(String val) {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime.now().day;
  int _age;


  int birthYear = int.parse(val.substring(0, 2));
  int birthMonth = int.parse(val.substring(2, 4));
  int birthDay = int.parse(val.substring(4, 6));

  if (birthYear >= 0 && birthYear <= 23) {
    _age = currentYear - (2000 + birthYear);
  } else {
    _age = currentYear - (1900 + birthYear);
  }
  if (birthMonth > currentMonth ||
      (birthMonth == currentMonth && birthDay > currentDay)) {
    _age--; //아직 생일이 안 지난 경우, 한 살 더 빼줌
  }
  return _age;
}
