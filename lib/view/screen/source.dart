import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_math/model/source.dart';
import 'package:provider/provider.dart';

import '../../controller/main_provider.dart';
import '../helper/basic.dart';
import '../helper/widget/open_close.dart';

class SourceScreen extends StatelessWidget {
  const SourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Source (Like bank)'),
      ),
      body: ListView(
        children: [
          const AddSource(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Sources', style: BasicText.h3),
          ),
          const Divider(),
          if (mainProvider.source.isEmpty) ...[
            const SizedBox(height: 10),
            const Center(child: Text('No data'))
          ] else ...[
            Wrap(
              children: mainProvider.source
                  .map((e) => SourceWidget(
                      amount: e.amount, name: e.name, color: e.color))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class AddSource extends StatefulWidget {
  const AddSource({super.key});

  @override
  State<AddSource> createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  String? color;

  final TextEditingController name = TextEditingController();

  final TextEditingController openingBalance = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeadingWidget(
            title: 'Name',
            subtitle: TextFormField(
              controller: name,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: Basic.empty,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
          HeadingWidget(
            title: 'Opening Balance',
            subtitle: TextFormField(
              controller: openingBalance,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.all(8),
              ),
              validator: Basic.empty,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OpenCloseWidget(
                    title: Text('Select Color', style: BasicText.h3),
                    child: Wrap(
                      children: BasicColors.basicColors.entries
                          .map((e) => InkWell(
                                onTap: () {
                                  color = e.value;
                                  setState(() {});
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(40),
                                    color: e.value != null
                                        ? BasicColors.hexToColor(e.value)
                                        : null,
                                  ),
                                  margin: const EdgeInsets.all(4),
                                  padding: const EdgeInsets.all(8),
                                  // child: Text(e.key),
                                  child: color == e.value
                                      ? const Icon(Icons.done)
                                      : null,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    color: BasicColors.hexToColor(color ?? '#ffffff'),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final Source source = Source(
                      amount: openingBalance.text,
                      name: name.text,
                      color: color);
                  // print(source.amount);
                  mainProvider.addSource(source);
                }
              },
              style: ElevatedButton.styleFrom(
                // backgroundColor: Colors.blue.shade900,
                // foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Add Source'),
            ),
          )
        ],
      ),
    );
  }
}

class SourceWidget extends StatelessWidget {
  const SourceWidget(
      {super.key, required this.amount, required this.name, this.color});
  final String amount;
  final String name;
  final String? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color != null ? BasicColors.hexToColor(color!) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₹$amount',
            style: BasicText.h1,
          ),
          Text(name),
        ],
      ),
    );
  }
}
