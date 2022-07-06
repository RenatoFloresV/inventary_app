import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../widgets/snackbar_widgets/snackbar_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("valid");
    } else {
      print("invalid");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: Center(
            child: Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FormField(builder: (FormFieldState state) {
          return TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: state.hasError ? state.errorText : null),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter some text';
                }
                if (!RegExp(regex).hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              });
        }),
        FormField(builder: (FormFieldState state) {
          return TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: state.hasError ? state.errorText : null,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              });
        }),
        TextButton(
            child: const Text('Registrar'),
            onPressed: () async {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
                    'Bienvenido ${authService.user.displayName}'));

                final email = _emailController.text;
                final password = _passwordController.text;
                try {
                  await authService.signUpWithCredentials(email, password);
                } catch (e) {
                  print(e);
                }
              }
            }),
        TextButton(
            child: const Text('Iniciar sesión'),
            onPressed: () async {
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
                    'Bienvenido ${authService.user.displayName}'));

                final email = _emailController.text;
                final password = _passwordController.text;
                try {
                  await authService.signInWithCredentials(email, password);
                } catch (e) {
                  print(e);
                }
              }
            }),
        TextButton(
            child: const Text('Inicia con Google'),
            onPressed: () async {
              if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.android) {
                await authService.googleSignIn();

                // Some android/ios specific code
              } else {
                await authService.signInWithGoogleDesktop();
                // Some web specific code there
              }
            })
      ]),
    )));
  }
}
