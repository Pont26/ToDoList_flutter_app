import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/sigin_controller.dart';
import 'package:todo_app/custom_widget/text_field.dart';
import 'package:todo_app/screens/signup_screen.dart';

class SinginScreen extends StatelessWidget {
  const SinginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SiginController controller = Get.put(SiginController());

    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "./image/intro.png",
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "./image/HEYO!.png",
                  height: 100,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "./image/hello.png",
                  height: 100,
                ),
              ),
              //Body
              CustomTextField(
                hintText: "Enter your Email",
                onChanged: (val) => controller.email.value = val,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                
                hintText: "Enter your Password",
                obscureText: true,
                onChanged: (val) => controller.password.value = val,
              ),
              const SizedBox(height: 25),
              //button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAED0DB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.login();
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            "Enter",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              //bottom text
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Align(
                  alignment: Alignment.center, 
                  child: RichText(
                    text: TextSpan(
                      text: "You don't have an account yet?",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: " Sign up",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xF7005055),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SignupScreen());
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
