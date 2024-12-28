import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      supportedLocales: [Locale('pt', 'BR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 0.1),
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.pink,
          secondary: Colors.amber,
          seedColor: Colors.pink,
          surface: Color.fromRGBO(255, 254, 229, 0.1),
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.pink,
          titleTextStyle: GoogleFonts.roboto().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      ),
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.pink,
          secondary: Colors.amber,
          seedColor: Colors.pink,
          surface: Color.fromRGBO(255, 254, 229, 1),
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.pink,
          titleTextStyle: GoogleFonts.roboto().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const CategoriesScreen(),
      // initialRoute: '/',
      routes: {
        AppRoutes.categoriesMeals: (ctx) => const CategoriesMealsScreen(),
      },
    );
  }
}
