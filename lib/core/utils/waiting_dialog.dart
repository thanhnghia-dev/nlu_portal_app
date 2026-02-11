import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';

void showWaitingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Thông báo',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Chức năng đang phát triển, vui lòng quay lại sau.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: 180,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Đóng'),
          ),
        ),
      ],
    ),
  );
}
