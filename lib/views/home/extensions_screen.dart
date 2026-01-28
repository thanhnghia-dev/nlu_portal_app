import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/views/home/exam_schedule_screen.dart';
import 'package:nlu_portal_app/views/home/exam_score_screen.dart';

class ExtensionsScreen extends StatefulWidget {
  const ExtensionsScreen({super.key});

  @override
  State<ExtensionsScreen> createState() => _ExtensionsScreenState();
}

class _ExtensionsScreenState extends State<ExtensionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Tiện ích',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.calendar_today_rounded,
              title: 'Lịch thi',
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => const ExamScheduleScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.score_rounded,
              title: 'Điểm thi',
              onTap: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => const ExamScoreScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Menu Items
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppColors.borderContainer, width: 1),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.primary,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
