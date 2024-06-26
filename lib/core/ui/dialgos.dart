import 'package:barber_admin/core/app/app_colors.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/staff.dart';
import 'package:barber_admin/features/auth/widgets/add_service_content.dart';
import 'package:barber_admin/features/auth/widgets/add_staff_content.dart';
import 'package:flutter/material.dart';


sealed class Dialogs {
  const Dialogs._();

  static Future<bool> showTestDialog(BuildContext context) {
    return _showConfirmDialog(
      context,
      title: 'Unlock task',
      message: 'This task is locked. In order to be selected, '
          'it needs to be unlocked first. Do you want to proceed?',
      confirmText: 'Unlock',
    );
  }

  static Future showAddServiceDialog(BuildContext context, {BarberService? service}) async {
    return await showDialog< BarberService>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AddServiceContent(service: service),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.greyColor.withOpacity(0.4)),
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future showAddEditStaffDialog(BuildContext context, {Staff? staff}) async {
    return await showDialog<Staff>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AddStaffContent(staff: staff),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.greyColor.withOpacity(0.4)),
                  ),
                  child: Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  static Future<bool> _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    bool isDelete = false,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.secondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor:
                  isDelete ? AppColors.redColor : AppColors.secondaryColor,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              confirmText,
            ),
          ),
        ],
      ),
    );
  }
}
