import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'injection_container.dart' as di;
import 'package:food_delivery_app/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
        //TODO: Main App File : Provide category BLoC
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
