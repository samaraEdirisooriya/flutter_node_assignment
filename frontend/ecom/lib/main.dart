import 'package:ecom/blocks/auth_/auth_bloc.dart';
import 'package:ecom/repository/auth_repository.dart';
import 'package:ecom/repository/product_repository';
import 'package:ecom/screens/auth/login_page.dart';
import 'package:ecom/screens/auth/splash_page.dart';
import 'package:ecom/screens/productList_page.dart';
import 'package:ecom/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecom/blocks/product/product_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AuthRepository()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(ProductRepository())..add(LoadProducts()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Internship App',
        initialRoute: '/',
        routes: {
          '/': (context) => ProductListPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => Container(),
        },
      ),
    );
  }
}