import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/core/utils/overlay_toast.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart'
    show SemesterProvider;
import 'package:nlu_portal_app/providers/user_provider.dart';
import 'package:nlu_portal_app/views/widgets/schedule_items_widget.dart';
import 'package:provider/provider.dart';

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  int? selectedSemesterId;

  // Reload Button
  void _reloadButton() {
    showOverlayToast(context, "Chờ xíu....");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getUserInfo();
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _reloadButton,
            icon: Icon(Icons.sync, size: 30),
          ),
        ],
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
                return DropdownButtonFormField<int>(
                  value:
                      provider.selectedSemesterId != null &&
                          provider.semesters.any(
                            (e) => e.semesterId == provider.selectedSemesterId,
                          )
                      ? provider.selectedSemesterId
                      : null,
                  menuMaxHeight: 400,
                  isExpanded: true,

                  items: provider.semesters
                      .map(
                        (semester) => DropdownMenuItem<int>(
                          value: semester.semesterId,
                          child: Text(
                            semester.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),

                  onChanged: (val) {
                    setState(() {
                      selectedSemesterId = val;
                    });

                    if (val != null) {
                      context.read<SemesterProvider>().setSelectedSemester(val);
                    }
                  },

                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: AppColors.primary,
                  ),

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Học kỳ',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: ScheduleItemsWidget()),
        ],
      ),
    );
  }
}
