import 'package:flutter/material.dart';

class DateList extends StatefulWidget {
  DateList({
    Key? key,
    required this.label,
    required this.addItem,
    required this.dateList,
    required this.viewScreen,
  }) : super(key: key);
  String label;
  Function addItem;
  List dateList;
  Function viewScreen;
  bool order = false;
  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(widget.label),
            IconButton(
                icon: const Icon(Icons.add), onPressed: () => widget.addItem())
          ]),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.dateList.length,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Fecha'),
                          // Text(incomeList[index].date!),
                          Text(widget.dateList[index]!),
                          TextButton(
                              child: const Text('Ver'),
                              onPressed: () => widget.viewScreen())
                        ]);
                  })),
          TextButton.icon(
            icon: const RotatedBox(
              quarterTurns: 3,
              child: Icon(Icons.compare_arrows),
            ),
            label: Text(widget.order ? 'Ascendente' : 'Descendente'),
            onPressed: () => setState(() => widget.order = !widget.order),
          )
        ]));
  }

  forDate(date) {
    final list =
        widget.dateList.where((element) => element.date == date).toList();
    return list;
  }
}
