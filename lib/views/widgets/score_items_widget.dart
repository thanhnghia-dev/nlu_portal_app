import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/semester_result_model.dart';
import 'package:nlu_portal_app/models/subject_score_model.dart';

class ScoreItemsWidget extends StatelessWidget {
  final SemesterResult semesterResult;

  const ScoreItemsWidget({super.key, required this.semesterResult});

  @override
  Widget build(BuildContext context) {
    final scores = semesterResult.subjectSoreList;

    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderContainer),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            /// LIST SUBJECT
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: scores.length,
              itemBuilder: (context, index) {
                final score = scores[index];
                return Column(
                  children: [
                    _buildScoreDetailCard(score: score),
                    if (index < scores.length - 1)
                      const Divider(color: AppColors.primary),
                  ],
                );
              },
            ),

            /// STATISTIC
            if (!semesterResult.isRevered)
              _buildStatisticCard(semesterResult: semesterResult),
          ],
        ),
      ),
    );
  }

  // ================= SUBJECT =================

  Widget _buildScoreDetailCard({required SubjectScore score}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            score.subjectName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow('Mã môn học:', score.subjectId),
              _infoRow('Số tín chỉ:', score.creditNumber.toString()),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _scoreRow('Điểm hệ 10:', score.finalScore10),
              _scoreRow('Điểm hệ 4:', score.finalScore4),
            ],
          ),
        ],
      ),
    );
  }

  // ================= STATISTIC =================

  Widget _buildStatisticCard({required SemesterResult semesterResult}) {
    return Container(
      color: AppColors.borderContainer,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _totalRow('Điểm TB học kỳ hệ 10:', semesterResult.averageScore10),
          Divider(),
          _totalRow('Điểm TB học kỳ hệ 4:', semesterResult.averageScore4),
          Divider(),
          _totalRow('Điểm TB tích lỹ hệ 10:', semesterResult.gpa10),
          Divider(),
          _totalRow('Điểm TB tích lũy hệ 4:', semesterResult.gpa4),
          Divider(),
          _totalRow('Số tín chỉ đạt:', semesterResult.semesterCredits),
          Divider(),
          _totalRow('Số tín chỉ tích lũy:', semesterResult.cumulativeCredits),
        ],
      ),
    );
  }

  // ================= SMALL WIDGET =================

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _scoreRow(String label, String value) {
    final parsed = double.tryParse(value);

    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          parsed != null ? parsed.toStringAsFixed(1) : value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: parsed != null ? Colors.red : Colors.orange,
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class _totalRow extends StatelessWidget {
  final String label;
  final String value;

  const _totalRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
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
