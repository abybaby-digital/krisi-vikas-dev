import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/screens/Iffco/IFFCO_Counter/IFFCO_Counter_List.dart';

import '../../services/save_user_info.dart';
import 'Product_Model.dart';


class IFFCO_Product_Screen extends StatefulWidget {
  @override
  _IFFCO_Product_ScreenState createState() => _IFFCO_Product_ScreenState();
}

class _IFFCO_Product_ScreenState extends State<IFFCO_Product_Screen> {
  late List<Product> products;
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    products = [];
    filteredProducts = List.from(products);
    // Call a method here to populate the products list from the URL
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      var response = await http.post(
        Uri.parse(baseUrl+iffco_product),
        body: jsonEncode(
          {},
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> productsJson = jsonData['data'];

        List<Product> parsedProducts = productsJson.map((json) => Product.fromJson(json)).toList();

        setState(() {
          products = parsedProducts;
          filteredProducts = List.from(products);
        });
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error accordingly
    }
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) => product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IFFCO Products'),
        centerTitle: true,
        backgroundColor: darkgreen,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterProducts,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.shade100,
                  hintText: "Search IFFCO Products",
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IFFCO_Counter_List()));
                  },
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          product.productImage,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.productName,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
