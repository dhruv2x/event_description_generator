import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGPTPage extends StatefulWidget {
  @override
  _ChatGPTPageState createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final TextEditingController apikeyController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController venueController = TextEditingController();
  final TextEditingController speakerController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController additionalController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String _response = '';
  String apiKey = '';

  Future<String> sendMessageToChatGpt(String message) async {
    // Replace 'YOUR_API_KEY' with your actual ChatGPT API key
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": "You are a user."},
        {"role": "user", "content": message}
      ],
      "max_tokens": 350,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: json.encode(body),
    );

    print(response.body);

    Map<String, dynamic> parsedResponse = json.decode(response.body);

    String reply = parsedResponse['choices'][0]['message']['content'];
    return reply;
  }

  void onSendMessage() {
    setState(() {
      apiKey = apikeyController.text.trim();
    });
    String message =
        "I’m an event organizer, and you are a creative writer. You have to write a creative event description for me. Make sure to add SEO-friendly words. Here are the details of the event.\n" +
            "Name of the event: ${nameController.text.trim()}\n" +
            "Date: ${dateController.text.trim()}\n" +
            "Time: ${timeController.text.trim()}\n" +
            "Location: ${venueController.text.trim()}\n" +
            "Key Speaker: ${speakerController.text.trim()}\n" +
            "Category: ${categoryController.text.trim()}\n" +
            "Ticket Price: ${priceController.text.trim()}\n" +
            "Additional Information: ${additionalController.text.trim()}";

    nameController.clear();
    dateController.clear();
    timeController.clear();
    venueController.clear();
    speakerController.clear();
    categoryController.clear();
    additionalController.clear();
    priceController.clear();

    sendMessageToChatGpt(message).then((response) {
      setState(() {
        _response = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Description Generator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: apikeyController,
              decoration: InputDecoration(
                labelText: 'API Key',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Event Date',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Event Time',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: venueController,
              decoration: InputDecoration(
                labelText: 'Event Location',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: speakerController,
              decoration: InputDecoration(
                labelText: 'Key Speaker/Performer',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Ticket Price',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Event Category',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            TextField(
              controller: additionalController,
              decoration: InputDecoration(
                labelText: 'Additional Details',
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSendMessage,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Generate Event Description',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _response,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatGPTPage(),
  ));
}
