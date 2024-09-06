import 'package:flutter/material.dart';
import 'package:mind_math/view/screen/add_amount.dart';
import 'package:mind_math/view/screen/source.dart';

import '../helper/single_line_helper.dart';
import 'expanse_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mind Math'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SourceScreen()),
              );
            },
            icon: const Icon(Icons.source),
          )
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ExpanseViewList(),
          ),
          Flexible(
            flex: 0,
            child: AddAmountWidget(),
          ),
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.date_range_rounded,
          color: Colors.green.shade900,
        ),
        Text(
          dateFormat(date),
          style: TextStyle(
            color: Colors.green.shade900,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
