import 'package:flutter/material.dart';
import 'package:nerest_garage_finder/View/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String logo_url =
      "https://i.pinimg.com/736x/53/68/13/536813a90bd83a47e5ba5dcfb1457706.jpg";
  String splash_design =
      "https://i.pinimg.com/736x/66/b1/df/66b1dfc1f0c8645f085e1bf8151ebf07.jpg";

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                splash_design,
                height: double.infinity,
                fit: BoxFit.fill,
              )),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text("Home Screen")),
          ),
        ],
      ),
    );
  }
}
