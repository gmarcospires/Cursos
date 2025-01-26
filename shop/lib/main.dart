import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('pt_BR', null);
  Intl.defaultLocale = 'pt_BR';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'shop',
        debugShowCheckedModeBanner: false,
        supportedLocales: [Locale('pt', 'BR')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          canvasColor: Color.fromRGBO(0, 0, 0, 0.9),
          scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 0.9),
          colorScheme: ColorScheme.fromSeed(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            seedColor: Colors.purple,
            surface: Color.fromRGBO(0, 0, 0, 0.9),
            brightness: Brightness.dark,
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: Colors.purple,
            titleTextStyle: GoogleFonts.lato().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          fontFamily: GoogleFonts.lato().fontFamily,
          useMaterial3: true,
        ),
        theme: ThemeData(
          canvasColor: Color.fromRGBO(243, 229, 255, 1),
          scaffoldBackgroundColor: Color.fromRGBO(243, 229, 255, 1),
          useMaterial3: true,
          fontFamily: GoogleFonts.lato().fontFamily,
          colorScheme: ColorScheme.fromSeed(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            seedColor: Colors.purple,
            surface: Color.fromRGBO(243, 229, 255, 1),
            brightness: Brightness.light,
          ),
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: Colors.purple,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: GoogleFonts.lato().copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.home: (ctx) => const ProductsOverviewPage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          // AppRoutes.productDetail: (ctx) =>
          //     CounterProvider(child: const CounterPage()),
        },
      ),
    );
  }
}
