

import 'package:ecom/blocks/auth_/auth_bloc.dart';
import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/repository/Product_repository.dart';
import 'package:ecom/repository/auth_repository.dart';
import 'package:ecom/screens/add_item.dart';
import 'package:ecom/screens/auth/login_page.dart';
import 'package:ecom/screens/auth/splash_page.dart';
import 'package:ecom/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(ProductRepository())..add(LoadProducts()),
        ),
      ],
      child: Builder(
        builder:
            (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Internship App',
              initialRoute: '/',
              routes: {
                '/': (context) => SplashPage() ,
                '/login': (context) => LoginPage(),
                '/home': (context) => EcomApp(), // Add this
                '/add': (context) => AddItemPage(), // Add this
              },
            ),
      ),
    );
  }
}
