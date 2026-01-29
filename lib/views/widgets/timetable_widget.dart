import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';

class TimetableItemsWidget extends StatefulWidget {
  const TimetableItemsWidget({super.key});

  @override
  State<TimetableItemsWidget> createState() => _TimetableItemsWidgetState();
}

class _TimetableItemsWidgetState extends State<TimetableItemsWidget> {

  @override
  void initState() {
    super.initState();
    // Provider.of<CourseProvider>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
  // final courseProvider = Provider.of<CourseProvider>(context);
  // final subjects = courseProvider.subjects;
  final subjects = 5;
  final subjectName = "Thực tập lập trình trên thiết bị di động";
  final classPeriod = "1-3";
  final room = "RD304";
  final lecturer = "Võ Tấn Toàn";

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: subjects,
      itemBuilder: (context, index) {
        // final student = subjects[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Column(
            children: [
              buildSubjectCard(
                subjectName: subjectName,
                periodTime: classPeriod,
                room: room,
                lecturer: lecturer,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSubjectCard({
    required String subjectName,
    required String periodTime,
    required String room,
    required String lecturer,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subjectName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            buildDetailRow('Tiết :', periodTime),
            buildDetailRow('Phòng :', room),
            buildDetailRow('Giảng viên :', lecturer),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}