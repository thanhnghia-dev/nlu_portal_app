import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart';
import 'package:nlu_portal_app/views/widgets/score_items_widget.dart';
import 'package:provider/provider.dart';

class ExamScoreScreen extends StatefulWidget {
  const ExamScoreScreen({super.key});

  @override
  State<ExamScoreScreen> createState() => _ExamScoreScreenState();
}

class _ExamScoreScreenState extends State<ExamScoreScreen> {
  String? selectedSemester;

  @override
  void initState() {
    super.initState();
    Provider.of<SemesterProvider>(context, listen: false).loadSemesters();
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
                  initialValue: selectedSemester,
                  items: provider.semesters
                      .map(
                        (semester) => DropdownMenuItem(
                          value: semester.name,
                          child: Text(semester.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSemester = val;
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
          ScoreItemsWidget(),
        ],
      ),
    );
  }
}
