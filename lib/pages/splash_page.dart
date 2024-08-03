import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todolist/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    homePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Lottie.network(
              "https://lottie.host/80ac2242-630e-4ba1-a4ae-133d07db0f71/QEhFCQkavL.json"),
        ),
      ),
    );
  }

  void homePage() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      },
    );
  }
}
