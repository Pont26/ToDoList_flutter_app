import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/home_screen.dart';

class SignupController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var gender = ''.obs;
  var dob = ''.obs;
  var isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register() async {
    if (fullName.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // 1. Create user with Email and Password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.value.trim(),
              password: password.value);

      String uid = userCredential.user!.uid;

      // 2. Build the data map dynamically
      Map<String, dynamic> userData = {
        'uid': uid,
        'fullName': fullName.value,
        'gender': gender.value,
        'email': email.value.trim(),
        'dob' : dob.value,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // if (gender.value.isNotEmpty) {
      //   userData['gender'] = gender.value;
      // }
      // if (dob.value.isNotEmpty) {
      //   userData['dob'] = dob.value;
      // }
      
      // 3. Store user data in Cloud Firestore
      await _firestore.collection('users').doc(uid).set(userData);

      // Show success message and navigate (unchanged)
      Get.snackbar(
        'Success',
        'User created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 1),
      );
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => HomeScreen());

    } on FirebaseAuthException catch (e) {
      // Error handling (unchanged)
      String message = 'An unexpected error occurred';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered. Try logging in.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        message = 'The password must be at least 6 characters long.';
      } else {
        message = e.message ?? 'Signup failed. Please try again.';
      }

      Get.snackbar('Signup Failed', message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    } catch (e) {
      // Handle general errors
      Get.snackbar('Error', 'Failed to complete registration: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}