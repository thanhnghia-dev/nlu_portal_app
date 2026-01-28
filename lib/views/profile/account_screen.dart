import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/user_model.dart';
import 'package:nlu_portal_app/providers/auth_provider.dart';
import 'package:nlu_portal_app/providers/user_provider.dart';
import 'package:nlu_portal_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:nlu_portal_app/views/profile/profile_screen.dart';
import 'package:nlu_portal_app/views/widgets/switch_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  
  // Support Request Button
  void _supportRequestButton() async {
    final Uri url = Uri.parse('https://forms.gle/uZWQkPR76EesGjZGA');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Không mở được link: $url';
    }
  }

  // Logout Button
  void _logoutButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Bạn có chắc muốn đăng xuất?',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Đóng'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.silverGray),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: const Text('Đóng'),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primary),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: const Text(
              'Đồng ý',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
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
        backgroundColor: AppColors.primary,
        title: const Text(
          'Cá nhân',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProfileCard(context, user),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
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
                            border: Border.all(
                              color: AppColors.borderContainer,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: Icons.badge_rounded,
                                title: 'Thông tin sinh viên',
                                onTap: () {
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ProfileScreen(),
                                    ),
                                  );
                                },
                              ),
                              _buildMenuItem(
                                icon: Icons.message_rounded,
                                title: 'Yêu cầu hỗ trợ/góp ý',
                                onTap: _supportRequestButton,
                              ),
                              _buildNotificationButton(
                                icon: Icons.notifications,
                                title: 'Thông báo',
                                actionWidget: const SwitchButtonWidget(),
                              ),
                              _buildMenuItem(
                                icon: Icons.logout,
                                title: 'Đăng xuất',
                                onTap: _logoutButton,
                              ),
                              _buildAppVersion(
                                icon: Icons.info_rounded,
                                title: 'Phiên bản ứng dụng',
                                version: '1.0.0',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile Card
  Widget _buildProfileCard(BuildContext context, User? user) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.borderContainer, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFLHz0vltSz4jyrQ5SmjyKiVAF-xjpuoHcCw&s',
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullName.trim().isNotEmpty == true
                        ? user!.fullName
                        : 'Trống',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'MSSV: ${(user?.studentId.trim().isNotEmpty ?? false) ? user!.studentId : 'Trống'}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Menu Items
Widget _buildMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primary),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}

// App version info
Widget _buildAppVersion({
  required IconData icon,
  required String title,
  required String version,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primary),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    trailing: Text(
      version,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}

// Notification button
Widget _buildNotificationButton({
  required IconData icon,
  required String title,
  required Widget actionWidget,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primary),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    trailing: actionWidget,
  );
}
