import 'package:ecom/blocks/auth_/auth_bloc.dart';
import 'package:ecom/repository/auth_repository.dart';
import 'package:ecom/screens/auth/login_page.dart';
import 'package:ecom/screens/auth/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Internship App',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) =>  Container(),
        },
      ),
    );
  }
}