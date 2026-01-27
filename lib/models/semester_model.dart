class Semester {
  final int semesterId;
  final String name;
  final bool isAdvisor;
  final int isPresence;
  final String startDate;
  final String endDate;
  
  Semester({
    required this.semesterId,
    required this.name,
    required this.isAdvisor,
    required this.isPresence,
    required this.startDate,
    required this.endDate,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterId: json['hoc_ky'],
      name: json['ten_hoc_ky'],
      isAdvisor: json['is_cvht'],
      isPresence: json['hiendiensv'],
      startDate: json['ngay_bat_dau_hk'],
      endDate: json['ngay_ket_thuc_hk'],
    );
  }
}