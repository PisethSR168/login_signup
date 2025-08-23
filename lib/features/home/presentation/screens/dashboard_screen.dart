import 'package:flutter/material.dart';
import 'package:login_signup/features/home/presentation/widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Primary School"),
        actions: const [
          Icon(Icons.schedule),
          SizedBox(width: 10),
          Icon(Icons.assignment),
          SizedBox(width: 15),
        ],
      ),
      drawer: const AppSidebar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Info Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text("Xamarin UI Design",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.class_, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text("Class: V"),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.school, color: Colors.indigo),
                          SizedBox(width: 8),
                          Text("Class Teacher: Monali Kundre"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Grid Menu
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DashboardButton(icon: Icons.menu_book, label: "Syllabus"),
                  DashboardButton(icon: Icons.fact_check, label: "Test"),
                  DashboardButton(icon: Icons.notifications, label: "Notice"),
                  DashboardButton(icon: Icons.payment, label: "Fees"),
                  DashboardButton(icon: Icons.photo_album, label: "Gallery"),
                  DashboardButton(icon: Icons.person, label: "Profile"),
                ],
              ),

              const SizedBox(height: 20),

              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo[300],
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/online_school_bg.png"),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "ONLINE SCHOOL",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Progress Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProgressInfo(title: "Learned Phase", value: "12"),
                    ProgressInfo(title: "Phase left to learn", value: "36"),
                    ProgressInfo(title: "Total Learning Time", value: "1.5h"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const DashboardButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.indigo, size: 30),
            const SizedBox(height: 6),
            Text(label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class ProgressInfo extends StatelessWidget {
  final String title;
  final String value;

  const ProgressInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}