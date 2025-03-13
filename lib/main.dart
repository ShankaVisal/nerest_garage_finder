import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:nerest_garage_finder/View/home_screen.dart';
import 'package:nerest_garage_finder/homepage.dart';

void main() async{
  try {
    await GlobalConfiguration().loadFromUrl("https://garage-list.netlify.app/garage_list.json");
  } catch (e) {
    print("Error loading configuration: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

