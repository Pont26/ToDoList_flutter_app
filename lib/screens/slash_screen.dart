import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/signup_screen.dart';

class SlashScreen extends StatelessWidget {
  const SlashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 163, 163), // background color
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "./image/intro.png",
                height: 120,
              ),
            ),

            Center(
              child: Image.asset(
                "./image/welcome.png",
                height: 200,
              ),
            ),

            const SizedBox(height: 50),
            // Title
            const Text(
              "Get things done with TODO",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // Subtitle / description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Orci urna non tempor consequat, urna bibendum vulputate egestas. "
                "Volutpat, pellentesque euismod consequat nibh pharetra, sagittis morbi. "
                "Eros tincidunt vitae fermentum eu.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 70),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Get.to(()=> const SignupScreen());
                  },
                  child: const Text(
                    "Let’s get started",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
