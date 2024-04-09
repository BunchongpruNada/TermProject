import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'newdetail.dart';

class NewsInCategoryPage extends StatefulWidget {
  final String category;

  NewsInCategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _NewsInCategoryPageState createState() => _NewsInCategoryPageState();
}

class _NewsInCategoryPageState extends State<NewsInCategoryPage> {
  List<dynamic> _newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey =
        '2bbf86bd3cb84970bce35349acc91214'; // ใส่ API Key ของคุณที่นี่
    final url =
        'https://newsapi.org/v2/top-headlines?country=th&category=${widget.category}&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _newsList = jsonData['articles'];
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  void _showNewsDetails(Map<String, dynamic> news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailsPage(news: news),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromARGB(255, 249, 232, 255), // สีพื้นหลังของ AppBar
        title: Row(
          children: [
            Icon(
              Icons.dashboard,
              color: Color.fromARGB(255, 84, 0, 115),
            ), // ไอคอนสำหรับการค้นหา

            SizedBox(width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
            Text(
              '${widget.category} News', // ข้อความส่วนหัว
              style: TextStyle(
                color: Color.fromARGB(255, 84, 0, 115), // สีตัวอักษร
                fontWeight: FontWeight.bold, // ตัวหนา
                fontSize: 20, // ขนาดตัวอักษร
              ),
            ),
          ],
        ),
      ),
      body: _newsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _newsList.length,
              itemBuilder: (context, index) {
                final news = _newsList[index];
                return GestureDetector(
                  onTap: () {
                    _showNewsDetails(news);
                  },
                  child: Card(
                    elevation: 2.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news['title'],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            news['description'] ?? '',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
