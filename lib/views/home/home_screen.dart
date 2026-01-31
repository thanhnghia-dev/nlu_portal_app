import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/core/utils/util.dart';
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
  // Notification Button
  void _notificationButton() {
    showOverlayToast(context, "Chưa có thông báo nào");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getUserInfo();
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
          CalendarWidget(),
          Expanded(child: TimetableItemsWidget()),
        ],
      ),
    );
  }
}
