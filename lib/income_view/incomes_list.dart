import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/models/income_model.dart';

import '../cubit/income_all/income_all_cubit.dart';

class IncomesList extends StatefulWidget {
  const IncomesList({Key? key, required this.incomeList}) : super(key: key);
  final List<IncomeModel> incomeList;
  @override
  State<IncomesList> createState() => _IncomesListState();
}

class _IncomesListState extends State<IncomesList> {
  @override
  void initState() {
    context.read<IncomeAllCubit>().getIncomeAlls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Fecha'),
            Text(widget.incomeList[0].date!),
          ])),
      body: coso(),
    );
  }

  Widget coso() {
    return SingleChildScrollView(
        child: Center(
            child: DataTable(columns: const [
      DataColumn(label: Text('Producto')),
      DataColumn(label: Text('Cantidad')),
      DataColumn(label: Text('Código')),
      DataColumn(label: Text('')),
      // DataColumn(label: Text('Fecha de ingreso')),
    ], rows: [
      for (var i = 0; i < widget.incomeList.length; i++)
        DataRow(cells: [
          DataCell(
            Text(widget.incomeList[i].product!),
          ),
          DataCell(
            Text('${widget.incomeList[i].amount} und.'),
          ),
          DataCell(
            Text(widget.incomeList[i].code!),
          ),
          DataCell(
            IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text('Informacion de Ingreso'),
                            content: Table(
                                defaultColumnWidth:
                                    const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(children: [
                                    const TableCell(child: Text('Producto: ')),
                                    TableCell(
                                        child: Text(
                                            widget.incomeList[i].product!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Cantidad: ')),
                                    TableCell(
                                        child:
                                            Text(widget.incomeList[i].amount!.toString())),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Código: ')),
                                    TableCell(
                                        child:
                                            Text(widget.incomeList[i].code!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Fecha: ')),
                                    TableCell(
                                        child:
                                            Text(widget.incomeList[i].date!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Hora: ')),
                                    TableCell(
                                        child:
                                            Text(widget.incomeList[i].time!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(
                                        child: Text('Ingresado por: ')),
                                    TableCell(
                                        child:
                                            Text(widget.incomeList[i].user!)),
                                  ]),
                                ]),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('Cerrar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ]);
                      });
                }),
          )
        ])
    ])));
  }
}
