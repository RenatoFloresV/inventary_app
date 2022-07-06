import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/cubit/departure_cubit/departure_cubit.dart';
import 'package:inventary_app/income_view/add_income.dart';
import 'package:inventary_app/income_view/incomes_list.dart';
import 'package:inventary_app/models/income_model.dart';
import 'package:inventary_app/widgets/date_list.dart';
import '../cubit/income_all/income_all_cubit.dart';

class DateIncomes extends StatefulWidget {
  const DateIncomes({Key? key}) : super(key: key);

  @override
  State<DateIncomes> createState() => _DateIncomesState();
}

class _DateIncomesState extends State<DateIncomes> {
  List<IncomeModel> incomeList = [];
  String? date;
  bool order = false;

  @override
  void initState() {
    context.read<IncomeAllCubit>().getIncomeAlls();
    context.read<DepartureCubit>().getDepartures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return incomesL();
  }

  incomesL() {
    return BlocBuilder<IncomeAllCubit, IncomeAllState>(
        builder: (context, state) {
      if (state is IncomeAllInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is IncomeAllLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is IncomeAllLoaded) {
        incomeList = state.incomes;
        final forDateList =
            incomeList.map((item) => item.date).toSet().toList();
        order
            ? forDateList.sort()
            : forDateList.sort((a, b) => b!.compareTo(a!));
        if (incomeList.isEmpty) {
          return const Center(
              child: Text('No hay ningún registro de ingresos',
                  style: TextStyle(fontSize: 20)));
        }
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text('Añadir Ingreso'),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddIncome()));
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
                              // Text(incomeList[index].date!),
                              Text(forDateList[index]!),
                              TextButton(
                                  child: const Text('Ver'),
                                  onPressed: () {
                                    date = forDateList[index];
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => IncomesList(
                                                  incomeList: forDate(date),
                                                )));
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
    final incomes =
        incomeList.where((element) => element.date == date).toList();
    return incomes;
  }
}
