import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/departures_view/add_departures.dart';
import 'package:inventary_app/departures_view/departure_list.dart';
import 'package:inventary_app/models/departure_model.dart';
import '../cubit/departure_cubit/departure_cubit.dart';
import '../cubit/income_all/income_all_cubit.dart';

class DateDepartures extends StatefulWidget {
  const DateDepartures({Key? key}) : super(key: key);

  @override
  State<DateDepartures> createState() => _DateDeparturesState();
}

class _DateDeparturesState extends State<DateDepartures> {
  List<DepartureModel> departureList = [];
  String? date;
  bool order = false;

  @override
  void initState() {
    final departuresData = context.read<DepartureCubit>();
    if (departuresData.state is DepartureLoaded) {
      departureList = (departuresData.state as DepartureLoaded).departures;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return departuresL();
  }

  departuresL() {
    return BlocBuilder<DepartureCubit, DepartureState>(
        builder: (context, state) {
      if (state is DepartureInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is DepartureLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is DepartureLoaded) {
        departureList = state.departures;
        final forDateList =
            departureList.map((item) => item.date).toSet().toList();
        order
            ? forDateList.sort()
            : forDateList.sort((a, b) => b!.compareTo(a!));
        if (departureList.isEmpty) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Text('No hay ningún registro de salidas',
                    style: TextStyle(fontSize: 20)),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDepartures()));
                    })
              ]));
        }
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text('Añadir Salida'),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDepartures()));
                    })
              ]),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                      itemCount: forDateList.length,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Fecha'),
                              Text(forDateList[index]!),
                              TextButton(
                                  child: const Text('Ver'),
                                  onPressed: () {
                                    date = forDateList[index];
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeparturesList(
                                                    departureList:
                                                        forDate(date))));
                                  })
                            ]);
                      })),
              TextButton.icon(
                icon: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(Icons.compare_arrows),
                ),
                label: Text(order ? 'Ascendente' : 'Descendente'),
                onPressed: () => setState(() => order = !order),
              )
            ]));
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }

  forDate(date) {
    final departure =
        departureList.where((element) => element.date == date).toList();
    return departure;
  }
}
