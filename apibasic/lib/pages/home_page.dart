import 'dart:convert';

import 'package:apibasic/services/user_post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  Future<void> fetchData() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        user = User.fromJson(data);
      });
      print(data);
    } else {
      print("Api Error ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api's Fetch"),
      ),
      body: user == null
          ? CircularProgressIndicator()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user!.userId.toString()),
                Text(user!.id.toString()),
                Text(user!.title.toString()),
                Text(user!.body.toString())
              ],
            ),
    );
  }
}
