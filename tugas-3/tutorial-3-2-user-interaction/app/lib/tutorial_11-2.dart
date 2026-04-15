// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp11_2());
}

class MyApp11_2 extends StatelessWidget {
  const MyApp11_2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABP Minggu 3',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'ABP Minggu 3'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> data = [
    {
      'title': 'Native App',
      'platform': 'Android, iOS',
      'lang': 'Java, Kotlin, Swift, C#',
      'color': Colors.red,
    },
    {
      'title': 'Hybrid App',
      'platform': 'Android, iOS, Web',
      'lang': 'Javascript, Dart',
      'color': Colors.grey,
    },
  ];

  final titleInput = TextEditingController();
  final platInput = TextEditingController();
  final langInput = TextEditingController();
  final List<String> colors = ['blue', 'green', 'yellow'];
  final List<DropdownMenuItem<String>> ddItems = [];
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    for (final col in colors) {
      ddItems.add(
        DropdownMenuItem<String>(
          value: col,
          child: Text(col),
        ),
      );
    }
  }

  @override
  void dispose() {
    titleInput.dispose();
    platInput.dispose();
    langInput.dispose();
    super.dispose();
  }

  Color resolveColor(String? colorName) {
    switch (colorName) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: data[index]['color'] as Color,
                      ),
                      const SizedBox(width: 15),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40, left: 10, top: 10),
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['title'] as String,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Detail'),
                        content: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 40, left: 10, top: 10),
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  data[index]['platform'] as String,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  data[index]['lang'] as String,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Add new tech?'),
            action: SnackBarAction(
              label: 'Add',
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Add New Tech'),
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Tech Name',
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Tech Name',
                              ),
                              controller: titleInput,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Platform',
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Platform',
                              ),
                              controller: platInput,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Lang',
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Lang',
                              ),
                              controller: langInput,
                            ),
                            DropdownButtonFormField<String>(
                              items: ddItems,
                              onChanged: (val) {
                                setState(() {
                                  selectedColor = val;
                                });
                              },
                            ),
                            ElevatedButton(
                              child: const Text('Save'),
                              onPressed: () {
                                setState(() {
                                  data.add({
                                    'title': titleInput.text,
                                    'platform': platInput.text,
                                    'lang': langInput.text,
                                    'color': resolveColor(selectedColor),
                                  });
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}