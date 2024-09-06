import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mind_math/controller/shared_pref.dart';
import 'package:mind_math/model/source.dart';
import 'package:mind_math/view/helper/basic.dart';
import 'package:mind_math/view/screen/home.dart';
import 'package:provider/provider.dart';

import '../../controller/main_provider.dart';
import '../../model/amount_data.dart';
import '../../model/tag.dart';
import '../helper/widget/rounded_container.dart';
import '../helper/widget/toast.dart';

class AddAmountWidget extends StatefulWidget {
  const AddAmountWidget({super.key});

  @override
  State<AddAmountWidget> createState() => _AddAmountWidgetState();
}

class _AddAmountWidgetState extends State<AddAmountWidget> {
  String tag = 'Add';
  String selectedAmount = "CR";
  List<Tags> tagList = [];
  Tags? singleTag;
  DateTime date = DateTime.now().toLocal();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  Source? source;

  addTag(Tags data) {
    if (tagList.contains(data)) return;
    tagList.add(data);
    setState(() {});
  }

  removeTag(Tags data) {
    tagList.remove(data);
    setState(() {});
  }

  showDialog2(void Function()? onPressed) => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Wrap(
                        children: mainProvider.tag
                            .map((element) => InkWell(
                                  onTap: () {
                                    addTag(element);
                                    myMsg(
                                      context,
                                      title: '${element.name}Tag Added',
                                      color: Colors.green,
                                      icon: Icons.done,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: element.color != null
                                          ? BasicColors.hexToColor(
                                              element.color!)
                                          : Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(element.name),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            mainProvider.removeTag(element);
                                          },
                                          child: const Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: TextFormField(
                    controller: _sourceController,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      onPressed;
                    },
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Tags',
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: onPressed,
                        child: const Text('Add Tag'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  late MainProvider mainProvider;

  @override
  void initState() {
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<MainProvider>(context);
    return Container(
      color: Colors.grey.shade300,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // This is fot tag widget only view after add tag. We can add multiple Tags.
              if (tagList.isNotEmpty) ...[
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tagList.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(tagList[index].name),
                        IconButton(
                            onPressed: () => removeTag(tagList[index]),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  // This dropdown for source of income, So This is a single data value.
                  // DropdownMenu(
                  //   hintText: 'Select',
                  //   dropdownMenuEntries: mainProvider.source
                  //       .map((e) => DropdownMenuEntry(
                  //             value: e,
                  //             label: e.name,
                  //             labelWidget: InkWell(
                  //                 onTap: () {
                  //                   source = e;
                  //                   setState(() {});
                  //                 },
                  //                 child: Text('${e.name}, ${e.amount}')),
                  //           ))
                  //       .toList(),
                  // ),
                  DropdownButton(
                      hint: Text(source?.name ?? 'Select Source'),
                      items: mainProvider.source
                          .map((e) => DropdownMenuItem(
                              value: e, child: Text('${e.name}, ${e.amount}')))
                          .toList(),
                      onChanged: (value) {
                        source = value;
                        setState(() {});
                      }),
                  // const SizedBox(width: 10),
                  // This dropdown for type of income, We can add multiple data.
                  DropdownButton(
                    hint: const Text('Select Tags'),
                    // isDense: true,
                    icon: const Icon(Icons.add),
                    items: [
                      ...mainProvider.tag
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(e.name),
                                // const SizedBox(width: 10),
                                // IconButton(
                                //   icon: const Icon(
                                //     Icons.delete,
                                //     color: Colors.red,
                                //   ),
                                //   onPressed: () {
                                //     mainProvider.removeTag(e);
                                //     Navigator.pop(context);
                                //   },
                                // ),
                                //   ],
                                // )
                              ))
                          .toList(),
                      const DropdownMenuItem(
                        value: 'Add',
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Add'),
                            SizedBox(width: 5),
                            Icon(Icons.add, color: Colors.green),
                          ],
                        ),
                      )
                    ],
                    onChanged: (value) {
                      if (value is Tags) {
                        addTag(value);
                        setState(() {});
                      } else {
                        showDialog2(
                          () {
                            mainProvider.addTag(
                              Tags(name: _sourceController.text),
                            );
                            _sourceController.clear();
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      final datePick = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1500),
                        lastDate: DateTime.now(),
                      );
                      if (datePick != null) {
                        date = datePick.copyWith(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute);
                        setState(() {});
                      }
                    },
                    child: RoundedContainer(
                      child: DateWidget(date: date),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CupertinoSwitch(
                    trackColor: Colors.red.shade900,
                    value: selectedAmount == 'CR',
                    onChanged: (value) {
                      setState(() {
                        selectedAmount = value ? 'CR' : 'DR';
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        label: const Text('Amount'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '0') {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      if (source == null) {
                        myMsg(
                          context,
                          title: 'Please Select Source',
                        );
                      } else if (formKey.currentState!.validate()) {
                        final AmountData amountData = AmountData(
                          date: date,
                          amount: _amountController.text,
                          amountIs: selectedAmount,
                          source: Source(
                            amount: source!.amount,
                            name: source!.name,
                            color: source!.color,
                          ),
                          tags: [...tagList],
                        );
                        mainProvider.addAmountData(amountData);
                        LocalData(context: context).spendingSet(Local.spending);
                        tagList.clear();
                        _amountController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                    padding: const EdgeInsets.all(4),
                    color: Colors.white,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     final t = mainProvider.tag.length;
                  //     final t1 = mainProvider.amountData[0].tags?.length;
                  //     debugPrint("$t $t1");
                  //   },
                  //   icon: const Icon(Icons.safety_check),
                  //   padding: const EdgeInsets.all(4),
                  //   color: Colors.white,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
