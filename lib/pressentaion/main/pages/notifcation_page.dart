import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class NotifcationsPage extends StatefulWidget {
  const NotifcationsPage({super.key});

  @override
  State<NotifcationsPage> createState() => _NotifcationsPageState();
}

class _NotifcationsPageState extends State<NotifcationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.notifications),
    );
  }
}