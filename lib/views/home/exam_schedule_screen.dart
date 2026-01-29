import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart' show SemesterProvider;
import 'package:nlu_portal_app/views/widgets/schedule_items_widget.dart';
import 'package:provider/provider.dart';

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  int? selectedSemesterId;
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SemesterProvider>().loadSemesters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Lịch thi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: Consumer<SemesterProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField(
                  initialValue: selectedSemesterId,
                  items: provider.semesters
                      .map(
                        (semester) => DropdownMenuItem(
                          value: semester.semesterId,
                          child: Text(semester.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSemesterId = val;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: AppColors.primary,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '---------------Chọn học kỳ----------------',
                  ),
                );
              }
            ),
          ),
          Expanded(child: ScheduleItemsWidget()),
        ],
      ),
    );
  }
}
