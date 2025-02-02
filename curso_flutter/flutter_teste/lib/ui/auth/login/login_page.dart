import 'package:flutter/material.dart';
import 'package:flutter_teste/config/dependencies.dart';
import 'package:flutter_teste/domain/dtos/credentials.dart';
import 'package:flutter_teste/domain/validators/credentials_validator.dart';
import 'package:flutter_teste/ui/auth/login/viewmodels/login_viewmodel.dart';
import 'package:result_command/result_command.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = injector.get<LoginViewmodel>();
  final validator = CredentialsValidator();
  final credentials = Credentials();

  void _listenable() {
    // if (viewModel.loginCommand.isSuccess) {
    //   // Routefly.replace(routePaths.home);
    //   Routefly.push(routePaths.home);
    // } else
    if (viewModel.loginCommand.isFailure) {
      final error = viewModel.loginCommand.value as FailureCommand;

      final snackBar = SnackBar(
        content: Text(error.error.toString()),
        backgroundColor: Colors.red,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.loginCommand.addListener(_listenable);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 150),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: credentials.setEmail,
                  validator: validator.byField(credentials, 'email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  // keyboardAppearance: KeyboardA,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: credentials.setPassword,
                  // keyboardType: TextInputType.visiblePassword,
                  validator: validator.byField(credentials, 'password'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 20),
                ListenableBuilder(
                    listenable: viewModel.loginCommand,
                    builder: (context, _) {
                      return ElevatedButton(
                        onPressed: viewModel.loginCommand.isRunning
                            ? null
                            : () {
                                if (validator.validate(credentials).isValid) {
                                  viewModel.loginCommand.execute(credentials);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Invalid credentials'),
                                    ),
                                  );
                                }
                              },
                        child: viewModel.loginCommand.isRunning
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('Login'),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
