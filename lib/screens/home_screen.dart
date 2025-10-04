import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/bottom_nav_controller.dart';
import 'package:todo_app/screens/profile_screen.dart';
import 'package:todo_app/screens/task_creation_screen.dart';
import 'package:todo_app/screens/task_list_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  // Pages to swap based on selected index
  final List<Widget> pages = [
    TaskListView(),      // index 0
    TaskCreationScreen(),// index 1
    ProfileScreen()      // index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('./image/home.png'),
                size: 28,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('./image/task.png'),
                size: 28,
              ),
              label: "Add Task",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('./image/profile.png'),
                size: 28,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
