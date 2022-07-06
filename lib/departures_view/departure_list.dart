import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/models/departure_model.dart';

import '../cubit/departure_cubit/departure_cubit.dart';

class DeparturesList extends StatefulWidget {
  const DeparturesList({Key? key, required this.departureList})
      : super(key: key);
  final List<DepartureModel> departureList;
  @override
  State<DeparturesList> createState() => _DeparturesListState();
}

class _DeparturesListState extends State<DeparturesList> {
  @override
  void initState() {
    context.read<DepartureCubit>().getDepartures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // widget.departureList = state.departures;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Fecha'),
            Text(widget.departureList[0].date!),
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
      // DataColumn(label: Text('Precio')),
      DataColumn(label: Text('')),
      // DataColumn(label: Text('Fecha de ingreso')),
    ], rows: [
      for (var i = 0; i < widget.departureList.length; i++)
        DataRow(cells: [
          DataCell(
            Text(widget.departureList[i].product!),
          ),
          DataCell(
            Text('${widget.departureList[i].amount} und.'),
          ),
          // DataCell(
          //   Text('S/.${widget.departureList[i].price}'),
          // ),
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
                                            widget.departureList[i].product!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Cantidad: ')),
                                    TableCell(
                                        child: Text(
                                            widget.departureList[i].amount!.toString())),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Precio:')),
                                    TableCell(
                                        child: Text(
                                            'S/. ${widget.departureList[i].price}')),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Fecha: ')),
                                    TableCell(
                                        child: Text(
                                            widget.departureList[i].date!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(child: Text('Hora: ')),
                                    TableCell(
                                        child: Text(
                                            widget.departureList[i].time!)),
                                  ]),
                                  TableRow(children: [
                                    const TableCell(
                                        child: Text('Vendido por: ')),
                                    TableCell(
                                        child: Text(
                                            widget.departureList[i].user!)),
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
