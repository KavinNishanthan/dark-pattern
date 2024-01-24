// main.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(apiService: _apiService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ApiService apiService;

  const MyHomePage({Key? key, required this.apiService}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController urlController = TextEditingController();
  Map<String, dynamic> apiResponse = {};
  bool isLoading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Row(
    children: [
      Text(
        'Cyber',
        style: TextStyle(color: Colors.black),
      ),
      Text(
        'S',
        style: TextStyle(color: Colors.green),
      ),
      Text(
        'afe',
        style: TextStyle(color: Colors.black),
      ),
    ],
  ),backgroundColor: Colors.blue,
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'Enter URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _checkWebsite(urlController.text);
              },
              child: Text('Check Website'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (error.isNotEmpty)
              Text('Error: $error', style: TextStyle(color: Colors.red))
            else if (apiResponse.isNotEmpty) 
              RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: 'Response:\n',
                          style: TextStyle(decoration: TextDecoration.none,fontSize: 30.0,fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '\n${apiResponse["result"][1]}',
                          style: TextStyle(decoration: TextDecoration.none,fontSize: 16.0, color: Colors.green), // Adjust the font size for the second line in red
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _checkWebsite(String url) async {
    try {
      setState(() {
        isLoading = true;
        error = ''; // Clear any previous errors
      });

      final result = await widget.apiService.checkWebsite(url);
      setState(() {
        apiResponse = result;
      });

      // Handle the result and update the UI
      print(result);
    } catch (e) {
      setState(() {
        error = 'Failed to check website';
      });
      // Handle errors
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
