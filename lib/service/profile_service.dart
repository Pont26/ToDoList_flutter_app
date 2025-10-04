import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Note: You would normally use the actual current user ID from
// FirebaseAuth, but we'll use a placeholder for now.
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // The collection in Firestore where user profile data is stored
  static const String _userCollection = 'users';

  /// Fetches user profile data (username, gender, dateOfBirth) from Firestore.
  Future<Map<String, dynamic>> fetchUserProfile() async {
    // ⚠️ Get the actual UID of the currently logged-in user
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      throw Exception("User is not logged in. Cannot fetch profile.");
    }

    try {
      DocumentSnapshot userDoc =
          await _firestore.collection(_userCollection).doc(currentUserId).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        // 🎯 FIX: Return the keys exactly as they exist in Firestore
        return {
          'fullName': data['fullName'] ?? 'User Name Not Set', // Use fullName
          'gender': data['gender'] ?? 'N/A', // Use gender
          'dob': data['dob'] ?? 'N/A', // Use dob
        };
      } else {
        debugPrint("User document not found for UID: $currentUserId");
        return {
          'username': 'Profile Missing',
          'gender': 'N/A',
          'dateOfBirth': 'N/A',
        };
      }
    } catch (e) {
      debugPrint("Error fetching user profile from Firestore: $e");
      throw Exception(
          "Failed to load user profile. Check Firestore rules/connection.");
    }
  }
}
