import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventary_app/cubit/departure_cubit/departure_cubit.dart';
import 'package:inventary_app/cubit/stock_cubit/stock_cubit.dart';
import 'package:inventary_app/pages/sign_in.dart';
import 'package:inventary_app/repositories/departure/departure_all_repository.dart';
import 'package:inventary_app/repositories/income/income_all_repository.dart';
import 'package:inventary_app/services/auth.dart';
import 'package:inventary_app/style/theme_mode.dart';
import 'package:provider/provider.dart';
import 'cubit/income_all/income_all_cubit.dart';
import 'firebase_options.dart';
import 'repositories/stock/stock_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AuthService.instance(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider<IncomeAllCubit>(
                create: (context) => IncomeAllCubit(IncomeAllRepository()),
              ),
              BlocProvider<DepartureCubit>(
                create: (context) => DepartureCubit(DepartureAllRepository()),
              ),
              BlocProvider<StockCubit>(
                  create: (context) => StockCubit(StockRepository())),
            ],
            child: MaterialApp(
                // routes: {
                //   '/home': (context) => const ThemeStyle(),
                //   '/sign_in': (context) => const SignIn(),
                //   '/incomes': (context) => const DateIncomes(),
                //   '/departures': (context) => const DateDepartures(),

                // },
                debugShowCheckedModeBanner: false,
                home: Consumer(builder: (context, AuthService authService, _) {
                  switch (authService.status) {
                    case AuthStatus.Uninitialized:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case AuthStatus.Authenticated:
                      return const ThemeStyle();
                    case AuthStatus.Authenticating:
                      return const SignIn();
                    case AuthStatus.Unauthenticated:
                      return const SignIn();
                  }
                }))));
  }
}
