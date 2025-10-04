import 'package:flutter/material.dart';
import 'package:todo_app/controller/signup_controller.dart';
import 'package:todo_app/custom_widget/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/singin_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "./image/intro.png",
                  height: 120,
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                "Get things done with TODO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                "Orem ipsum dolor sit amet, consecteture",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: "Enter your full name",
                onChanged: (val) => controller.fullName.value = val,
              ),
              CustomTextField(
                hintText: "Enter your E-mail",
                onChanged: (val) => controller.email.value = val,
              ),
              const SizedBox(height: 15),

              // Gender Radio Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    // Use Obx to rebuild the radio buttons when gender changes
                    Obx(() => Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Male"),
                                value: "Male",
                                groupValue: controller.gender.value,
                                onChanged: (val) =>
                                    controller.gender.value = val!,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text("Female"),
                                value: "Female",
                                groupValue: controller.gender.value,
                                onChanged: (val) =>
                                    controller.gender.value = val!,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Date of Birth Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Use Obx to rebuild the TextField when dob changes
                    Obx(() => TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: controller.dob.value.isEmpty
                                ? "Select your date of birth"
                                : controller.dob.value,
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: const Icon(Icons.calendar_today),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              controller.dob.value =
                                  "${picked.toLocal()}".split(' ')[0];
                            }
                          },
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Enter your password",
                obscureText: true,
                onChanged: (val) => controller.password.value = val,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Confirm your password",
                obscureText: true,
                onChanged: (val) => controller.confirmPassword.value = val,
              ),
              const SizedBox(height: 30),

              // Sign Up Button with Obx for Loading State
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  // 2. Wrap the button in Obx to react to the 'isLoading' observable
                  child: Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFAED0DB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        // 3. Disable the button and show a spinner if loading is true
                        onPressed: controller.isLoading.value
                            ? null 
                            : () {
                                controller.register();
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
                                "Continue",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )),
                ),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "You already have an account?",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 12, 12, 12),
                    ),
                    children: [
                      TextSpan(
                          text: " Sing In",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xF7005055),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Use Get.to for navigation to the sign-in screen
                              Get.to(() => const SinginScreen());
                            })
                    ],
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
