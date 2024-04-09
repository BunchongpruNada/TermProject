import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {
  List<dynamic> _sources = [];

  @override
  void initState() {
    super.initState();
    fetchSources();
  }

  Future<void> fetchSources() async {
    final apiKey =
        '2bbf86bd3cb84970bce35349acc91214'; // ใส่ API Key ของคุณที่นี่
    final url = 'https://newsapi.org/v2/sources?apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _sources = jsonData['sources'];
        });
      } else {
        throw Exception('Failed to load sources');
      }
    } catch (e) {
      print('Error fetching sources: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sources.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: _sources.length,
              separatorBuilder: (context, index) =>
                  Divider(), // เพิ่มเส้นคั่นระหว่างไอเทม
              itemBuilder: (context, index) {
                final source = _sources[index];
                return ListTile(
                  leading: Icon(
                    Icons.domain,
                    color: Color.fromARGB(222, 62, 17, 85),
                  ), // ไอคอนสำหรับสำนักพิมพ์
                  title: Text(
                    source['name'],
                    style: TextStyle(color: Color.fromARGB(222, 62, 17, 85)),
                  ),
                );
              },
            ),
    );
  }
}
