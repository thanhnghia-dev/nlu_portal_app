import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/timetable_model.dart';
import 'package:nlu_portal_app/providers/timetable_provider.dart';
import 'package:provider/provider.dart';

class TimetableItemsWidget extends StatefulWidget {
  const TimetableItemsWidget({super.key});

  @override
  State<TimetableItemsWidget> createState() => _TimetableItemsWidgetState();
}

class _TimetableItemsWidgetState extends State<TimetableItemsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimetableProvider>().loadTimetable();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TimetableProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final allTimetables = provider.timetablesBySelectedDate;

    if (allTimetables.isEmpty) {
      return const Center(
        child: Text(
          'Hôm nay không có môn học nào',
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
      itemCount: allTimetables.length,
      itemBuilder: (context, index) {
        final timetable = allTimetables[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Column(children: [buildSubjectCard(timetable: timetable)]),
        );
      },
    );
  }

  Widget buildSubjectCard({required Timetable timetable}) {
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
              timetable.subjectName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            buildDetailRow('Tiết :', timetable.periodRange),
            buildDetailRow('Phòng :', timetable.roomId),
            buildDetailRow('Giảng viên :', timetable.lecturerName),
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
            style: const TextStyle(fontSize: 16, color: Colors.black),
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
