import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGPTPage extends StatefulWidget {
  @override
  _ChatGPTPageState createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final TextEditingController apikey_controller = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController venue = TextEditingController();
  final TextEditingController speaker = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController additional = TextEditingController();
  final TextEditingController price = TextEditingController();
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

  //This function will call when we press generate event description button
  void onSendMessage() {
     setState(() {
        apiKey = apikey_controller.text.trim();
      });
    String message = "I’m event organizer and you are a creative writer. You have to write creative event description for me. Make sure to add SEO friendly words. Here are the details of event."+
"Name of event:  "+name.text.trim()+
"Date :"+date.text.trim()+
"Time :"+time.text.trim()+
"Location:"+venue.text.trim()+
"Key-Speaker :"+speaker.text.trim()+
"Category : "+date.text.trim()+
"Ticket Price : "+price.text.trim()+
"Additional Information : "+additional.text.trim();
    name.clear();
    date.clear();
    time.clear();
    venue.clear();
    speaker.clear();
    category.clear();
    additional.clear();
    price.clear();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

              //API KEY

              TextField(
                  controller: apikey_controller,
                  decoration: InputDecoration(
                    hintText: 'Enter API Key...',
                  ),
                ),
            
              TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Name...',
                  ),
                ),
              
                //Date
                 TextField(
                  controller: date,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Date...',
                  ),
                ),
              
                //Time
              
                 TextField(
                  controller: time,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Time...',
                  ),
                ),
              
                //Location
                  TextField(
                  controller: venue,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Location...',
                  ),
                ),
      
                //Speaker
      
                TextField(
                  controller: speaker,
                  decoration: InputDecoration(
                    hintText: 'Enter Key Speaker/Performer...',
                  ),
                ),

                //price

                TextField(
                  controller: price,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Ticket Price...',
                  ),
                ),
      
                //Category
                TextField(
                  controller: category,
                  decoration: InputDecoration(
                    hintText: 'Enter Event Category...',
                  ),
                ),

                //Additional Details
                TextField(
                  controller: additional,
                  decoration: InputDecoration(
                    hintText: 'Enter Additional Details...',
                  ),
                ),
                
      
                 SizedBox(height: 20),
          //Button
                
            ElevatedButton(
              onPressed: onSendMessage,
              child: Text('Generate Event Description'),
            ),
            SizedBox(height: 20),
      
            //Respone
      
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