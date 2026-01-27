import 'package:nlu_portal_app/models/subject_score_model.dart';

class SemesterScore {
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
  
  SemesterScore({
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

  factory SemesterScore.fromJson(Map<String, dynamic> json) {
    return SemesterScore(
      majorType: json['loai_nganh'],
      semesterId: json['hoc_ky'],
      semesterName: json['ten_hoc_ky'],
      averageScore10: json['dtb_hk_he10'],
      averageScore4: json['dtb_hk_he4'],
      gpa10: json['dtb_tich_luy_he_10'],
      gpa4: json['dtb_tich_luy_he_4'],
      semesterCredits: json['so_tin_chi_dat_hk'],
      cumulativeCredits: json['so_tin_chi_dat_tich_luy'],
      semesterRank: json['xep_loai_tkb_hk'],
      subjectSoreList: json['ds_diem_mon_hoc'],
    );
  }
}