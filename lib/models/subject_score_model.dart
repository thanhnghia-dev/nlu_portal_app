class SubjectScore {
  final String subjectId;
  final String subjectName;
  final String creditNumber;
  final String examScore;
  final String midtermScore;
  final String finalScore10;
  final String finalScore4;
  final String rating;
  final int noScoreCounted;

  SubjectScore({
    required this.subjectId,
    required this.subjectName,
    required this.creditNumber,
    required this.examScore,
    required this.midtermScore,
    required this.finalScore10,
    required this.finalScore4,
    required this.rating,
    required this.noScoreCounted,
  });

  factory SubjectScore.fromJson(Map<String, dynamic> json) {
    return SubjectScore(
      subjectId: json['ma_mon']?.toString() ?? '',
      subjectName: json['ten_mon']?.toString() ?? '',
      creditNumber: json['so_tin_chi']?.toString() ?? '',
      examScore: json['diem_thi']?.toString() ?? '',
      midtermScore: json['diem_giua_ky']?.toString() ?? '',
      finalScore10: json['diem_tk']?.toString() ?? '',
      finalScore4: json['diem_tk_so']?.toString() ?? '',
      rating: json['diem_tk_chu']?.toString() ?? '',
      noScoreCounted: json['khong_tinh_diem_tbtl'] ?? 0,
    );
  }
}
