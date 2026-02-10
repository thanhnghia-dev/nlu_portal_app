import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';

class ScoreItemsWidget extends StatelessWidget {
  const ScoreItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scores = 5;

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
              itemCount: scores,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildScoreDetailCard(
                      subjectName:
                          'Thực tập lập trình trên thiết bị di động',
                      subjectCode: '214293',
                      credits: 3,
                      score10: 9.0,
                      score4: 4.0,
                    ),
                    if (index < scores - 1) const Divider(color: AppColors.primary),
                  ],
                );
              },
            ),

            /// STATISTIC
            _buildStatisticCard(),
          ],
        ),
      ),
    );
  }

  // ================= SUBJECT =================

  Widget _buildScoreDetailCard({
    required String subjectName,
    required String subjectCode,
    required int credits,
    required double score10,
    required double score4,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subjectName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoRow('Mã môn học:', subjectCode),
              _infoRow('Số tín chỉ:', credits.toString()),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _scoreRow('Điểm hệ 10:', score10),
              _scoreRow('Điểm hệ 4:', score4),
            ],
          ),
        ],
      ),
    );
  }

  // ================= STATISTIC =================

  Widget _buildStatisticCard() {
    return Container(
      color: AppColors.borderContainer,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: const [
          _totalRow('Điểm TB học kỳ hệ 10:', '8.21'),
          Divider(),
          _totalRow('Điểm TB học kỳ hệ 4:', '3.46'),
          Divider(),
          _totalRow('Điểm TB tích lỹ hệ 10:', '6.76'),
          Divider(),
          _totalRow('Điểm TB tích lũy hệ 4:', '2.60'),
          Divider(),
          _totalRow('Số tín chỉ đạt', '13'),
          Divider(),
          _totalRow('Số tín chỉ tích lũy', '159'),
        ],
      ),
    );
  }

  // ================= SMALL WIDGET =================

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _scoreRow(String label, double value) {
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
