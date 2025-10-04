import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/service/profile_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileService _profileService = ProfileService();

  final DateFormat _dobFormatter = DateFormat('d MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FB),
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: const Color(0xFF8FA8B5),
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileService.fetchUserProfile(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                "Error: ${snapshot.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ));
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
          
            final displayName = data['fullName'] ?? 'N/A';
            
            final gender = data['gender'] ?? 'N/A';
            
            final dobString = data['dob'] ?? 'N/A'; 

            String formattedDob = dobString;

            try {
              if (dobString != 'N/A') {
                DateTime dobDate = DateTime.parse(dobString);
                formattedDob = _dobFormatter.format(dobDate);
              }
            } catch (e) {
              formattedDob = dobString;
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xFF8FA8B5),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    displayName, 
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

             
                  _buildProfileItem(
                    icon: Icons.person_outline,
                    label: 'Name', 
                    value: displayName, 
                  ),
                  _buildProfileItem(
                    icon: gender == 'Male' ? Icons.male : Icons.female,
                    label: 'Gender',
                    value: gender,
                  ),
                  _buildProfileItem(
                    icon: Icons.calendar_today,
                    label: 'Date of Birth',
                    value: formattedDob, 
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("Initializing profile..."));
        },
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF8FA8B5)),
          title: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}