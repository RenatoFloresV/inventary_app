import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/cubit/stock_cubit/stock_cubit.dart';
import 'package:inventary_app/models/departure_model.dart';
import 'package:inventary_app/models/stock_model.dart';

import '../cubit/departure_cubit/departure_cubit.dart';
import '../cubit/income_all/income_all_cubit.dart';
import '../models/income_model.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List<IncomeModel> incomeList = [];
  List<DepartureModel> departureList = [];
  List<StockModel> stockList = [];

  @override
  void initState() {
    final incomesData = context.read<IncomeAllCubit>();
    if (incomesData.state is IncomeAllLoaded) {
      incomeList = (incomesData.state as IncomeAllLoaded).incomes;
    }
    final departuresData = context.read<DepartureCubit>();
    if (departuresData.state is DepartureLoaded) {
      departureList = (departuresData.state as DepartureLoaded).departures;
    }
    context.read<StockCubit>().getStocks();
    // incomeList.forEach((income) {
    //   stockList.add(StockModel(
    //     id: income.id,
    //     product: income.product,
    //     amount: income.product == income.product
    //         ? income.amount! + income.amount!
    //         : income.amount,
    //   ));
    // });
    // print(stockList.length);
    stockList.addAll(incomeList.map((e) => StockModel(
          id: e.id,
          product: e.product,
          amount: incomeList
                  .firstWhere((element) => element.product == e.product)
                  .amount! +
              e.amount!,
        )));

    // stockList.addAll(departureList.map((departure) {
    //   if (incomeList.any((income) => income.product == departure.product)) {
    //     return StockModel(
    //         id: departure.id,
    //         product: departure.product,
    //         amount: incomeList
    //                 .firstWhere((income) => income.product == departure.product)
    //                 .amount! -
    //             departure.amount!);
    //   } else {
    //     return StockModel(
    //         id: departure.id,
    //         product: departure.product,
    //         amount: departure.amount);
    //   }
    // }).toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stockL(),
    );
  }

  stockL() {
    return BlocBuilder<StockCubit, StockState>(builder: (context, state) {
      if (state is StockInitial) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is StockLoaded) {
        // stockList = state.stocks;
        // if (stockList.isEmpty) {
        //   return const Center(
        //       child: Text('No hay ningún registro de stock',
        //           style: TextStyle(fontSize: 20)));
        // }

        return ListView.builder(
            itemCount: stockList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(stockList[index].product!),
                subtitle: Text(stockList[index].amount.toString()),
              );
            });
      }
      if (state is StockError) {
        return Center(child: Text(state.message));
      }
      return const Center(child: Text('No hay ningún registro de stock'));
    });
  }
}
