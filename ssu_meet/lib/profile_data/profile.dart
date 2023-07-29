class MyData {
  String sex; //성별
  String birth; //생년월일
  int? age; //나이
  String college; //단과대
  String major; //전공
  int height; //키
  String? instaId; //인스타
  String? kakaoId; //카카오
  String? phoneNumber; //전화번호


  MyData({
    required this.sex,
    required this.birth,
    required this.age,
    required this.college,
    required this.major,
    required this.height,
    required this.instaId,
    required this.kakaoId,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "sex": (sex == "남") ? "MALE" : "FEMALE",
    "birth": birth,
    "age": age,
    "college": college,
    "major": major,
    "height": height,
    "instaId": (instaId != '') ? instaId : null, // SNS는 3개 중 1개 이상 입력
    "kakaoId": (kakaoId != '') ? kakaoId : null,
    "phoneNumber": (phoneNumber != '') ? phoneNumber : null,
  };

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      sex: (json['sex'] == "MALE") ? "남" : "여",
      birth: json['birth'],
      age: json['age'],
      college: json['college'],
      major: json['major'],
      height: json['height'],
      instaId: (json['instaId'] == null) ? "" : json["instaId"],
      kakaoId: (json['kakaoId'] == null) ? "" : json['kakaoId'],
      phoneNumber: (json['phoneNumber'] == null) ? "" : json['phoneNumber'],
    );
  }
}