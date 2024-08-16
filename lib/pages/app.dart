import 'package:flutter/material.dart';
import 'package:fspmi/pages/faq.dart';
import 'package:fspmi/pages/home.dart';
import 'package:fspmi/pages/pengaduan.dart';
import 'package:fspmi/pages/pengeluaran.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;

  List pages = [
    const HomeScreen(),
    const PengaduanScreen(),
    const PengeluaranScreen(),
    const FaqScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Pengaduan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outbox),
            label: "Pengeluaran",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_rounded),
            label: "FAQ",
          ),
        ],
      ),
    );
  }
}
