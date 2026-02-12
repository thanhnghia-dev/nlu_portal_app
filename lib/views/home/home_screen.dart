import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/core/utils/overlay_toast.dart';
import 'package:nlu_portal_app/providers/semester_provider.dart';
import 'package:nlu_portal_app/providers/user_provider.dart';
import 'package:nlu_portal_app/views/widgets/calendar_widget.dart';
import 'package:nlu_portal_app/views/widgets/timetable_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedSemesterId;

  // Notification Button
  void _notificationButton() {
    showOverlayToast(context, "Chưa có thông báo nào");
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
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Xin chào,',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Text(
              user?.fullName ?? '',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _notificationButton,
            icon: Icon(Icons.notifications, size: 30),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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

          CalendarWidget(),
          Expanded(child: TimetableItemsWidget()),
        ],
      ),
    );
  }
}
