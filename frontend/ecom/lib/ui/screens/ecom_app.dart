import 'package:ecom/constants/app_color.dart';
import 'package:ecom/ui/screens/productList_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcomApp extends StatelessWidget {
  const EcomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecooom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColorAppBar,
          foregroundColor: AppColors.foregroundColorAppbar,
          elevation: 1,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.grey,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
      ),
      themeMode: ThemeMode.system,
      home: ProductListPage(),
    );
  }
}
