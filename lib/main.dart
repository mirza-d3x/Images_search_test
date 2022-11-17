import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixbayimages/Repositories/Api/ImageApi/images_api.dart';
import 'package:pixbayimages/Repositories/Bloc/images_bloc.dart';
import 'package:pixbayimages/Screens/main_screen.dart';

void main() {
  ImagesApi imagesApi = ImagesApi();
  runApp(
    BlocProvider(
      create: (context) => ImagesBloc(imagesApi),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
