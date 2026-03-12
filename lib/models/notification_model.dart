class NotificationAdmin {
  final String title;
  final String content;
  final DateTime sendDate;
  
  NotificationAdmin({
    required this.title,
    required this.content,
    required this.sendDate,
  });

  factory NotificationAdmin.fromJson(Map<String, dynamic> json) {
    return NotificationAdmin(
      title: json['tieu_de'],
      content: json['noi_dung'],
      sendDate: DateTime.parse(json['ngay_gui']),
    );
  }
}