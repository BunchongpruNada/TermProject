import 'package:flutter/material.dart';
import 'package:inter_news/page/category.dart';
import 'package:inter_news/page/source.dart';
import 'package:inter_news/page/newpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromARGB(255, 84, 0, 115), // สีพื้นหลังของ AppBar
        title: Row(
          children: [
            Icon(
              Icons.dashboard,
              color: Colors.white,
            ), // ไอคอนสำหรับการค้นหา

            SizedBox(width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
            Text(
              'ND Search News', // ข้อความส่วนหัว
              style: TextStyle(
                color: Colors.white, // สีตัวอักษร
                fontWeight: FontWeight.bold, // ตัวหนา
                fontSize: 20, // ขนาดตัวอักษร
              ),
            ),
          ],
        ),
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.source),
            label: 'Source',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return NewsPage(); // Your home page widget
      case 1:
        return CategoryPage(); // Your category page widget
      case 2:
        return SourcePage(); // Your source page widget
      default:
        return NewsPage(); // Default to home page if index is invalid
    }
  }
}
