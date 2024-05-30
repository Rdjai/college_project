import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerformanceMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PerformanceCard(
          title: '10+',
          subtitle: 'classes visited',
          icon: Icons.class_,
        ),
        PerformanceCard(
          title: '83',
          subtitle: 'trainings completed',
          icon: Icons.check_circle,
        ),
        PerformanceCard(
          title: '36',
          subtitle: 'surveys completed',
          icon: Icons.poll,
        ),
      ],
    );
  }
}

class PerformanceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  PerformanceCard(
      {required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
