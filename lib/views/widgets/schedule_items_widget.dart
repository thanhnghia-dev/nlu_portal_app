import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/exam_schedule_model.dart';
import 'package:nlu_portal_app/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ScheduleItemsWidget extends StatefulWidget {
  const ScheduleItemsWidget({super.key});

  @override
  State<ScheduleItemsWidget> createState() => _ScheduleItemsWidgetState();
}

class _ScheduleItemsWidgetState extends State<ScheduleItemsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduleProvider>().loadSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final schedules = provider.schedules;

    if (schedules.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có lịch thi.',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Column(children: [buildScheduleCard(schedule: schedule)]),
        );
      },
    );
  }

  Widget buildScheduleCard({required ExamSchedule schedule}) {
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
              schedule.subjectName,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            buildDetailRow('Mã môn học :', schedule.subjectId),
            buildDetailRow('Ngày thi :', schedule.examDate),
            buildDetailRow('Tiết :', schedule.periodRange),
            buildDetailRow('Phòng :', schedule.roomId),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
