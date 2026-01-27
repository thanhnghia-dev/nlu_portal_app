import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          'Thông tin sinh viên',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFLHz0vltSz4jyrQ5SmjyKiVAF-xjpuoHcCw&s',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            (user?.fullName.trim().isNotEmpty ?? false)
                ? user!.fullName
                : 'Trống',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildInfoRow('Trạng thái', user?.presence, highlight: true),
                    buildInfoRow('MSSV', user?.studentId),
                    buildInfoRow('Khoa', user?.faculty),
                    buildInfoRow('Lớp', user?.classroom),
                    buildInfoRow('Niên khóa', user?.schoolYear),
                    buildInfoRow('Ngành', user?.major),
                    buildInfoRow('Chuyên ngành', user?.specialized),
                    buildInfoRow('Ngày sinh', user?.birthDate),
                    buildInfoRow('Giới tính', user?.gender),
                    buildInfoRow('Nơi sinh', user?.birthPlace),
                    buildInfoRow('Số điện thoại', user?.phoneNumber),
                    buildInfoRow(
                      'Địa chỉ thường trú',
                      user?.address,
                      isMultiline: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Student Info
Widget buildInfoRow(
  String label,
  String? value, {
  bool highlight = false,
  bool isMultiline = false,
}) {
  final displayValue =
      (value == null || value.trim().isEmpty) ? 'Trống' : value;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: isMultiline
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ),
        const Text(':  '),
        Expanded(
          child: Text(
            displayValue,
            style: TextStyle(
              fontSize: 15,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: displayValue == 'Trống'
                  ? Colors.grey
                  : (highlight ? AppColors.primary : Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
