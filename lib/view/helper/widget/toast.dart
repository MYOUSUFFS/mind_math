import 'package:flutter/material.dart';

myMsg(BuildContext context, {String? title, Color? color, IconData? icon}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 150),
        backgroundColor: Colors.transparent,
        content: ToastedTile(
          title: title ?? 'msg',
          color: color,
          icon: icon ?? Icons.error,
        ),
      ),
    );

class ToastedTile extends StatelessWidget {
  const ToastedTile(
      {super.key, this.color = Colors.red, required this.title, this.icon});
  final Color? color;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(10)),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
          ],
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
