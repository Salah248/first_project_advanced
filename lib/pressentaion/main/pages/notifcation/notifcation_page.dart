import 'package:easy_localization/easy_localization.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(AppStrings.notifications.tr()),
    );
  }
}