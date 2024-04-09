import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'newincategory.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final apiKey =
        '2bbf86bd3cb84970bce35349acc91214'; // ใส่ API Key ของคุณที่นี่
    final url = 'https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        // เก็บรายการหมวดหมู่ข่าวโดยไม่ซ้ำกัน
        Set<String> uniqueCategories = {};
        List<dynamic> uniqueCategoriesList = [];

        for (var source in jsonData['sources']) {
          if (!uniqueCategories.contains(source['category'])) {
            uniqueCategories.add(source['category']);
            uniqueCategoriesList.add(source);
          }
        }

        setState(() {
          _categories = uniqueCategoriesList;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // จำนวนคอลัมน์ในตาราง
                  crossAxisSpacing: 8.0, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 8.0, // ระยะห่างระหว่างแถว
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  IconData iconData;

                  switch (category['category']) {
                    case 'business':
                      iconData = Icons.business;
                      break;
                    case 'entertainment':
                      iconData = Icons.local_movies;
                      break;
                    case 'general':
                      iconData = Icons.public;
                      break;
                    case 'health':
                      iconData = Icons.healing;
                      break;
                    case 'science':
                      iconData = Icons.science;
                      break;
                    case 'sports':
                      iconData = Icons.sports_basketball;
                      break;
                    case 'technology':
                      iconData = Icons.computer;
                      break;
                    default:
                      iconData = Icons.newspaper;
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsInCategoryPage(
                            category: category['category'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2.0,
                      color: Color.fromARGB(255, 246, 222, 255),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(iconData,
                                size: 40.0,
                                color: Color.fromARGB(222, 62, 17, 85)),
                            SizedBox(height: 8.0),
                            Text(
                              category['category'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 61, 0, 96)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
