import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(const SendrApp());
}

class SendrApp extends StatelessWidget {
  const SendrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sendr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: const SendSMSPage(),
    );
  }
}

class SendSMSPage extends StatefulWidget {
  const SendSMSPage({Key? key}) : super(key: key);

  @override
  _SendSMSPageState createState() => _SendSMSPageState();
}

class _SendSMSPageState extends State<SendSMSPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final Telephony telephony = Telephony.instance;

  void _sendSMS() async {
    try {
      await telephony.sendSms(
        to: _phoneController.text,
        message: _messageController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS Sent')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send SMS: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SendR',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.7,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 7.0, // Add shadow below the AppBar
        shadowColor: Colors.black.withOpacity(1), // Adjust shadow color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.black.withOpacity(0.5),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  filled: true, // Ensure the background is filled
                  fillColor: Colors.white, // Set the fill color to white
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.black.withOpacity(0.5),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your text',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.message),
                  filled: true, // Ensure the background is filled
                  fillColor: Colors.white, // Set the fill color to white
                ),
                keyboardType: TextInputType.text,
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 20),
            Center( // Center the button horizontally
              child: SizedBox(
                width: 150, // Set the width to your desired value
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: _sendSMS,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Send'),
                      SizedBox(width: 8), // Spacing between text and icon
                      Icon(Icons.send),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
