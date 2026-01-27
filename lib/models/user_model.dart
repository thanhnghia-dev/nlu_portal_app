class User {
  final String studentId;
  final String fullName;
  final String gender;
  final String birthDate;
  final String birthPlace;
  final String phoneNumber;
  final String address;
  final String classroom;
  final String major;
  final String specialized;
  final String faculty;
  final String schoolYear;
  final String presence;

  User({
    required this.studentId,
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.birthPlace,
    required this.phoneNumber,
    required this.address,
    required this.classroom,
    required this.major,
    required this.specialized,
    required this.faculty,
    required this.schoolYear,
    required this.presence,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      studentId: json['ma_sv'],
      fullName: json['ten_day_du'],
      gender: json['gioi_tinh'],
      birthDate: json['ngay_sinh'],
      birthPlace: json['noi_sinh'],
      phoneNumber: json['dien_thoai'],
      address: json['ho_khau_thuong_tru_gd'],
      classroom: json['lop'],
      major: json['nganh'],
      specialized: json['chuyen_nganh'],
      faculty: json['khoa'],
      schoolYear: json['nien_khoa'],
      presence: json['hien_dien_sv'],
    );
  }
}
