import 'package:flutter/material.dart';

class OpenCloseWidget extends StatefulWidget {
  const OpenCloseWidget({
    super.key,
    required this.child,
    required this.title,
  });
  final Widget child;
  final Widget title;
  @override
  State<OpenCloseWidget> createState() => _OpenCloseWidgetState();
}

class _OpenCloseWidgetState extends State<OpenCloseWidget> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      InkWell(
        onTap: () {
          isOpen = !isOpen;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.title,
              if (isOpen)
                const Icon(Icons.arrow_drop_down, size: 30)
              else
                const Icon(Icons.arrow_right, size: 30),
            ],
          ),
        ),
      ),
      if (isOpen) widget.child,
    ]);
  }
}