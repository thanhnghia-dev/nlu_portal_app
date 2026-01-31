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
    final scores = 5;
    final subjectName = "Thực tập lập trình trên thiết bị di động";
    final subjectCode = "214293";
    final credits = 3;
    final score10 = 9.0;
    final score4 = 4.0;

    final averageScore10 = "8.21";
    final averageScore4 = "3.46";
    final gpa10 = "6.76";
    final gpa4 = "2.6";
    final semesterCredits = "13";
    final cumulativeCredits = "159";

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 20, left: 10, right: 10),
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
        child: CustomScrollView(
          slivers: [
            /// LIST SCORE
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    buildScoreDetailCard(
                      subjectName: subjectName,
                      subjectCode: subjectCode,
                      credits: credits,
                      score10: score10,
                      score4: score4,
                    ),
                    const Divider(color: AppColors.primary),
                  ],
                );
              }, childCount: scores),
            ),

            /// STATISTIC CARD
            SliverToBoxAdapter(
              child: buildStatisticCard(
                averageScore10: averageScore10,
                averageScore4: averageScore4,
                gpa10: gpa10,
                gpa4: gpa4,
                semesterCredits: semesterCredits,
                cumulativeCredits: cumulativeCredits,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
          ],
        ),
      ),
    );
  }

  // Score Detail Card
  Widget buildScoreDetailCard({
    required String subjectName,
    required String subjectCode,
    required int credits,
    required double score10,
    required double score4,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subjectName,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
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

  // Score Statistic Card
  Widget buildStatisticCard({
    required String averageScore10,
    required String averageScore4,
    required String gpa10,
    required String gpa4,
    required String semesterCredits,
    required String cumulativeCredits,
  }) {
    return Container(
      color: AppColors.borderContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          buildTotalScoreRow('Điểm TB học kỳ hệ 10:', averageScore10),
          const Divider(color: Colors.black),
          buildTotalScoreRow('Điểm TB học kỳ hệ 4:', averageScore4),
          const Divider(color: Colors.black),
          buildTotalScoreRow('Điểm TB tích lũy hệ 10:', gpa10),
          const Divider(color: Colors.black),
          buildTotalScoreRow('Điểm TB tích lũy hệ 4:', gpa4),
          const Divider(color: Colors.black),
          buildTotalScoreRow('Số tín chỉ đạt:', semesterCredits),
          const Divider(color: Colors.black),
          buildTotalScoreRow('Số tín chỉ tích lũy:', cumulativeCredits),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Subject Info Item
  Widget buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Score Ingredient Item
  Widget buildScoreRow(String label, double value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  // Total Score Item
  Widget buildTotalScoreRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '$value ',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
