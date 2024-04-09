import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsDetailsPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 252, 246, 255),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 236, 201, 255),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news['title'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 61, 0, 96),
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      news['description'] ?? '',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author: ${news['author'] ?? 'Unknown'}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Published At: ${news['publishedAt'] ?? 'Unknown'}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14.0),
                    ),
                    SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: () {
                        launch(news['url']);
                      },
                      child: Text(
                        'URL: ${news['url'] ?? 'Unknown'}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 49, 90),
                          decoration: TextDecoration.underline,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Divider(color: Colors.grey),
                    // เพิ่มสีให้กับ Divider
                    SizedBox(height: 16.0),
                    if (news['content'] != null && news['content'] != '') ...[
                      Text(
                        'Content:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        news['content'] ?? '',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
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
