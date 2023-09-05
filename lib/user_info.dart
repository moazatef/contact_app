import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo(
      {super.key, required this.id, required this.phone, required this.name});
  final String name, phone, id;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 30.0,
            child: Text(
              widget.id,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.phone,
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
