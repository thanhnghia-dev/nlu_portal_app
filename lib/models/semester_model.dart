class Semester {
  final int semesterId;
  final String name;
  final bool isAdvisor;
  final int isPresence;
  
  Semester({
    required this.semesterId,
    required this.name,
    required this.isAdvisor,
    required this.isPresence,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterId: json['hoc_ky'],
      name: json['ten_hoc_ky'],
      isAdvisor: json['is_cvht'],
      isPresence: json['hiendiensv'],
    );
  }
}