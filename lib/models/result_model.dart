class SemesterResult {
  final int majorType;
  final String semesterId;
  final String semesterName;
  final String averageScore10;
  final String averageScore4;
  final String gpa10;
  final String gpa4;
  final String semesterCredits;
  final String cumulativeCredits;
  final String semesterRank;
  final List<SubjectScore> subjectSoreList;
  bool get isRevered => semesterId == "0";

  SemesterResult({
    required this.majorType,
    required this.semesterId,
    required this.semesterName,
    required this.averageScore10,
    required this.averageScore4,
    required this.gpa10,
    required this.gpa4,
    required this.semesterCredits,
    required this.cumulativeCredits,
    required this.semesterRank,
    required this.subjectSoreList,
  });

  factory SemesterResult.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic value) {
      if (value == null) return "0";
      if (value.toString().trim().isEmpty) return "0";
      return value.toString();
    }

    return SemesterResult(
      majorType: json['loai_nganh'] ?? 0,
      semesterId: json['hoc_ky'] ?? '',
      semesterName: json['ten_hoc_ky'] ?? '',
      averageScore10: parseString(json['dtb_hk_he10']),
      averageScore4: parseString(json['dtb_hk_he4']),
      gpa10: parseString(json['dtb_tich_luy_he_10']),
      gpa4: parseString(json['dtb_tich_luy_he_4']),
      semesterCredits: parseString(json['so_tin_chi_dat_hk']),
      cumulativeCredits: parseString(json['so_tin_chi_dat_tich_luy']),
      semesterRank: json['xep_loai_tkb_hk'] ?? '',
      subjectSoreList: (json['ds_diem_mon_hoc'] as List? ?? [])
          .map((e) => SubjectScore.fromJson(e))
          .toList(),
    );
  }
}

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
