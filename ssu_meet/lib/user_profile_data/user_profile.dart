class UserProfile {
  String sex; //성별
  String birthDate; //생년월일
  int age; //나이
  String college; //단과대
  String major; //전공
  int height; //키
  String? instaId; //인스타
  String? kakaoId; //카카오
  String? phoneNumber; //전화번호

  UserProfile({
    required this.sex,
    required this.birthDate,
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
        "birthDate": birthDate,
        "age": age,
        "college": college,
        "major": major,
        "height": height,
        "instaId": (instaId != '') ? instaId : null, // SNS는 3개 중 1개 이상 입력
        "kakaoId": (kakaoId != '') ? kakaoId : null,
        "phoneNumber": (phoneNumber != '') ? phoneNumber : null,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    print("json: $json");
    return UserProfile(
      sex: (json['sex'] == "MALE") ? "남" : "여",
      birthDate: json['birthDate'],
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
