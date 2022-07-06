import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventary_app/cubit/income_all/income_all_cubit.dart';
import 'package:provider/provider.dart';
import '../models/income_model.dart';
import '../services/auth.dart';
import '../widgets/snackbar_widgets/snackbar_widgets.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final _date = DateFormat('dd - MM - yyyy').format(DateTime.now());
    final _time = DateFormat('hh:mm a').format(DateTime.now());
    validator(value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo es obligatorio';
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Añadir Ingreso'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            FormField(builder: (FormFieldState state) {
              return TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    hintText: 'Monto',
                    icon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validator);
            }),
            FormField(builder: (FormFieldState state) {
              return TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Codigo',
                    hintText: 'Codigo',
                    icon: Icon(Icons.code),
                  ),
                  keyboardType: TextInputType.number,
                  validator: validator);
            }),
            FormField(builder: (FormFieldState state) {
              return TextFormField(
                  controller: _productController,
                  decoration: const InputDecoration(
                    labelText: 'Producto',
                    hintText: 'Producto',
                    icon: Icon(Icons.shopping_cart),
                  ),
                  keyboardType: TextInputType.text,
                  validator: validator);
            }),
            TextButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snackBarWhenSuccess(
                            'Añadido ${_productController.text}'));
                    try {
                      final incomeModel = IncomeModel(
                          amount: int.parse(_amountController.text),
                          code: _codeController.text,
                          date: _date,
                          time: _time,
                          product: _productController.text,
                          user: authService.user.displayName);
                      addIncome(incomeModel);
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                })
          ]),
        ));
  }

  void addIncome(IncomeModel incomeModel) {
    // context.read<DateIncomeCubit>().addDateIncome(incomeModel);
    context.read<IncomeAllCubit>().addDateIncome(incomeModel);
    // context.read<DateIncomeCubit>().addData(incomeModel, 'incomes');
  }
}
