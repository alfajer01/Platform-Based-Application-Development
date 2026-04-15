import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Product.dart';

void main() => runApp(const MyApp12());

class MyApp12 extends StatefulWidget {
  const MyApp12({super.key});

  @override
  State<MyApp12> createState() => _MyApp12State();
}

Future<List<Product>> fetchProduct() async {
  final res = await http.get(
    Uri.parse('http://192.168.1.3:8027/api/product'),
  );

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body) as List<dynamic>;
    return data
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}

class _MyApp12State extends State<MyApp12> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tutorial 5.1 - Networking'),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Gagal mengambil data product.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              final items = snapshot.data ?? [];

              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada data product',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 24,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final product = items[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Harga: Rp${product.price}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (product.variants.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'Variants:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ...product.variants.map(
                              (variant) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '- ${variant.name} (+Rp${variant.additionalPrice})',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
