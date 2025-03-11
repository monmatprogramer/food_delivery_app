import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/cart/cart_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/category/category_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'injection_container.dart' as di;
import 'package:food_delivery_app/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  //mainReresentor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide restaurant BloC

        BlocProvider<RestaurantBloc>(
          create: (_) => di.sl<RestaurantBloc>(),
        ),
        // Provide category Bloc
        BlocProvider<CategoryBloc>(
          create: (_) => di.sl<CategoryBloc>(),
        ),
        BlocProvider<CartBloc>(create: (_) => di.sl<CartBloc>())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food delivery app',
          theme: ThemeData(
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomePage()),
    );
  }
}
