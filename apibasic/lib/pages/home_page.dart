import 'dart:convert';
import 'package:apibasic/services/product_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Product> products = [];
  Future<void> fetchData() async {
    final url = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      setState(() {
        products = jsonData.map((e) => Product.fromJson(e)).toList();
      });
    } else {
      print("Api Error ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api's fetched"),
      ),
      body: products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  child: ListTile(
                    leading:
                        Image.network(product.image, width: 50, height: 50),
                    title: Text(product.title),
                    subtitle: Text("₹${product.price.toString()}"),
                  ),
                );
              },
            ),
    );
  }
}
