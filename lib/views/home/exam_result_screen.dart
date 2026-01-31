import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart';
import 'package:nlu_portal_app/views/widgets/score_items_widget.dart';
import 'package:provider/provider.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({super.key});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
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
          'Điểm thi',
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
              },
            ),
          ),
          Expanded(child: ScoreItemsWidget()),
        ],
      ),
    );
  }
}
