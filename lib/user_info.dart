import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    super.key,
    required this.id,
    required this.phone,
    required this.name,
    required this.onDeletePressed,
    required this.onEditPressed,
  });
  final String name, phone, id;
  final void Function() onDeletePressed, onEditPressed;

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
            radius: 20.0,
            child: Text(
              widget.id,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const Spacer(),
        IconButton(
          onPressed: widget.onEditPressed,
          icon: const Icon(Icons.edit),
          color: Colors.blue,
        ),
        IconButton(
          onPressed: widget.onDeletePressed,
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
        ),
      ],
    );
  }
}
