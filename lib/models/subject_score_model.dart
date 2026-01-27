class SubjectScore {
  final String subjectId;
  final String subjectName;
  final String creditNumber;
  final String examScore;
  final String midtermScore;
  final String finalScore10;
  final String finalScore4;
  final String rating;
  
  SubjectScore({
    required this.subjectId,
    required this.subjectName,
    required this.creditNumber,
    required this.examScore,
    required this.midtermScore,
    required this.finalScore10,
    required this.finalScore4,
    required this.rating,
  });

  factory SubjectScore.fromJson(Map<String, dynamic> json) {
    return SubjectScore(
      subjectId: json['ma_mon'],
      subjectName: json['ten_mon'],
      creditNumber: json['so_tin_chi'],
      examScore: json['diem_thi'],
      midtermScore: json['diem_giua_ky'],
      finalScore10: json['diem_tk'],
      finalScore4: json['diem_tk_so'],
      rating: json['diem_tk_chu'],
    );
  }
}