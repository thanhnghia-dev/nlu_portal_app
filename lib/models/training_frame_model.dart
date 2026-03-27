class MajorStudent {
  final String majorId;
  final String majorName;

  MajorStudent({required this.majorId, required this.majorName});

  factory MajorStudent.fromJson(Map<String, dynamic> json) {
    return MajorStudent(
      majorId: json['ma_nganh'] ?? '',
      majorName: json['ten_nganh'] ?? '',
    );
  }
}

class TrainingSemester {
  final String semesterId;
  final String semesterName;
  final List<TrainingSubject> trainingSubjectList;

  TrainingSemester({
    required this.semesterId,
    required this.semesterName,
    required this.trainingSubjectList,
  });

  factory TrainingSemester.fromJson(Map<String, dynamic> json) {
    return TrainingSemester(
      semesterId: json['hoc_ky'] ?? '',
      semesterName: json['ten_hoc_ky'] ?? '',
      trainingSubjectList: (json['ds_CTDT_mon_hoc'] as List? ?? [])
          .map((e) => TrainingSubject.fromJson(e))
          .toList(),
    );
  }
}

class TrainingSubject {
  final String subjectId;
  final String subjectName;
  final int creditNumber;
  final String isCompulsory;
  final int selfSelectGroup;
  final int theoryPeriod;
  final int practicePeriod;
  final bool studiedSubject;
  final bool passSubject;

  TrainingSubject({
    required this.subjectId,
    required this.subjectName,
    required this.creditNumber,
    required this.isCompulsory,
    required this.selfSelectGroup,
    required this.theoryPeriod,
    required this.practicePeriod,
    required this.studiedSubject,
    required this.passSubject,
  });

  /// ================= HELPER =================

  static int _parseInt(dynamic value) {
    final str = value?.toString().trim() ?? '';
    return int.tryParse(str) ?? 0;
  }

  static String _parseText(dynamic value) {
    return value?.toString() ?? '';
  }

  static bool _parseBool(dynamic value) {
    return value?.toString().toLowerCase() == 'x';
  }

  /// ================= FACTORY =================

  factory TrainingSubject.fromJson(Map<String, dynamic> json) {
    return TrainingSubject(
      subjectId: _parseText(json['ma_mon']),
      subjectName: _parseText(json['ten_mon']),
      creditNumber: _parseInt(json['so_tin_chi']),
      isCompulsory: json['mon_bat_buoc'],
      selfSelectGroup: _parseInt(json['nhom_tc']),
      theoryPeriod: _parseInt(json['ly_thuyet']),
      practicePeriod: _parseInt(json['thuc_hanh']),
      studiedSubject: _parseBool(json['mon_da_hoc']),
      passSubject: _parseBool(json['mon_da_dat']),
    );
  }
}
