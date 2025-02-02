import 'package:flutter/material.dart';
import 'package:flutter_teste/config/dependencies.dart';
import 'package:flutter_teste/domain/entities/user_entity.dart';
import 'package:flutter_teste/main_viewModel.dart';
import 'package:routefly/routefly.dart';

import 'main.route.dart';
part 'main.g.dart';

void main() {
  setupDependencies();
  runApp(const MainApp());
}

@Main('lib/ui/')
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final mainViewModel = injector.get<MainViewModel>();

  @override
  void initState() {
    super.initState();

    // faz a verificação se o usuário está logado
    mainViewModel.addListener(() {
      if (mainViewModel.user is LoggedUser) {
        Routefly.navigate(routePaths.home);
      } else {
        Routefly.navigate(routePaths.auth.login);
      }
    });
  }

  @override
  void dispose() {
    mainViewModel.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.auth.login,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
    );
  }
}
