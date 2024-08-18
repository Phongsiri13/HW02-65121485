import 'package:flutter/material.dart';
import 'package:flutter_m5_w9/components/product_detail.dart';
import 'package:flutter_m5_w9/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW02-65121485',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Product> products = []; // กำหนดค่าเริ่มต้นเป็นลิสต์ว่างเปล่า
  bool isLoading = true; // สถานะการโหลดข้อมูล

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.https("fakestoreapi.com", "products");
    var response = await http.get(url);

    setState(() {
      final List<dynamic> jsonList = jsonDecode(response.body); // ข้อมูลที่ได้มาเป็นลิสต์
      products = jsonList.map((json) => Product.fromJson(json)).toList(); // แปลงข้อมูลเป็น List<Product>
      isLoading = false; // โหลดข้อมูลเสร็จแล้ว
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IT@WU Shop"),
      ),
      body: isLoading
        ? Center(child: CircularProgressIndicator()) // แสดง loading ขณะดึงข้อมูล
        : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            Product product = products[index];
            var imgUrl = product.image;
            return ListTile(
              title: Text(product.title),
              subtitle: Text("\$${product.price}"),
              leading: AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(imgUrl),
              ),
              onTap: () {
                print("Click on ${product.id}");
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Details(),
                settings: RouteSettings(
                  arguments: product
                )));
              },
            );
          }
      ),
    );
  }
}
