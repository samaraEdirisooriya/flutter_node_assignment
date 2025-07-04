import 'package:ecom/blocks/auth_/auth_bloc.dart';
import 'package:ecom/blocks/product/product_bloc.dart';
import 'package:ecom/repository/Product_repository.dart';
import 'package:ecom/repository/auth_repository.dart';
import 'package:ecom/ui/screens/add_item.dart';
import 'package:ecom/ui/screens/auth/login_page.dart';
import 'package:ecom/ui/screens/auth/register_page.dart';
import 'package:ecom/ui/screens/auth/splash_page.dart';
import 'package:ecom/ui/screens/ecom_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
                '/': (context) => SplashPage(),
                '/login': (context) => LoginPage(),
                '/register':(context) =>RegisterPage(), 
                '/home': (context) => EcomApp(), 
                '/add': (context) => AddItemPage(),
              },
            ),
      ),
    );
  }
}
