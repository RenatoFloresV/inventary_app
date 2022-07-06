import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventary_app/departures_view/date_departures.dart';
import 'package:inventary_app/income_view/date_incomes.dart';
import 'package:inventary_app/stock_view/stock_list.dart';
import 'package:inventary_app/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class ThemeStyle extends StatefulWidget {
  const ThemeStyle({Key? key}) : super(key: key);

  @override
  State<ThemeStyle> createState() => _ThemeStyleState();
}

class _ThemeStyleState extends State<ThemeStyle> {
  bool isDarkModeEnabled = false;
  int _selectedIndex = 0;
  String? label;
  final List _pages = [
    const DateIncomes(),
    const DateDepartures(),
    const StockList(),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // textButtonTheme: TextButtonThemeData(
          //   // style: TextButton.styleFrom(
          //   //   primary: Colors.black,
          //   //   // primaryColor: Colors.black,
          //   //   elevation: 0,
          //   // ),
          // ),
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
                color: Colors.black,
                systemOverlayStyle: SystemUiOverlayStyle.dark)),
        themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(
            drawer: Drawer(
                child: ListView(children: <Widget>[
              DrawerWidget(
                  authService: authService,
                  isDarkModeEnabled: isDarkModeEnabled),
              ListTile(
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: const Text('Salir'),
                  onTap: () {
                    authService.signOut();
                  })
            ])),
            appBar: AppBar(
                iconTheme: IconThemeData(
                    color: isDarkModeEnabled ? Colors.white : Colors.black),
                title: _selectedIndex == 0
                    ? Text(
                        'Ingresos',
                        style: TextStyle(
                            color: isDarkModeEnabled
                                ? Colors.white
                                : Colors.black),
                      )
                    : _selectedIndex == 1
                        ? Text(
                            'Salidas',
                            style: TextStyle(
                                color: isDarkModeEnabled
                                    ? Colors.white
                                    : Colors.black),
                          )
                        : Text(
                            'Stock',
                            style: TextStyle(
                                color: isDarkModeEnabled
                                    ? Colors.white
                                    : Colors.black),
                          ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.wb_sunny,
                          color:
                              isDarkModeEnabled ? Colors.white : Colors.black),
                      onPressed: () {
                        setState(() {
                          isDarkModeEnabled = !isDarkModeEnabled;
                        });
                      })
                ]),
            bottomNavigationBar: BottomNavigationBar(items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined), label: 'Ingresos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.exit_to_app_outlined), label: 'Salidas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.storage_rounded), label: 'Stock'),
            ], onTap: _onItemTapped, currentIndex: _selectedIndex),
            body: _pages.elementAt(_selectedIndex)));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}
