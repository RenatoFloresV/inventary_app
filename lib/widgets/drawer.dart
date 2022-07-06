import 'package:flutter/material.dart';
import 'package:inventary_app/services/auth.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {Key? key, required this.authService, required this.isDarkModeEnabled})
      : super(key: key);
  final AuthService authService;
  final bool isDarkModeEnabled;
  @override
  Widget build(BuildContext context) {
    final color = isDarkModeEnabled ? Colors.white : Colors.black;
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: isDarkModeEnabled ? Colors.black : Colors.white,
      ),
      accountEmail:
          Text(authService.user.email!, style: TextStyle(color: color)),
      accountName:
          Text(authService.user.displayName!, style: TextStyle(color: color)),
      currentAccountPicture: authService.user.photoURL != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(authService.user.photoURL!),
            )
          : CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(authService.user.displayName!.substring(0, 1),
                  style: TextStyle(color: color)),
            ),
    );
  }
}
