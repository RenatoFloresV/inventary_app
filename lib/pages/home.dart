import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
        body: Center(
            child: TextButton(
                child: Text('Cerrar Sesión ${authService.user.displayName}'),
                onPressed: () {
                  authService.signOut();
                })));
  }
}
