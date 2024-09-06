import 'package:flutter/material.dart';
import 'package:mind_math/model/amount_data.dart';
import 'package:provider/provider.dart';

import '../../controller/main_provider.dart';
import '../helper/single_line_helper.dart';

class ExpanseViewList extends StatelessWidget {
  const ExpanseViewList({super.key});

  @override
  Widget build(BuildContext context) {
    final MainProvider mainProvider = Provider.of<MainProvider>(context);
    return ListView.builder(
      itemCount: mainProvider.amountData.length,
      itemBuilder: (context, index) {
        if (mainProvider.amountData.isNotEmpty) {
          mainProvider.amountData.sort(
            (a, b) => a.date!.compareTo(b.date!),
          );
        }
        final snapShot = mainProvider.amountData[index];
        final bool crIs = snapShot.amountIs == 'CR';
        return ChatWidget(crIs: crIs, snapShot: snapShot);
      },
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.crIs,
    required this.snapShot,
  });

  final bool crIs;
  final AmountData snapShot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: crIs ? 70 : 0,
        right: crIs ? 0 : 70,
      ),
      child: Card(
        color: crIs ? Colors.green.shade100 : Colors.red.shade100,
        elevation: 0,
        child: ListTile(
          title: snapShot.date != null
              ? Text(
                  dateFormat(snapShot.date!),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )
              : null,
          subtitle: (snapShot.source?.name != '' || snapShot.tags!.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (snapShot.source?.name != '') ...[
                      Text(
                          '${snapShot.source?.name}, ${snapShot.source?.amount}')
                    ],
                    Wrap(
                      children: snapShot.tags!
                          .map((e) => Text('${e?.name} '))
                          .toList(),
                    )
                  ],
                )
              : null,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹${snapShot.amount}',
                style: TextStyle(
                  color: crIs ? Colors.green : Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                ' ${snapShot.amountIs}',
                style: TextStyle(
                  color: crIs ? Colors.green : Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
