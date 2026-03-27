import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/training_frame_model.dart';

class TrainingItemsWidget extends StatelessWidget {
  final TrainingSemester trainingSemester;

  const TrainingItemsWidget({super.key, required this.trainingSemester});

  @override
  Widget build(BuildContext context) {
    final frames = trainingSemester.trainingSubjectList;

    return Column(
      children: frames.map((frame) => _SubjectCard(frame: frame)).toList(),
    );
  }
}

// ================= CARD =================

class _SubjectCard extends StatelessWidget {
  final TrainingSubject frame;

  const _SubjectCard({required this.frame});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.borderContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE + CREDIT
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    frame.subjectName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _creditChip(frame.creditNumber),
              ],
            ),

            const SizedBox(height: 4),

            /// SUBJECT ID
            Row(
              children: [
                Text('Mã:', style: const TextStyle(color: Colors.grey)),
                SizedBox(width: 5),
                Text(
                  frame.subjectId,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// GRID INFO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem('Lý thuyết', frame.theoryPeriod),
                _infoItem('Thực hành', frame.practicePeriod),
                _infoItem('Nhóm', frame.selfSelectGroup),
              ],
            ),

            const SizedBox(height: 10),

            /// STATUS ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _compulsoryChip(frame.isCompulsory),
                _passStatus(frame.passSubject),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMPONENTS =================

  Widget _creditChip(int credit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$credit tín chỉ',
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
    );
  }

  Widget _infoItem(String label, dynamic value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _compulsoryChip(String value) {
    final isCompulsory = value.toLowerCase() == 'x';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isCompulsory ? Colors.green.withOpacity(0.1) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isCompulsory ? 'Bắt buộc' : 'Tự chọn',
        style: TextStyle(
          color: isCompulsory ? Colors.green : Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _passStatus(bool value) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          value ? 'Đạt' : 'Chưa đạt',
          style: TextStyle(
            color: value ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
