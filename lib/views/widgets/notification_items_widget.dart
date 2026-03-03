import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/notification_model.dart';
import 'package:nlu_portal_app/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationItemsWidget extends StatefulWidget {
  const NotificationItemsWidget({super.key});

  @override
  State<NotificationItemsWidget> createState() =>
      _NotificationItemsWidgetState();
}

class _NotificationItemsWidgetState extends State<NotificationItemsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final notifications = provider.notifications;

    if (notifications.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có thông báo nào',
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
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Column(
            children: [buildNotifcationCard(notification: notification)],
          ),
        );
      },
    );
  }

  Widget buildNotifcationCard({required NotificationAdmin notification}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
              notification.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Linkify(
              text: notification.content.replaceAll(RegExp(r'<[^>]*>'), ''),
              style: const TextStyle(fontSize: 18, color: Colors.black),
              linkStyle: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              onOpen: (link) async {
                final uri = Uri.parse(link.url);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
