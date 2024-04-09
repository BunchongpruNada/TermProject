import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'newdetail.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _newsList = [];
  TextEditingController _searchController = TextEditingController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews({String? query}) async {
    final apiKey = '2bbf86bd3cb84970bce35349acc91214';
    String url =
        'https://newsapi.org/v2/top-headlines?country=th&apiKey=$apiKey';

    if (query != null && query.isNotEmpty) {
      url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
    }

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _newsList = jsonData['articles'];
        });

        // Save news data to JSON file
        _saveToJsonFile(jsonData['articles']);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  Future<void> _saveToJsonFile(List<dynamic> newsData) async {
    try {
      final file = File('news.json');
      await file.writeAsString(json.encode(newsData));
      print('News data saved to file');
    } catch (e) {
      print('Error saving news data to file: $e');
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

  void _clearSearch() {
    _searchController.clear();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // พื้นหลังของช่องค้นหา
            padding: EdgeInsets.all(8.0),
            color: Color.fromARGB(255, 246, 193, 255).withOpacity(0.25),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search news...',
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 138, 119, 142)),
                      contentPadding: EdgeInsets.only(left: 14.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Color.fromARGB(222, 62, 17, 85),
                  onPressed: () {
                    fetchNews(query: _searchController.text);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  color: Color.fromARGB(222, 62, 17, 85),
                  onPressed: _clearSearch,
                ),
              ],
            ),
          ),
          Expanded(
            child: _newsList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _newsList.length,
                    itemBuilder: (context, index) {
                      final article = _newsList[index];
                      return Card(
                        // พื้นหลังของแต่ละข่าว
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          title: Text(
                            article['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 61, 0, 96)),
                          ),
                          subtitle: Text(article['description'] ?? ''),
                          onTap: () {
                            _showNewsDetails(article);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
