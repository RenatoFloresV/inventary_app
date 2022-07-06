import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventary_app/models/income_model.dart';
import 'package:provider/provider.dart';
import '../cubit/departure_cubit/departure_cubit.dart';
import '../cubit/income_all/income_all_cubit.dart';
import '../models/departure_model.dart';
import '../services/auth.dart';
import '../widgets/snackbar_widgets/snackbar_widgets.dart';

class AddDepartures extends StatefulWidget {
  const AddDepartures({Key? key}) : super(key: key);

  @override
  _AddDeparturesState createState() => _AddDeparturesState();
}

class _AddDeparturesState extends State<AddDepartures> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<IncomeModel> incomeList = [];
  String? onChanged;

  @override
  initState() {
    final incomesData = context.read<IncomeAllCubit>();
    if (incomesData.state is IncomeAllLoaded) {
      incomeList = (incomesData.state as IncomeAllLoaded).incomes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    final _date = DateFormat('dd - MM - yyyy').format(DateTime.now());
    final _time = DateFormat('hh:mm a').format(DateTime.now());

    validator(value) {
      if (value == null || value.trim().isEmpty) {
        return 'Este campo es obligatorio';
      }
      return null;
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Añadir Salida')),
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.add_shopping_cart),
                          labelText: 'Producto',
                        ),
                        value: onChanged,
                        items: incomeList
                            .map((income) => DropdownMenuItem(
                                  child: Text(income.product!),
                                  value: income.product,
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            onChanged = value!;
                          });
                        },
                        validator: validator,
                      ),
                      FormField(builder: (FormFieldState state) {
                        return TextFormField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                                labelText: 'Cantidad',
                                hintText: 'Cantidad',
                                icon: Icon(
                                    Icons.production_quantity_limits_sharp)),
                            keyboardType: TextInputType.number,
                            validator: validator);
                      }),
                      FormField(builder: (FormFieldState state) {
                        return TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(
                              labelText: 'Precio',
                              hintText: 'Precio',
                              icon: Icon(Icons.attach_money),
                            ),
                            keyboardType: TextInputType.number,
                            validator: validator);
                      }),
                      TextButton(
                          child: const Text('Add'),
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarWhenSuccess(
                                      'Añadido $onChanged a la lista de salidas'));
                              try {
                                final departureModel = DepartureModel(
                                    product: onChanged,
                                    amount: int.parse(_amountController.text),
                                    date: _date,
                                    time: _time,
                                    price: double.parse(_priceController.text),
                                    user: _authService.user.displayName);
                                addDeparture(departureModel);
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                            }
                            // context .read<DepartureCubit>().test(_authService.user.uid);
                          })
                    ]))));
  }

  void addDeparture(DepartureModel departureModel) {
    context.read<DepartureCubit>().addDeparture(departureModel);
  }
}
