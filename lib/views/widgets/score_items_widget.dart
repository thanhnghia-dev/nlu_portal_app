import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';

class ScoreItemsWidget extends StatefulWidget {
  const ScoreItemsWidget({super.key});

  @override
  State<ScoreItemsWidget> createState() => _ScoreItemsWidgetState();
}

class _ScoreItemsWidgetState extends State<ScoreItemsWidget> {

  @override
  void initState() {
    super.initState();
    // Provider.of<CourseProvider>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
  // final courseProvider = Provider.of<CourseProvider>(context);
  // final courses = courseProvider.courses;
  final scores = 15;
  final subjectName = "Thực tập lập trình trên thiết bị di động";
  final subjectCode = "214293";
  final credits = 3;
  final score10 = 9.0;
  final score4 = 4.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: AppColors.borderContainer, width: 1),
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: scores,
            itemBuilder: (context, index) {
              // final student = scores[index];
              return Column(
                children: [
                  buildSubjectCard(subjectName: subjectName, subjectCode: subjectCode, 
                                   credits: credits, score10: score10, score4: score4),
                  if (index < scores - 1) const Divider(color: AppColors.primary,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildSubjectCard({
    required String subjectName,
    required String subjectCode,
    required int credits,
    required double score10,
    required double score4,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subjectName,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInfoRow('Mã môn học:', subjectCode),
              buildInfoRow('Số tín chỉ:', credits.toString()),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildScoreRow('Điểm hệ 10:', score10),
              buildScoreRow('Điểm hệ 4:', score4),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildScoreRow(String label, double value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}