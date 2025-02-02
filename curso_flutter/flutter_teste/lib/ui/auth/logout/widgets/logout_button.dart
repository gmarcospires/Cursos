import 'package:flutter/material.dart';
import 'package:flutter_teste/config/dependencies.dart';
import 'package:flutter_teste/ui/auth/logout/viewmodels/logout_viewmodel.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final viewModel = injector.get<LogoutViewmodel>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: viewModel.logoutCommand.execute,
        child: const Text('Logout'));
  }
}
