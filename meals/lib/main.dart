import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

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
        // textTheme: TextTheme.of(context).copyWith(
        //   titleMedium: GoogleFonts.roboto().copyWith(
        //     // fontSize: 20,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
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
      home: TabsScreen(_favoriteMeals),
      // initialRoute: '/',
      routes: {
        AppRoutes.categoriesMeals: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.mealDetail: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.settings: (ctx) => SettingsScreen(_filterMeals, settings),
      },
      // onGenerateRoute: (settings) {

      // },
      // onUnknownRoute: (settings) {

      // },
    );
  }
}
